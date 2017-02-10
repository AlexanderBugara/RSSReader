//
//  RSSPersistentStorage.h
//  RSSReader
//
//  Created by Alexander on 2/10/17.
//  Copyright © 2017 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSSPersistentStorageProtocol.h"
#import <CoreData/CoreData.h>

@interface RSSCoreDataStorage : NSObject<RSSPersistentStorageProtocol>

@property (readonly, retain, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, retain, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, retain, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (void)feedAsync:(void(^)(NSArray *result))complitionBlock;

@end
