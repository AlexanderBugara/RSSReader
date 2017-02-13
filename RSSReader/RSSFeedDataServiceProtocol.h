//
//  RSSFeedDataServiceProtocol.h
//  RSSReader
//
//  Created by Alexander on 2/13/17.
//  Copyright © 2017 Home. All rights reserved.
//

#ifndef RSSFeedDataServiceProtocol_h
#define RSSFeedDataServiceProtocol_h

@class RSSFeed;
@protocol RSSDataSourceProtocol;

@protocol RSSFeedDataServiceProtocol <NSObject>
- (instancetype)initWithDataSource:(id <RSSDataSourceProtocol>) dataSource;
- (void)updateDataSourceOffline:(void(^)(void))complitionHandler;
- (void)updateDataSourceOnlineIfNeedIt:(void(^)(void))complitionHandler;
@end
#endif /* RSSFeedDataServiceProtocol_h */
