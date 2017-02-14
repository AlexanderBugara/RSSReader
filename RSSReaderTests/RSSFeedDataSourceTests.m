//
//  RSSReaderTests.m
//  RSSReaderTests
//
//  Created by Alexander on 2/9/17.
//  Copyright © 2017 Home. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCHamcrest/OCHamcrest.h>
#import <OCMockito/OCMockito.h>
#import "RSSFeed.h"
#import "RSSFeedDataSource.h"

#import <Foundation/Foundation.h>
#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import "Expecta.h"

SpecBegin(RSSFeedDataSource)

describe(@"RSSFeedDataSource: check on init", ^{
  
  __block RSSFeedDataSource *dataSource;
  
  beforeAll(^{
    dataSource = [[RSSFeedDataSource alloc] init];
  });
  
  it(@"RSSFeedDataSource: check all init value", ^{
    expect([dataSource feedTitle]).to.equal(nil);
    expect([dataSource number]).to.equal(0);
    expect([dataSource objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).to.equal(nil);
    expect([dataSource urlAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).to.equal(nil);
    expect([dataSource tittleAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).to.equal(nil);
    expect([dataSource descriptionAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).to.equal(nil);
  });
  

});

describe(@"RSSFeedDataSource: check on init", ^{
  
  __block RSSFeedDataSource *dataSource;
  
  beforeAll(^{
   
    RSSFeed *mockFeed = mock([RSSFeed class]);
    
    [given([mockFeed title]) willReturn:@"test title"];
    
    dataSource = [[RSSFeedDataSource alloc] init];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [dataSource setFeed:mockFeed complition:^{
      dispatch_semaphore_signal(semaphore);
    }];
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
      [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                               beforeDate:[NSDate dateWithTimeIntervalSinceNow:2]];
    }
  });
  
  it(@"check title", ^{
    expect([dataSource feedTitle]).to.equal(@"test title");
  });
});



describe(@"RSSFeedDataSource: check on init", ^{
  
  __block RSSFeedDataSource *dataSource;
  
  beforeAll(^{
    
    RSSFeed *mockFeed = mock([RSSFeed class]);
    
    [given([mockFeed title]) willReturn:@"test title"];
    
    dataSource = [[RSSFeedDataSource alloc] init];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [dataSource setFeed:mockFeed complition:^{
      dispatch_semaphore_signal(semaphore);
    }];
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
      [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                               beforeDate:[NSDate dateWithTimeIntervalSinceNow:2]];
    }
  });
  
  it(@"check title", ^{
    expect([dataSource feedTitle]).to.equal(@"test title");
  });
});


SpecEnd
