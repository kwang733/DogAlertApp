//
//  DogsListingViewController.h
//  DoggyAlert
//
//  Created by Ayaz Alavi on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//



@interface DogsListingViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIButton *leftArrow;
@property (nonatomic, retain) IBOutlet UIButton *rightArrow;
@property (nonatomic, retain) IBOutlet UILabel *dogname;
@property (nonatomic, retain) IBOutlet UIImageView *picture;
@property (nonatomic, retain) IBOutlet UIView *dogsView;
@property (nonatomic, assign) int currentIndex;
@property (nonatomic, retain) NSMutableArray *dogs;
@property (nonatomic, retain) NSManagedObjectContext *context;
@property (nonatomic, retain) IBOutlet UILabel *actCompleted;
@property (nonatomic, retain) IBOutlet UILabel *actMissed;

- (IBAction) createDog:(id)sender;
- (void) fetchRecords;
- (void) updateUI;
- (IBAction) moveLeft:(id)sender;
- (IBAction) moveRight:(id)sender;
- (IBAction) gotoActivities:(id)sender;
- (IBAction) gotoCalender:(id)sender;

@end
