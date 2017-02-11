//
//  RSSViewController.h
//  RSSReader
//
//  Created by Alexander on 2/9/17.
//  Copyright © 2017 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSLoadingProtocol.h"

@class RSSFeedDataService, RSSFeedDataSource;


@interface RSSFeedViewController : UITableViewController<RSSLoadingProtocol>
@property (nonatomic, retain, readonly) RSSFeedDataService *feedDataService;
@property (nonatomic, retain, readonly) RSSFeedDataSource *dataSourse;
@end
