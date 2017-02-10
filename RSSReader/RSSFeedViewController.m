//
//  RSSViewController.m
//  RSSReader
//
//  Created by Alexander on 2/9/17.
//  Copyright © 2017 Home. All rights reserved.
//

#import "RSSFeedViewController.h"
#import "RSSFeedDataSource.h"
#import "RSSFeedDataService.h"

@implementation RSSFeedViewController
@synthesize dataSourse = _dataSourse;
@synthesize feedDataService = _feedDataService;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.feedDataService feedAsync:^(NSArray *result) {
      
    }];
}

- (RSSFeedDataSource *)dataSourse {
  if (!_dataSourse) {
    _dataSourse = [RSSFeedDataSource new];
  }
  return _dataSourse;
}

- (RSSFeedDataService *)feedDataService {
  if (!_feedDataService) {
    _feedDataService = [RSSFeedDataService new];
  }
  return _feedDataService;
}

- (void)dealloc {
  [_dataSourse release];
  _dataSourse = nil;
  [_feedDataService release];
  _feedDataService = nil;
  [super dealloc];
}

@end
