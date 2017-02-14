//
//  RSSDataSourceProtocol.h
//  RSSReader
//
//  Created by Alexander on 2/13/17.
//  Copyright © 2017 Home. All rights reserved.
//

#ifndef RSSDataSourceProtocol_h
#define RSSDataSourceProtocol_h


@class RSSItem, NSIndexPath, RSSFeed;


@protocol RSSDataSourceProtocol <NSObject>
- (void)setFeed:(RSSFeed *)feed complition:(void(^)(void))complition;
- (NSUInteger)number;
- (RSSItem *)objectAtIndexPath:(NSIndexPath *)indexPath;
- (NSURL *)urlAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)tittleAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)descriptionAtIndexPath:(NSIndexPath *)indexPath;
@end

#endif /* RSSDataSourceProtocol_h */
