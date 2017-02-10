//
//  RSSDataSource.h
//  RSSReader
//
//  Created by Alexander on 2/10/17.
//  Copyright © 2017 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RSSDataSourceProtocol <NSObject>

@end

@interface RSSFeedDataSource : NSObject<RSSDataSourceProtocol>

@end
