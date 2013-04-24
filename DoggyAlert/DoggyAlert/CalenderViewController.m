//
//  CalenderViewController.m
//  DoggyAlert
//
//  Created by Ayaz Alavi on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalenderViewController.h"
#import "Dogs.h"
#import "Activities.h"
#import "ActivityTimeLog.h"
#import "AppDelegate.h"

@implementation CalenderViewController
@synthesize dog;

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
    [self updateUI];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    dog = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) updateUI {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [calendar setTimeZone:[NSTimeZone systemTimeZone]];
    
    NSDateComponents *comps = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSYearCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSTimeZoneCalendarUnit) fromDate:[NSDate date]];
    NSMutableArray *datesArray = [NSMutableArray array];
    
    NSRange daysRange = 
    [calendar 
     rangeOfUnit:NSDayCalendarUnit 
     inUnit:NSMonthCalendarUnit 
     forDate:[NSDate date]];

    for (int i= 0; i<daysRange.length; i++) {
        [comps setDay:i+1]; 
        [datesArray addObject:[calendar dateFromComponents:comps]];
    }
    int height = 64;
    int width = 64;
    CGRect rect = CGRectMake(0, 0, width, height);
    for (NSDate *date in datesArray) {        
        UIView *dateView = [[UIView alloc] initWithFrame:rect];
        dateView.layer.borderWidth = 1.0;
        dateView.layer.borderColor = [UIColor blackColor].CGColor;
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(25, 3, 34, 21)];
        NSDateComponents *comps = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSYearCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSTimeZoneCalendarUnit) fromDate:date];
        lbl.text = [NSString stringWithFormat:@"%d", [comps day]];
        [dateView addSubview:lbl];
        
        UIImageView *tick = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 20, 20)];
        tick.image = [UIImage imageNamed:@"tick.jpg"];
        [dateView addSubview:tick];
        
        UILabel *lbltick = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, 34, 21)];
        lbltick.text = [self fetchCompletedCountForDate:date];
        [dateView addSubview:lbltick];
        
        UIImageView *wrong = [[UIImageView alloc] initWithFrame:CGRectMake(10, 44, 20, 20)];
        wrong.image = [UIImage imageNamed:@"wrong.png"];
        [dateView addSubview:wrong];
        
        UILabel *lblwrong = [[UILabel alloc] initWithFrame:CGRectMake(30, 44, 34, 21)];
        lblwrong.text = [self fetchUnCompletedCountForDate:date];
        [dateView addSubview:lblwrong];
        
        if (rect.origin.x+width > 320) {
            rect.origin.y = rect.origin.y+height;
            rect.origin.x = 0;
        }
        else {
            rect.origin.x += width;
        }
        [self.view addSubview:dateView];
    }
}


- (NSString *) fetchCompletedCountForDate:(NSDate *)date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [calendar setTimeZone:[NSTimeZone systemTimeZone]];
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
    [components setHour:0];
    //create a date with these components
    NSDate *startDate = [calendar dateFromComponents:components];
    [components setHour:24]; //reset the other components
    NSDate *endDate = [calendar dateByAddingComponents:components toDate:startDate options:0];
    
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext * context = [del managedObjectContext];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(time >= %@) AND (time <= %@) AND (is_acheived == %@)", startDate, endDate, [NSNumber numberWithBool:YES]];
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    [request setEntity:[NSEntityDescription entityForName:@"ActivityTimeLog" inManagedObjectContext:context]];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    NSLog(@"%@", results);
    return [NSString stringWithFormat:@"%d", [results count]];
}

- (NSString *) fetchUnCompletedCountForDate:(NSDate *)date {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"yyyy-MM-dd 00:00:01 ZZZ"];
	NSString *startdate = [NSString stringWithFormat:@"%@",
                           [df stringFromDate:date]];
	NSLog(@"%@", startdate);
	[df setDateFormat:@"yyyy-MM-dd 23:59:59 ZZZ"];
	NSString *enddate = [NSString stringWithFormat:@"%@",
                         [df stringFromDate:date]];
	NSLog(@"%@", enddate);
	[df release];
	df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZ"];
	NSDate *date1 = [df dateFromString:startdate];
	NSDate *date2 = [df dateFromString:enddate];
	NSLog(@"%@", date1);
	NSLog(@"%@", date2);
	
    
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext * context = [del managedObjectContext];    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
							  @"(time > %@) AND (time < %@) AND (activity.dog == %@)", date1, date2, dog];
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    [request setEntity:[NSEntityDescription entityForName:@"ActivityTimeLog" inManagedObjectContext:context]];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    NSLog(@"%@", results);
    return [NSString stringWithFormat:@"%d", [results count]];
}

- (IBAction) goBack:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

@end
