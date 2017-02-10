//
//  RSSNetworkManager.h
//  RSSReader
//
//  Created by Alexander on 2/10/17.
//  Copyright © 2017 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSNetworkManager : NSObject
- (void)networkRequest:(NSURL *)url 
      complitinHendler:(void(^)(NSData *data, NSError *error))complitionHandler;
- (instancetype)initWithSession:(NSURLSession *)session;
@end
