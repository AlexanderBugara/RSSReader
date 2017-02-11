//
//  RSSDataSource.m
//  RSSReader
//
//  Created by Alexander on 2/10/17.
//  Copyright © 2017 Home. All rights reserved.
//

#import "RSSFeedDataSource.h"
#import <UIKit/UIKit.h>
#import "RSSItem.h"


@interface RSSFeedDataSource()
@property (nonatomic, retain) NSArray *feed;
@end

@implementation RSSFeedDataSource

- (void)setFeed:(NSArray *)feed {
  if (_feed != feed) {
    [_feed release];
    _feed = [feed retain];
  }
}

- (NSUInteger)number {
  return [self.feed count];
}

- (RSSItem *)objectAtIndexPath:(NSIndexPath *)indexPath {
  return self.feed[indexPath.row];
}

- (NSURL *)urlAtIndexPath:(NSIndexPath *)indexPath {
  RSSItem *item = self.feed[indexPath.row];
  return [NSURL URLWithString:item.link];
}

- (NSString *)tittleAtIndexPath:(NSIndexPath *)indexPath {
  RSSItem *item = self.feed[indexPath.row];
  return item.title;
}

- (NSString *)descriptionAtIndexPath:(NSIndexPath *)indexPath {
  RSSItem *item = self.feed[indexPath.row];
  return item.description_;
}
@end
