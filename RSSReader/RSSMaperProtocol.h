//
//  RSSMaperProtocol.h
//  RSSReader
//
//  Created by Alexander on 2/10/17.
//  Copyright © 2017 Home. All rights reserved.
//

#ifndef RSSMaperProtocol_h
#define RSSMaperProtocol_h

@class RSSItem, SMXMLElement;

@protocol RSSMapperProtocol <NSObject>
- (void)map:(SMXMLElement *)element to:(RSSItem *)item;
@end
#endif /* RSSMaperProtocol_h */
