//
//  RSSMaper.m
//  RSSReader
//
//  Created by Alexander on 2/10/17.
//  Copyright © 2017 Home. All rights reserved.
//

#import "RSSMapper.h"
#import "SMXMLDocument.h"
#import "RSSItem+CoreDataProperties.h"

@implementation RSSMapper
- (void)map:(SMXMLElement *)element to:(RSSItem *)item {
  
  for (SMXMLElement *field in element.children) {
    
    NSString *value = field.value;
    if ([field.name isEqualToString:@"description"]) {
      item.description_ = value;
    } else if ([field.name isEqualToString:@"link"]) {
      item.link = value;
    } else if ([field.name isEqualToString:@"title"]) {
      item.title = value;
    } else if ([field.name isEqualToString:@"pubDate"]) {
      item.pubDate = [self dateFromString:value];
    }
  }
}

- (NSDate *)dateFromString:(NSString *)sDate {
  return [NSDate date];
}

@end
