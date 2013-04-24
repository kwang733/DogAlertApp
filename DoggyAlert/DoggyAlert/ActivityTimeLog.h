
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Activities;

@interface ActivityTimeLog : NSManagedObject

@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSNumber * is_acheived;
@property (nonatomic, retain) Activities *activity;

@end
