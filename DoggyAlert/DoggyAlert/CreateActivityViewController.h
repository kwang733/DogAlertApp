#import <UIKit/UIKit.h>

@class Dogs, Activities;
@interface CreateActivityViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIPickerView *type;
@property (nonatomic, retain) IBOutlet UIPickerView *time;
@property (nonatomic, retain) Dogs *dog;
@property (nonatomic, retain) Activities *activity;
@property (nonatomic, retain) NSArray *types;
@property (nonatomic, retain) NSArray *days;
@property (nonatomic, retain) NSArray *hours;
@property (nonatomic, retain) NSMutableArray *minutes;

- (IBAction) save:(id)sender;
- (NSDate *) fetchNextSelectedDay:(int)index hours:(int)hours minutes:(int)minutes;
- (NSMutableArray *) fetchNext64DaysforDayindex:(int)index withTime:(NSDate *)time;
- (NSString *)uniqueString;
-(NSSet *) setLocalNotifications:(NSMutableArray *)arr withDay:(NSString *)day withUID:(NSString *)uuid context:(NSManagedObjectContext *)context activity:(Activities *)activity;
- (IBAction) goBack:(id)sender;
@end
