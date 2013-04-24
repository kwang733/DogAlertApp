#import <UIKit/UIKit.h>
@class NavigationController;
@class CustomViewController;
@interface UITweeksClass : UIViewController {

}

+ (NSString *) createUUID;
+ (NSString *) getDocumentsDirFolder:(NSString *) key;
+ (NSString *) getDocumentsDirFolder;

@end
