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
#import "RSSTableViewItemCell.h"
#import "RSSConstants.h"

@implementation RSSFeedViewController
@synthesize dataSourse = _dataSourse;
@synthesize feedDataService = _feedDataService;

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self setupUI];
  
  __weak __typeof(self) weakSelf = self;
  [self.feedDataService feedAsync:^(NSArray *result) {
    [weakSelf.dataSourse setFeed:result];
    [weakSelf.tableView reloadData];
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

- (void)setupUI {
  
  self.tableView.estimatedRowHeight = 500;
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  
  [self.tableView registerClass:[RSSTableViewItemCell class] forCellReuseIdentifier:kCellItemIdentifier];
  
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
}

#pragma mark - UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return [self.dataSourse number];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  RSSTableViewItemCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellItemIdentifier];
  [cell setFeedItem:[self.dataSourse objectAtIndexPath:indexPath]];
  return cell;
}

@end
