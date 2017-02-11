//
//  RSSDetailViewController.m
//  RSSReader
//
//  Created by Alexander on 2/11/17.
//  Copyright © 2017 Home. All rights reserved.
//

#import "RSSDetailViewController.h"
#import "Masonry.h"

@interface RSSDetailViewController ()
@property (nonatomic, retain) NSURL *url;
@end

@implementation RSSDetailViewController

- (instancetype)initWithURL:(NSURL *)url {
  if (self = [super init]) {
    _url = [url retain];
  }
  return self;
}

- (void)dealloc {
  [_url release];
  _url = nil;
  [super dealloc];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
  [self.view addSubview:webView];
  [webView loadRequest:[NSURLRequest requestWithURL:self.url]];
  [webView release];
  
  [webView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.view);
  }];
  
}
@end
