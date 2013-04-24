
#import "DogsListingViewController.h"
#import "CreateDogViewController.h"
#import "Dogs.h"
#import "UITweeksClass.h"
#import "ActivitiesListingViewController.h"
#import "CalenderViewController.h"

@implementation DogsListingViewController
@synthesize leftArrow, rightArrow, dogname, picture, currentIndex, dogsView, dogs, context, actCompleted, actMissed;

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
    currentIndex = 0;

}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self fetchRecords];
    
    [self updateUI];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    leftArrow = nil;
    rightArrow = nil;
    dogname = nil;
    picture = nil;
    dogsView = nil;
    dogs = nil;
    context = nil;
    actCompleted = nil;
    actMissed = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Actions

- (IBAction) createDog:(id)sender {
    CreateDogViewController *dog = [[CreateDogViewController alloc] initWithNibName:@"CreateDogViewController" bundle:nil];
    [self presentModalViewController:dog animated:YES];
    [dog release];
}

- (IBAction) moveLeft:(id)sender {
    currentIndex = currentIndex <= 0 ? currentIndex:(currentIndex-1);
    [self updateUI];
}

- (IBAction) moveRight:(id)sender {
    currentIndex = currentIndex >= ([dogs count]-1) ? currentIndex: currentIndex+1;
    [self updateUI];
}

- (IBAction) gotoActivities:(id)sender {
    ActivitiesListingViewController *activities = [[ActivitiesListingViewController alloc] initWithNibName:@"ActivitiesListingViewController" bundle:nil];
    activities.dog = [dogs objectAtIndex:currentIndex];
    [self presentModalViewController:activities animated:YES];
    [activities release];
}

- (IBAction) gotoCalender:(id)sender {
    CalenderViewController *activities = [[CalenderViewController alloc] initWithNibName:@"CalenderViewController" bundle:nil];
    activities.dog = [dogs objectAtIndex:currentIndex];
    [self presentModalViewController:activities animated:YES];
    [activities release];
}

#pragma mark - Extra methods

- (void) fetchRecords {
	NSEntityDescription *entityDescription = [NSEntityDescription
											  entityForName:@"Dogs" inManagedObjectContext:self.context];
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	[request setEntity:entityDescription];
	
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
										initWithKey:@"name" ascending:YES];
	[request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	[sortDescriptor release];
    
    NSError *error;
	dogs = [[self.context executeFetchRequest:request error:&error] mutableCopy];
    [dogs retain];
}

- (void) updateUI {
    if ([dogs count] > 0) {
        dogsView.hidden = NO;
        Dogs *dog = [dogs objectAtIndex:currentIndex];
        dogname.text = dog.name;
        NSData *imageData = [NSData dataWithContentsOfFile:[[UITweeksClass getDocumentsDirFolder] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", dog.picture]]];
        picture.image = [[[UIImage alloc] initWithData:imageData] autorelease];
    }
    else {
        dogsView.hidden = YES;
    }
}

@end
