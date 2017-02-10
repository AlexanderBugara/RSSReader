//
//  RSSNetworkManager.m
//  RSSReader
//
//  Created by Alexander on 2/10/17.
//  Copyright © 2017 Home. All rights reserved.
//

#import "RSSNetworkManager.h"


@implementation RSSNetworkManager

- (instancetype)init {
  if (self = [super init]) {
    _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
  }
  return self;
}

- (instancetype)initWithSession:(NSURLSession *)session {
  if (self = [super init]) {
    _session = [session retain];
    
  }
  return self;
}

- (void)networkRequest:(NSURL *)url complitinHendler:(void(^)(NSData *data, NSError *error))complitionHandler {
  
  [[self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
    complitionHandler(data, error);
    
  }] resume];
  
}

- (void)dealloc {
  [_session release];
  _session = nil;
  [super dealloc];
}
@end
