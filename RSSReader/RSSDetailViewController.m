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
@property (nonatomic, copy) NSString *title;
@end

@implementation RSSDetailViewController
@synthesize title = _title;

- (instancetype)initWithURL:(NSURL *)url title:(NSString *)title {
  if (self = [super init]) {
    _url = [url retain];
    _title = title;
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
  
  self.navigationItem.title = self.title;
  UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
  [self.view addSubview:webView];
  
  webView.delegate = self;
  
  [webView loadRequest:[NSURLRequest requestWithURL:self.url]];
  [webView release];
  
  [webView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.view);
  }];
  
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
  self.title = self.navigationItem.title;
  self.navigationItem.title = NSLocalizedString(@"Loading...", @"Loading...");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  [self updateTitle];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  [self updateTitle];
}

- (void)updateTitle {
  self.navigationItem.title = self.title;
}
@end
