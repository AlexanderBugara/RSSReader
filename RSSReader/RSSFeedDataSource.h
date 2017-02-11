//
//  RSSDataSource.h
//  RSSReader
//
//  Created by Alexander on 2/10/17.
//  Copyright © 2017 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RSSItem, RSSFeed;

@protocol RSSDataSourceProtocol <NSObject>
- (void)setFeed:(RSSFeed *)feed complition:(void(^)(void))complition;
- (NSUInteger)number;
- (RSSItem *)objectAtIndexPath:(NSIndexPath *)indexPath;
- (NSURL *)urlAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)tittleAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)descriptionAtIndexPath:(NSIndexPath *)indexPath;
- (NSDate *)dateAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface RSSFeedDataSource : NSObject<RSSDataSourceProtocol>
@property (nonatomic, copy, readonly) NSString *feedTitle;
@end
