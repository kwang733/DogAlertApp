//
//  ActivityTimeLog.h
//  DoggyAlert
//
//  Created by Ayaz Alavi on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Activities;

@interface ActivityTimeLog : NSManagedObject

@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSNumber * is_acheived;
@property (nonatomic, retain) Activities *activity;

@end
