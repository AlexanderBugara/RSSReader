//
//  RSSURLConstructor.m
//  RSSReader
//
//  Created by Alexander on 2/10/17.
//  Copyright © 2017 Home. All rights reserved.
//

#import "RSSURLConstructor.h"
#import "RSSConstants.h"


@implementation RSSURLConstructor
@synthesize base = _base;


- (NSURL *)feedUrl {
  return [NSURL URLWithString:kFeedPath relativeToURL:self.base];
}

- (NSURL *)base {
  if (!_base) {
      _base = [[NSURL URLWithString:[NSString stringWithFormat:@"%@://%@",kSchemaURL, kBaseURL]] retain];
  }
  return _base;
}

- (void)dealloc {
  [_base release];
  _base = nil;
  [super dealloc];
}
@end
