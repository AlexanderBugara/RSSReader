//
//  RSSDetailViewController.h
//  RSSReader
//
//  Created by Alexander on 2/11/17.
//  Copyright © 2017 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSSDetailViewController : UIViewController<UIWebViewDelegate>
- (instancetype)initWithURL:(NSURL *)url title:(NSString *)title;
@end
