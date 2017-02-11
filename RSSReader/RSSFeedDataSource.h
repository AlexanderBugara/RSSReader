//
//  RSSDataSource.h
//  RSSReader
//
//  Created by Alexander on 2/10/17.
//  Copyright © 2017 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RSSItem;

@protocol RSSDataSourceProtocol <NSObject>
- (void)setFeed:(NSArray *)feed;
- (NSUInteger)number;
- (RSSItem *)objectAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface RSSFeedDataSource : NSObject<RSSDataSourceProtocol>

@end
