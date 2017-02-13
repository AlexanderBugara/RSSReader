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
#import "RSSFeed.h"

@implementation RSSFeedDataService
@synthesize networkManager = _networkManager;
@synthesize urlConstructor = _urlConstructor;
@synthesize persistentStorage = _persistentStorage;
@synthesize dataSource = _dataSource;

- (void)feedUpdateIfNeedItAsync:(void(^)(NSError *error))complitionHandler {
  
  Sequencer *sequencer = [[Sequencer alloc] init];
  
   __weak __typeof(self) weakSelf = self;
  
  [sequencer enqueueStep:^(id result, SequencerCompletion completion) {
    [weakSelf.networkManager networkRequest:[weakSelf.urlConstructor feedUrl]
                       complitinHendler:^(NSData *data, NSError *error) {
                         if (error) complitionHandler(error);
                         else completion(data);
                       }];
  }];
  
  [sequencer enqueueStep:^(id result, SequencerCompletion completion) {
    NSError *error;
    SMXMLDocument *document = [SMXMLDocument documentWithData:result error:&error];
    
    if (error)  complitionHandler(error);
    else completion(document);
  }];
  
  [sequencer enqueueStep:^(id result, SequencerCompletion completion) {
    
    [weakSelf.persistentStorage feedAsync:^(RSSFeed *feed) {
      [weakSelf.persistentStorage feedClearAsync:feed complition:^{
        completion(result);
      }];
    }];
    
    
  }];
  
  [sequencer enqueueStep:^(id result, SequencerCompletion completion) {
    [weakSelf.persistentStorage save:result mapper:[[RSSMapper new] autorelease] complitionHandler:^{
      completion(nil);
    }];
  }];
  
  [sequencer enqueueStep:^(id result, SequencerCompletion completion) {
    [weakSelf.persistentStorage feedAsync:^(RSSFeed *feed) {
      completion(feed);
    }];
  }];
  
  [sequencer enqueueStep:^(id result, SequencerCompletion completion) {
    [weakSelf.dataSource setFeed:result complition:^{
      complitionHandler(nil);
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
  
  _dataSource = nil;
  [super dealloc];
}

- (void)feedCashed:(void(^)(RSSFeed *result))complitionHandler {
  [self.persistentStorage feedAsync:^(RSSFeed *feed) {
    complitionHandler(feed);
  }];
}

- (instancetype)initWithDataSource:(id <RSSDataSourceProtocol>) dataSource {
  if (self = [super init]) {
    _dataSource = dataSource;
  }
  return self;
}

- (instancetype)init {
  [self release];
  @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                 reason:@"-init is not a valid initializer for the class RSSFeedDataService"
                               userInfo:nil];
  return nil;
}

- (void)getDataSourceOnlineIfNeedIt:(void(^)(NSError *error))complitionHandler {
  __weak __typeof(self) weakSelf = self;

  Sequencer *sequencer = [[Sequencer alloc] init];
  
  [sequencer enqueueStep:^(id result, SequencerCompletion completion) {
    [self.persistentStorage feedAsync:^(RSSFeed *feed) {
      if (feed) {
        [weakSelf.dataSource setFeed:feed complition:^{
          complitionHandler(nil);
        }];
      } else {
        completion(feed);
      }
    }];
  }];

  [sequencer enqueueStep:^(id result, SequencerCompletion completion) {
    [weakSelf.networkManager networkRequest:[weakSelf.urlConstructor feedUrl]
                       complitinHendler:^(NSData *data, NSError *error) {
                         if (error) complitionHandler(error);
                         else completion(data);
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
    [weakSelf.persistentStorage feedAsync:^(RSSFeed *feed) {
      completion(feed);
    }];
  }];
  
  [sequencer enqueueStep:^(id result, SequencerCompletion completion) {
    [weakSelf.dataSource setFeed:result complition:^{
      complitionHandler(nil);
    }];
  }];
  [sequencer run];
  
}
@end
