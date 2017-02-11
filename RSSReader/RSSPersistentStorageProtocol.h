//
//  RSSPersistentStorageProtocol.h
//  RSSReader
//
//  Created by Alexander on 2/10/17.
//  Copyright © 2017 Home. All rights reserved.
//


#import "SMXMLDocument.h"

#ifndef RSSPersistentStorageProtocol_h
#define RSSPersistentStorageProtocol_h

@protocol RSSMapperProtocol;
@class RSSFeed;

@protocol RSSPersistentStorageProtocol <NSObject>
- (void)save:(SMXMLDocument *)document mapper:(id<RSSMapperProtocol>)maper complitionHandler:(void(^)(void))complitionHandler;
- (void)feedAsync:(void(^)(RSSFeed *feed))complitionBlock;
- (void)itemsAsync:(void(^)(NSArray *result))complitionBlock;
- (void)feedClearAsync:(RSSFeed *)feed complition:(void(^)(void))complitionBlock;
- (NSArray *)feedSync;
@end
#endif /* RSSPersistentStorageProtocol_h */
