//
//  RSSDataService.h
//  RSSReader
//
//  Created by Alexander on 2/10/17.
//  Copyright © 2017 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RSSNetworkManager, RSSURLConstructor;
@protocol RSSPersistentStorageProtocol;

@interface RSSFeedDataService : NSObject
- (void)feedAsync:(void(^)(NSArray *result))complitionHandler;

@property (nonatomic, retain, readonly) RSSNetworkManager *networkManager;
@property (nonatomic, retain, readonly) RSSURLConstructor *urlConstructor;
@property (nonatomic, retain, readonly) id <RSSPersistentStorageProtocol> persistentStorage;
@end
