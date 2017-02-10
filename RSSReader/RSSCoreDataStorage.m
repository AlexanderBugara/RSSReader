//
//  RSSPersistentStorage.m
//  RSSReader
//
//  Created by Alexander on 2/10/17.
//  Copyright © 2017 Home. All rights reserved.
//

#import "RSSCoreDataStorage.h"
#import "RSSConstants.h"
#import "SMXMLDocument.h"
#import "RSSMaperProtocol.h"
#import "RSSItem.h"

@implementation RSSCoreDataStorage
- (void)save:(SMXMLDocument *)document 
       mapper:(id<RSSMapperProtocol>)maper
complitionHandler:(void(^)(void))complitionHandler {
  
  SMXMLElement *channel = [document.root childNamed:kFeedKey];
  
  NSManagedObjectContext *private = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
  [private setParentContext:self.managedObjectContext];
  
  
  __weak NSManagedObjectContext *weakMainQueueContext = self.managedObjectContext;
  [private performBlock:^{
    
    for (SMXMLElement *xmlObject in channel.children) {
      if (![xmlObject.name isEqualToString:kItem]) continue;
      
      RSSItem *item = (RSSItem *)[NSEntityDescription insertNewObjectForEntityForName:kItemEntity
                                                               inManagedObjectContext:private];
      [maper map:xmlObject to:item];
    }
    
    
    NSError *error = nil;
    if (![private save:&error]) {
      NSLog(@"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
      abort();
    }
    [weakMainQueueContext performBlockAndWait:^{
      NSError *error = nil;
      if (![weakMainQueueContext save:&error]) {
        NSLog(@"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
      }
      
      complitionHandler();
    }];
  }];
}


- (void)feedAsync:(void(^)(NSArray *result))complitionBlock {
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:kItemEntity];
  [[NSAsynchronousFetchRequest alloc] initWithFetchRequest:fetchRequest
                                           completionBlock:^(NSAsynchronousFetchResult * _Nonnull result) {
                                             if (result.finalResult) {
                                               complitionBlock(result.finalResult);
                                             }
  }];
}

- (void)feedClearAsync:(NSArray *)feed complition:(void(^)(void))complitionBlock {
  
  NSManagedObjectContext *private = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
  [private setParentContext:self.managedObjectContext];
  
  __weak NSManagedObjectContext *weakMainQueueContext = self.managedObjectContext;
  [private performBlock:^{
    
    for (RSSItem *item in feed) {
      RSSItem *privateItem = [weakMainQueueContext objectWithID:[item objectID]];
      [private deleteObject:privateItem];
    }
    
    NSError *error = nil;
    if (![private save:&error]) {
      NSLog(@"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
      abort();
    }
    [weakMainQueueContext performBlockAndWait:^{
      NSError *error = nil;
      if (![weakMainQueueContext save:&error]) {
        NSLog(@"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
      }
      
      complitionBlock();
    }];
  }];

//  [context performBlock:^{
//    [context deleteObject:m];
//    
//    if (![context save:&error]) {
//      //Note: You should really do something more useful than log this
//      NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
//    }
//  }];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
  // The directory the application uses to store the Core Data store file. This code uses a directory named "com.exs.application.To_delete" in the application's documents directory.
  return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
  // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
  if (_managedObjectModel != nil) {
    return _managedObjectModel;
  }
  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"RSSReader" withExtension:@"momd"];
  _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
  return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
  // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
  if (_persistentStoreCoordinator != nil) {
    return _persistentStoreCoordinator;
  }
  
  // Create the coordinator and store
  
  _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
  NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"RSSReader.sqlite"];
  NSError *error = nil;
  NSString *failureReason = @"There was an error creating or loading the application's saved data.";
  if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
    // Report any error we got.
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
    dict[NSLocalizedFailureReasonErrorKey] = failureReason;
    dict[NSUnderlyingErrorKey] = error;
    error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
    // Replace this with code to handle the error appropriately.
    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    abort();
  }
  
  return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
  // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
  if (_managedObjectContext != nil) {
    return _managedObjectContext;
  }
  
  NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
  if (!coordinator) {
    return nil;
  }
  _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
  [_managedObjectContext setPersistentStoreCoordinator:coordinator];
  return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
  NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
  if (managedObjectContext != nil) {
    NSError *error = nil;
    if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
      // Replace this implementation with code to handle the error appropriately.
      // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
      abort();
    }
  }
}


@end
