#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class Dogs;
@interface CalenderViewController : UIViewController

@property (nonatomic, retain) Dogs *dog;

- (void) updateUI;
- (NSString *) fetchCompletedCountForDate:(NSDate *)date;
- (NSString *) fetchUnCompletedCountForDate:(NSDate *)date;

- (IBAction) goBack:(id)sender;

@end
