//
//  CreateDogViewController.h
//  DoggyAlert
//
//  Created by Ayaz Alavi on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>

@interface CreateDogViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, retain) IBOutlet UITextField *dogname;
@property (nonatomic, retain) NSString *filename;
@property (nonatomic, retain) IBOutlet UIImageView *dogpicture;

- (IBAction) done:(id)sender;
- (IBAction) takePhoto:(id)sender;
- (IBAction) pickPhoto:(id)sender;
- (IBAction) goBack:(id)sender;

@end
