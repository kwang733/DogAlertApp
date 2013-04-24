#import "CreateDogViewController.h"
#import "UITweeksClass.h"
#import "Dogs.h"
#import "AppDelegate.h"

@implementation CreateDogViewController
@synthesize dogname, filename, dogpicture;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    filename = @"";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    dogname = nil;
    dogpicture = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Actions

- (IBAction) goBack:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction) done:(id)sender {
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
	NSManagedObjectContext *context = [del managedObjectContext];
    Dogs *dog = [NSEntityDescription insertNewObjectForEntityForName:@"Dogs" 
                                                 inManagedObjectContext:context];
    
    dog.name = dogname.text;
    dog.picture = filename;
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure" message:@"Unable to save record at the moment." delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Dog has been saved." delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
        [alert release];
        [self dismissModalViewControllerAnimated:YES];
    }
}

- (IBAction) takePhoto:(id)sender {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.delegate = self;
        picker.sourceType =  UIImagePickerControllerSourceTypeCamera;
        [self presentModalViewController:picker animated:YES];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error: Camera not available" message:@"This device does not have camera in it." delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    [picker release]; 
}

- (IBAction) pickPhoto:(id)sender {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        picker.delegate = self;
        picker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
        picker.mediaTypes = [NSArray arrayWithObject:(NSString *) kUTTypeImage];
        
        [self presentModalViewController:picker animated:YES];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error: Photo library not available" message:@"This device does not have photo library in it." delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    [picker release]; 
}

#pragma mark - UIImagePickerController delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissModalViewControllerAnimated:YES];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    dogpicture.image = image;
    NSData *imageData = UIImagePNGRepresentation(image);
    
    filename = [[UITweeksClass createUUID] copy];
    NSString *fullfilepath = [UITweeksClass getDocumentsDirFolder];
    fullfilepath = [fullfilepath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", filename]];
    [imageData writeToFile:fullfilepath atomically:YES];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissModalViewControllerAnimated:YES];
}
@end
