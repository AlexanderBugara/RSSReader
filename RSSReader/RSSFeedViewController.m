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


@interface RSSFeedViewController()
@property (assign) BOOL isLoadingInProgress;
@end

@implementation RSSFeedViewController
@synthesize dataSourse = _dataSourse;
@synthesize feedDataService = _feedDataService;


- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self setupUI];
  
  [self beginLoading];
  [self updateTable];
  __weak __typeof(self) weakSelf = self;
  [self.feedDataService getDataSourceOnlineIfNeedIt:^(NSError *error) {
    
    [weakSelf endLoading];
    [weakSelf updateTable];
    
    if (error) [weakSelf presentAlert:error];
  }];
  
}

- (void)beginLoading {
  self.isLoadingInProgress = YES;
  self.navigationItem.title = NSLocalizedString(@"Loading...", @"Loading...");
}

- (void)endLoading {
  self.isLoadingInProgress = NO;
  self.navigationItem.title = ([self.dataSourse.feedTitle length] > 0)?self.dataSourse.feedTitle:@"";
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
  UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
  self.refreshControl = refreshControl;
  [refreshControl release];
  self.refreshControl.backgroundColor = [UIColor whiteColor];
  self.refreshControl.tintColor = [UIColor grayColor];
  [self.refreshControl addTarget:self
                          action:@selector(updateData:)
                forControlEvents:UIControlEventValueChanged];
}

#pragma mark - Pull to refresh action

- (void)updateData:(id)sender {
  if (self.isLoadingInProgress) return;
  
  __weak __typeof(self) weakSelf = self;
  
  [self beginLoading];
  [self.feedDataService feedUpdateIfNeedItAsync:^(NSError *error) {
    [(UIRefreshControl *)sender endRefreshing];
    [weakSelf endLoading];
    [weakSelf updateTable];
    if (error) [weakSelf presentAlert:error];
  }];
}

#pragma mark - UITableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  
  if ([self.dataSourse number] == 0 && !self.isLoadingInProgress) {
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    messageLabel.text = @"No data is currently available. Please pull down to refresh.";
    messageLabel.textColor = [UIColor blackColor];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont fontWithName:@"Palatino-Italic" size:20];
    [messageLabel sizeToFit];
    
    self.tableView.backgroundView = messageLabel;
    [messageLabel release];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
  } else {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    return 1;
  }
  
  return 0;
}

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
  [detailViewController release];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

  CGRect titleFrame = [[self.dataSourse tittleAtIndexPath:indexPath] boundingRectWithSize:CGSizeMake([self width] , CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
  
  CGRect descriptionFrame = [[self.dataSourse descriptionAtIndexPath:indexPath] boundingRectWithSize:CGSizeMake([self width] , CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
  
  return titleFrame.size.height + descriptionFrame.size.height + 20;
}

- (CGFloat)width {
  return self.view.frame.size.width;
}

- (void)updateTable {
  [self.tableView reloadData];
}

- (void)presentAlert:(NSError *)error {
  
  UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error")
                                                   message:[error localizedDescription]
                                                  delegate:nil
                                         cancelButtonTitle:NSLocalizedString(@"OK", @"OK")

                                         otherButtonTitles:nil] autorelease];
  [alert show];
}
@end
