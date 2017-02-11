//
//  RSSFeed+CoreDataProperties.h
//  RSSReader
//
//  Created by Alexander on 2/11/17.
//  Copyright © 2017 Home. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "RSSFeed.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSSFeed (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSSet<RSSItem *> *items;

@end

@interface RSSFeed (CoreDataGeneratedAccessors)

- (void)addItemsObject:(RSSItem *)value;
- (void)removeItemsObject:(RSSItem *)value;
- (void)addItems:(NSSet<RSSItem *> *)values;
- (void)removeItems:(NSSet<RSSItem *> *)values;

@end

NS_ASSUME_NONNULL_END
