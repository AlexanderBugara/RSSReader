//
//  RSSDataService.m
//  RSSReader
//
//  Created by Alexander on 2/10/17.
//  Copyright © 2017 Home. All rights reserved.
//

#import "RSSFeedDataService.h"
#import "RSSNetworkManager.h"
#import "RSSURLConstructor.h"
#import "SMXMLDocument.h"
#import "RSSConstants.h"

@interface RSSFeedDataService ()
@property (nonatomic, retain, readonly) RSSNetworkManager *networkManager;
@property (nonatomic, retain) RSSURLConstructor *urlConstructor;
@end


@implementation RSSFeedDataService

- (instancetype)init {
  if (self = [super init]) {
    _networkManager = [RSSNetworkManager new];
    _urlConstructor = [RSSURLConstructor new];
  }
  return self;
}

- (void)feedAsync:(void(^)(NSArray *result))complitionHandler {
  [self.networkManager networkRequest:[self.urlConstructor feedUrl]
                     complitinHendler:^(NSData *data, NSError *error) {
                       
         SMXMLDocument *document = [SMXMLDocument documentWithData:data error:&error];
         SMXMLElement *channel = [document.root childNamed:kFeedKey];
         
         
                       
         complitionHandler(nil);
                      
  }];
}

- (void)dealloc {
  
  [_urlConstructor release];
  _urlConstructor = nil;
  
  [_networkManager release];
  _networkManager = nil;
  
  [super dealloc];
}

@end
