
#import <UIKit/UIKit.h>

@class Dogs;
@interface ActivitiesListingViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) Dogs *dog;

- (IBAction) createActivity:(id)sender;
- (void) editActivity:(UIButton *)sender;
- (IBAction) goBack:(id)sender;

@end
