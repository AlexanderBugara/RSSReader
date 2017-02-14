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
#import "RSSFeed.h"

@interface RSSFeedDataSource()
@property (nonatomic, retain) NSArray *items;
@property (nonatomic, retain) RSSFeed *feed;
@end

@implementation RSSFeedDataSource

- (void)setFeed:(RSSFeed *)feed complition:(void(^)(void))complition {
  if (_feed != feed) {
    [_feed release];
    _feed = [feed retain];
    
    __weak __typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
      
      weakSelf.items = [[feed.items allObjects] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"pubDate" ascending:NO]]];
      
      dispatch_async(dispatch_get_main_queue(), ^(void){
        _feedTitle = [feed.title copy];
        complition();
      });
    });

  }
}

- (NSUInteger)number {
  return [self.items count];
}

- (RSSItem *)objectAtIndexPath:(NSIndexPath *)indexPath {
  return self.items[indexPath.row];
}

- (NSURL *)urlAtIndexPath:(NSIndexPath *)indexPath {
  RSSItem *item = self.items[indexPath.row];
  return [NSURL URLWithString:item.link];
}

- (NSString *)tittleAtIndexPath:(NSIndexPath *)indexPath {
  RSSItem *item = self.items[indexPath.row];
  return item.title;
}

- (NSString *)descriptionAtIndexPath:(NSIndexPath *)indexPath {
  RSSItem *item = self.items[indexPath.row];
  return item.description_;
}

- (void)dealloc {
  [_feed release];
  _feed = nil;
  [_feedTitle release];
  _feedTitle = nil;
  [super dealloc];
}

@end
