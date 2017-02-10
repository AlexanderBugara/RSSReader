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

@implementation RSSFeedDataService
@synthesize networkManager = _networkManager;
@synthesize urlConstructor = _urlConstructor;
@synthesize persistentStorage = _persistentStorage;

- (void)feedAsync:(void(^)(NSArray *result))complitionHandler {
  
  
  __weak __typeof(self) weakSelf = self;
  [self.persistentStorage feedAsync:^(NSArray *result) {
    [weakSelf.persistentStorage feedClearAsync:result complition:^{
      [self.networkManager networkRequest:[self.urlConstructor feedUrl]
                         complitinHendler:^(NSData *data, NSError *error) {
                           
                           SMXMLDocument *document = [SMXMLDocument documentWithData:data error:&error];
                           
                           __weak __typeof(self) weakSelf = self;
                           
                           [self.persistentStorage save:document mapper:[[RSSMapper new] autorelease] complitionHandler:^{
                             [weakSelf.persistentStorage feedAsync:^(NSArray *result) {
                               
                             }];
                           }];
                           
                         }];
    }];
  }];
  
 
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
