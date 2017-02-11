//
//  RSSMaperProtocol.h
//  RSSReader
//
//  Created by Alexander on 2/10/17.
//  Copyright © 2017 Home. All rights reserved.
//

#ifndef RSSMaperProtocol_h
#define RSSMaperProtocol_h

@class RSSItem, SMXMLElement, RSSFeed;

@protocol RSSMapperProtocol <NSObject>
- (void)map:(SMXMLElement *)element toItem:(RSSItem *)item;
- (void)map:(SMXMLElement *)element toFeed:(RSSFeed *)feed;
@end
#endif /* RSSMaperProtocol_h */
