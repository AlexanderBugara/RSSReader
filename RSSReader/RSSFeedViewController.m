//
//  RSSViewController.m
//  RSSReader
//
//  Created by Alexander on 2/9/17.
//  Copyright © 2017 Home. All rights reserved.
//

#import "RSSFeedViewController.h"
#import "RSSFeedDataSource.h"
#import "RSSFeedFacade.h"

@interface RSSFeedViewController ()
@property (strong, nonatomic, readonly) RSSFeedDataSource *dataSourse;
@property (strong, nonatomic, readonly) RSSFeedFacade *facade;
@end

@implementation RSSFeedViewController

- (instancetype)init {
  if (self = [super init]) {
    _facade = [RSSFeedFacade new];
    _dataSourse = [RSSFeedDataSource new];
  }
  return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.facade feedAsync:^{
      
    }];
  
}

- (void)dealloc {
  [super dealloc];
  [_dataSourse release];
  _dataSourse = nil;
  [_facade release];
  _facade = nil;
}

@end
