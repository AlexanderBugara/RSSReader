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
#import "RSSDetailViewController.h"


@implementation RSSFeedViewController
@synthesize dataSourse = _dataSourse;
@synthesize feedDataService = _feedDataService;


- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self setupUI];
  
  [self startLoading];
  __weak __typeof(self) weakSelf = self;
  [self.feedDataService updateDataSourceOnlineIfNeedIt:^{
    [weakSelf stopLoading];
    [weakSelf.tableView reloadData];
  }];
  
}

- (void)startLoading {
  self.navigationItem.title = NSLocalizedString(@"Loading...", @"Loading...");
}

- (void)stopLoading {
  self.navigationItem.title = self.dataSourse.feedTitle;
}

- (RSSFeedDataSource *)dataSourse {
  if (!_dataSourse) {
    _dataSourse = [RSSFeedDataSource new];
  }
  return _dataSourse;
}

- (RSSFeedDataService *)feedDataService {
  if (!_feedDataService) {
    _feedDataService = [[RSSFeedDataService alloc] initWithDataSource:self.dataSourse];
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
  [self setupTable];
  [self setupPullToRefresh];
}

- (void)setupTable {
  self.tableView.estimatedRowHeight = 500;
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
}

- (void)setupPullToRefresh {
  self.refreshControl = [[UIRefreshControl alloc] init];
  self.refreshControl.backgroundColor = [UIColor purpleColor];
  self.refreshControl.tintColor = [UIColor whiteColor];
  [self.refreshControl addTarget:self
                          action:@selector(updateData:)
                forControlEvents:UIControlEventValueChanged];
}

#pragma mark - Pull to refresh action

- (void)updateData:(id)sender {
  
}

#pragma mark - UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return [self.dataSourse number];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  RSSTableViewItemCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellItemIdentifier];
  if (!cell)
     cell = [[[RSSTableViewItemCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellItemIdentifier] autorelease];
  
  [cell setFeedItem:[self.dataSourse objectAtIndexPath:indexPath]];
  return cell;
}

- (void)tableView:(UITableView *)tableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  RSSDetailViewController *detailViewController = [[RSSDetailViewController alloc] initWithURL:[self.dataSourse urlAtIndexPath:indexPath] title:[self.dataSourse tittleAtIndexPath:indexPath]];
  
  [self.navigationController pushViewController:detailViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

  CGRect titleFrame = [[self.dataSourse tittleAtIndexPath:indexPath] boundingRectWithSize:CGSizeMake([self width] , CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
  
  CGRect descriptionFrame = [[self.dataSourse descriptionAtIndexPath:indexPath] boundingRectWithSize:CGSizeMake([self width] , CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
  
  return titleFrame.size.height + descriptionFrame.size.height + 20;
}

- (CGFloat)width {
  return self.view.frame.size.width;
}
@end
