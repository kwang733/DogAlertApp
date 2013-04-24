#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ActivityTimeLog, Dogs;

@interface Activities : NSManagedObject

@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * uuid;
@property (nonatomic, retain) Dogs *dog;
@property (nonatomic, retain) NSSet *times;
@end

@interface Activities (CoreDataGeneratedAccessors)

- (void)addTimesObject:(ActivityTimeLog *)value;
- (void)removeTimesObject:(ActivityTimeLog *)value;
- (void)addTimes:(NSSet *)values;
- (void)removeTimes:(NSSet *)values;
@end
