//
//  RSSFeedFacade.m
//  RSSReader
//
//  Created by Alexander on 2/10/17.
//  Copyright © 2017 Home. All rights reserved.
//

#import "RSSFeedFacade.h"
#import "RSSFeedDataService.h"

@interface RSSFeedFacade()
@property (nonatomic, retain) RSSFeedDataService *feedDataService;
@end

@implementation RSSFeedFacade


- (instancetype)init {
  
  if (self = [super init]) {
    _feedDataService = [RSSFeedDataService new];
  }
  return self;
  
}

- (void)feedAsync:(void(^)(void))complitionHadler {
  
  __weak __typeof(self) weakSelf = self;
  [self.feedDataService feedAsync:^(NSArray *result){
    
  }];
}

- (void)dealloc {
  [_feedDataService release];
  _feedDataService = nil;
  [super dealloc];
}

@end
