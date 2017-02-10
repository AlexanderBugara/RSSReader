//
//  RSSDataService.m
//  RSSReader
//
//  Created by Alexander on 2/10/17.
//  Copyright © 2017 Home. All rights reserved.
//

#import "RSSFeedDataService.h"
#import "RSSNetworkManager.h"
#import "RSSURLConstructor.h"
#import "SMXMLDocument.h"
#import "RSSConstants.h"
#import "RSSPersistentStorageProtocol.h"
#import "RSSCoreDataStorage.h"
#import "RSSMapper.h"
#import "Sequencer.h"
#import "RSSItem.h"

@implementation RSSFeedDataService
@synthesize networkManager = _networkManager;
@synthesize urlConstructor = _urlConstructor;
@synthesize persistentStorage = _persistentStorage;

- (void)feedAsync:(void(^)(NSArray *result))complitionHandler {
  
  Sequencer *sequencer = [[Sequencer alloc] init];
  
   __weak __typeof(self) weakSelf = self;
  
  [sequencer enqueueStep:^(id result, SequencerCompletion completion) {
    [weakSelf.persistentStorage feedAsync:^(NSArray *result) {
      completion(result);
    }];
  }];
  
  [sequencer enqueueStep:^(id result, SequencerCompletion completion) {
    [weakSelf.persistentStorage feedClearAsync:result complition:^{
      completion(nil);
    }];
  }];
 
  
  [sequencer enqueueStep:^(id result, SequencerCompletion completion) {
    [self.networkManager networkRequest:[self.urlConstructor feedUrl]
                       complitinHendler:^(NSData *data, NSError *error) {
                         completion(data);
                       }];
  }];
  
  [sequencer enqueueStep:^(id result, SequencerCompletion completion) {
    NSError *error;
    SMXMLDocument *document = [SMXMLDocument documentWithData:result error:&error];
    completion(document);
  }];
  
  [sequencer enqueueStep:^(id result, SequencerCompletion completion) {
    [weakSelf.persistentStorage save:result mapper:[[RSSMapper new] autorelease] complitionHandler:^{
      completion(nil);
    }];
  }];
  
  [sequencer enqueueStep:^(id result, SequencerCompletion completion) {
    [weakSelf.persistentStorage feedAsync:^(NSArray *result) {
    
    }];
  }];
  
  
  [sequencer run];
  
}

- (RSSNetworkManager *)networkManager {
  if (!_networkManager) {
      _networkManager = [RSSNetworkManager  new];
  }
  return _networkManager;
}

- (RSSURLConstructor *)urlConstructor {
  if (!_urlConstructor) {
    _urlConstructor = [RSSURLConstructor new];
  }
  return _urlConstructor;
}

- (id<RSSPersistentStorageProtocol>)persistentStorage {
  
  if (!_persistentStorage) {
    _persistentStorage = [RSSCoreDataStorage new];
  }
  
  return _persistentStorage;
  
}

- (void)dealloc {
  
  [_urlConstructor release];
  _urlConstructor = nil;
  
  [_networkManager release];
  _networkManager = nil;
  
  [_persistentStorage release];
  _persistentStorage = nil;
  
  [super dealloc];
}

@end
