//
//  RSSTableViewItemCell.h
//  RSSReader
//
//  Created by Alexander on 2/10/17.
//  Copyright © 2017 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RSSItem;

@interface RSSTableViewItemCell : UITableViewCell
- (void)setFeedItem:(RSSItem *)item;
@end
