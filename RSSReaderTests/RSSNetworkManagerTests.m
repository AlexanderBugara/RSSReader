//
//  RSSNetworkManagerTests.m
//  RSSReader
//
//  Created by Alexander on 2/13/17.
//  Copyright © 2017 Home. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCHamcrest/OCHamcrest.h>
#import <OCMockito/OCMockito.h>
#import <Foundation/Foundation.h>
#import "RSSFeed.h"
#import "RSSNetworkManager.h"

#import <Foundation/Foundation.h>
#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import "Expecta.h"
#import <Nocilla/Nocilla.h>

SpecBegin(RSSNetworkManager)

describe(@"RSSNetworkManager: check request", ^{
  
  __block RSSNetworkManager *networkManager;
  __block NSString *sURL;
  
  beforeAll(^{
    
    [[LSNocilla sharedInstance] start];
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:@"xml" ofType:@"xml"];
    NSData *xmlData = [NSData dataWithContentsOfFile:path];
    NSString *myString = [[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
    
    sURL = @"http://images.apple.com/main/rss/hotnews/hotnews.rss";
    stubRequest(@"GET", sURL).andReturn(201).
    withHeaders(@{@"Content-Type": @"application/xml"}).
    withBody(myString);
    
    networkManager = [[RSSNetworkManager alloc] init];
  });
  
  
  it(@"RSSNetworkManager: session", ^{
    __block BOOL waitingForBlock = YES;
    [networkManager networkRequest:[NSURL URLWithString:sURL] complitinHendler:^(NSData *data, NSError *error) {
      
      expect(data).notTo.beNil();
      expect(error).to.beNil();
      
      waitingForBlock = NO;
    }];
    while(waitingForBlock) {
      [[NSRunLoop currentRunLoop] runMode:NSRunLoopCommonModes
                               beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }
  });
  
  afterEach(^{
    [[LSNocilla sharedInstance] clearStubs];
  });
  
  afterAll(^{
    [[LSNocilla sharedInstance] stop];
  });
});

describe(@"RSSNetworkManager: check default init", ^{
  
  __block RSSNetworkManager *networkManager;
  
  beforeAll(^{
    networkManager = [[RSSNetworkManager alloc] init];
  });
  
  it(@"RSSNetworkManager: session", ^{
    expect(networkManager.session).toNot.beNil();
  });
  
  
});

describe(@"RSSNetworkManager: check inject init", ^{
  
  __block RSSNetworkManager *networkManager;
  
  beforeAll(^{
    NSURLSession *session = mock([NSURLSession class]);
    networkManager = [[RSSNetworkManager alloc] initWithSession:session];
  });
  
  it(@"RSSNetworkManager: session", ^{
    expect(networkManager.session).toNot.beNil();
  });
  
  
});


SpecEnd
