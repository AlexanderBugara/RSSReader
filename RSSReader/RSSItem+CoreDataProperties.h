//
//  RSSItem+CoreDataProperties.h
//  RSSReader
//
//  Created by Alexander on 2/11/17.
//  Copyright © 2017 Home. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "RSSItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSSItem (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *description_;
@property (nullable, nonatomic, retain) NSString *link;
@property (nullable, nonatomic, retain) NSDate *pubDate;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) RSSFeed *feed;

@end

NS_ASSUME_NONNULL_END
