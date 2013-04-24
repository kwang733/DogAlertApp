//
//  UITweeksClass.h
//  Behave
//
//  Created by Syed Ayaz Uddin Alavi on 9/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NavigationController;
@class CustomViewController;
@interface UITweeksClass : UIViewController {

}

+ (NSString *) createUUID;
+ (NSString *) getDocumentsDirFolder:(NSString *) key;
+ (NSString *) getDocumentsDirFolder;

@end
