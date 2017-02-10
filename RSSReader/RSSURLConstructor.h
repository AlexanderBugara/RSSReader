//
//  RSSURLConstructor.h
//  RSSReader
//
//  Created by Alexander on 2/10/17.
//  Copyright © 2017 Home. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RSSURLConstructor : NSObject

@property (nonatomic, retain, readonly) NSURL *base;

- (NSURL *)feedUrl;

@end
