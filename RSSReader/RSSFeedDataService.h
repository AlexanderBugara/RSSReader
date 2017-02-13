//
//  RSSDataService.h
//  RSSReader
//
//  Created by Alexander on 2/10/17.
//  Copyright © 2017 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSSFeedDataServiceProtocol.h"
#import "RSSDataSourceProtocol.h"


@class RSSNetworkManager, RSSURLConstructor, RSSFeed;
@protocol RSSPersistentStorageProtocol;

@interface RSSFeedDataService : NSObject<RSSFeedDataServiceProtocol>
@property (nonatomic, retain, readonly) RSSNetworkManager *networkManager;
@property (nonatomic, retain, readonly) RSSURLConstructor *urlConstructor;
@property (nonatomic, retain, readonly) id <RSSPersistentStorageProtocol> persistentStorage;
@property (nonatomic, assign, readonly) id <RSSDataSourceProtocol> dataSource;
@end
