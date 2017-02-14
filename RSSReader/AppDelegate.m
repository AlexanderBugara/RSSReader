//
//  AppDelegate.m
//  RSSReader
//
//  Created by Alexander on 2/9/17.
//  Copyright © 2017 Home. All rights reserved.
//

#import "AppDelegate.h"
#import "RSSFeedViewController.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
  UINavigationController *navigationController = [UINavigationController new];
  RSSFeedViewController *rssViewController = [RSSFeedViewController new];
  navigationController.viewControllers = @[rssViewController];
  [rssViewController release];
  self.window.rootViewController = navigationController;
  [navigationController release];
  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];
  
  
  return YES;
}

@end
