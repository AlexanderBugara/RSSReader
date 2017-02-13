//
//  RSSDataSource.h
//  RSSReader
//
//  Created by Alexander on 2/10/17.
//  Copyright © 2017 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSSDataSourceProtocol.h"

@interface RSSFeedDataSource : NSObject<RSSDataSourceProtocol>
@property (nonatomic, copy, readonly) NSString *feedTitle;
@end
