//
//  Dogs.h
//  DoggyAlert
//
//  Created by Ayaz Alavi on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Activities;

@interface Dogs : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * picture;
@property (nonatomic, retain) NSSet *activities;
@end

@interface Dogs (CoreDataGeneratedAccessors)

- (void)addActivitiesObject:(Activities *)value;
- (void)removeActivitiesObject:(Activities *)value;
- (void)addActivities:(NSSet *)values;
- (void)removeActivities:(NSSet *)values;
@end
