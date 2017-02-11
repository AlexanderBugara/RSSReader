//
//  RSSTableViewItemCell.m
//  RSSReader
//
//  Created by Alexander on 2/10/17.
//  Copyright © 2017 Home. All rights reserved.
//

#import "RSSTableViewItemCell.h"
#import "RSSItem.h"
#import "Masonry.h"

@interface RSSTableViewItemCell()
@property (nonatomic, assign) UILabel *title;
@property (nonatomic, assign) UILabel *description_;
@property (nonatomic, assign) UILabel *date;
@property (nonatomic, assign) BOOL layoutDidSet;
@end

@implementation RSSTableViewItemCell

- (void)setFeedItem:(RSSItem *)item {
  self.textLabel.text = item.title;
  self.detailTextLabel.text = item.description_;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.textLabel.numberOfLines = 0;
    self.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.detailTextLabel.numberOfLines = 0;
  }
  return self;
}


@end
