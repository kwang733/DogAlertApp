//
//  ActivitiesListingViewController.h
//  DoggyAlert
//
//  Created by Ayaz Alavi on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Dogs;
@interface ActivitiesListingViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) Dogs *dog;

- (IBAction) createActivity:(id)sender;
- (void) editActivity:(UIButton *)sender;
- (IBAction) goBack:(id)sender;

@end
