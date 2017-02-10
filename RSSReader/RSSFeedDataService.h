//
//  RSSDataService.h
//  RSSReader
//
//  Created by Alexander on 2/10/17.
//  Copyright © 2017 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSFeedDataService : NSObject
- (void)feedAsync:(void(^)(NSArray *result))complitionHandler;
@end
