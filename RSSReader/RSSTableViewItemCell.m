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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFeedItem:(RSSItem *)item {
//  self.title.text = item.title;
//  self.description_.text = item.description_;
  self.textLabel.text = item.title;
  self.detailTextLabel.text = item.description_;
}

//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//  if (self) {
//    //reuseID = reuseIdentifier;
//    self.translatesAutoresizingMaskIntoConstraints = NO;
//    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    UILabel *title = [[UILabel alloc] init];
//    [self.title setTextColor:[UIColor blackColor]];
//    [self.title setBackgroundColor:[UIColor greenColor]];//[UIColor colorWithHue:32 saturation:100 brightness:63 alpha:1]];
//    [self.title setFont:[UIFont fontWithName:@"HelveticaNeue" size:18.0f]];
//    [self.title setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [self.contentView addSubview:title];
//    self.title = title;
//    
//    UILabel *description_ = [[UILabel alloc] init];
//    [self.description_ setTextColor:[UIColor blackColor]];
//    [self.description_ setBackgroundColor:[UIColor colorWithHue:66 saturation:100 brightness:63 alpha:1]];
//    [self.description_ setFont:[UIFont fontWithName:@"HelveticaNeue" size:18.0f]];
//    [self.description_ setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [self.contentView addSubview:description_];
//    self.description_ = description_;
//  }
//  return self;
//}
//
//
//- (void)layoutSubviews {
//  [super layoutSubviews];
//  if (self.layoutDidSet) return;
//  
//  [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
//    make.left.equalTo(self.contentView).offset(10);
//    make.right.equalTo(self.contentView.mas_top).offset(-20);
//    make.top.equalTo(self.contentView).offset(20);
//    make.height.equalTo(@25);
//    make.bottom.equalTo(self.contentView);
//  }];
//  
////  [self.description_ mas_makeConstraints:^(MASConstraintMaker *make) {
////    make.top.equalTo(self.title.mas_bottom).offset(10);
////    make.left.equalTo(self.contentView);
////    make.right.equalTo(self.contentView);
////    make.height.equalTo(@25);
////    make.bottom.equalTo(self.contentView).offset(-20);
////  }];
//  
//  self.layoutDidSet = YES;
//}

@end
