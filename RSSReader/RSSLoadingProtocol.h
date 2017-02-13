//
//  RSSLoadingProtocol.h
//  RSSReader
//
//  Created by Alexander on 2/11/17.
//  Copyright © 2017 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RSSLoadingProtocol <NSObject>
- (void)startLoading;
- (void)stopLoading;
@end
