//
//  CalenderViewController.h
//  DoggyAlert
//
//  Created by Ayaz Alavi on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

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
