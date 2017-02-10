//
//  RSSURLConstructor.m
//  RSSReader
//
//  Created by Alexander on 2/10/17.
//  Copyright © 2017 Home. All rights reserved.
//

#import "RSSURLConstructor.h"
#import "RSSConstants.h"

@interface RSSURLConstructor()
@property (nonatomic, retain) NSURL *base;
@end

@implementation RSSURLConstructor

- (instancetype)init {
  if (self = [super init]) {
    _base = [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@",kSchemaURL, kBaseURL]];
  }
  return self;
}

- (NSURL *)feedUrl {
  return [NSURL URLWithString:kFeedPath relativeToURL:self.base];
}


- (void)dealloc {
  [_base release];
  _base = nil;
  [super dealloc];
}
@end
