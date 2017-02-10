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

@protocol RSSPersistentStorageProtocol <NSObject>
- (void)save:(SMXMLDocument *)document mapper:(id<RSSMapperProtocol>)maper complitionHandler:(void(^)(void))complitionHandler;
- (void)feedAsync:(void(^)(NSArray *result))complitionBlock;
- (void)feedClearAsync:(NSArray *)feed complition:(void(^)(void))complitionBlock;
@end
#endif /* RSSPersistentStorageProtocol_h */
