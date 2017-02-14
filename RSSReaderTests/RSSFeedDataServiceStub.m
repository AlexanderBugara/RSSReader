//
//  RSSFeedDataServiceTest.m
//  RSSReader
//
//  Created by Alexander on 2/13/17.
//  Copyright © 2017 Home. All rights reserved.
//

#import "RSSFeedDataServiceStub.h"
#import <OCMockito/OCMockito.h>
#import "RSSNetworkManager.h"
#import "RSSURLConstructor.h"
#import "RSSCoreDataStorage.h"

@implementation RSSFeedDataServiceStub

- (RSSNetworkManager *)networkManager {
    NSURLSession *session = mock([NSURLSession class]);
    return [[RSSNetworkManager  alloc] initWithSession:session];
}

- (RSSURLConstructor *)urlConstructor {
  return mock([RSSURLConstructor class]);
}

- (id<RSSPersistentStorageProtocol>)persistentStorage {
  return mock([RSSCoreDataStorage class]);
}

@end
