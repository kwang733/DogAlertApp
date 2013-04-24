#import "CreateActivityViewController.h"
#import "Dogs.h"
#import "Activities.h"
#import "AppDelegate.h"
#import "ActivityTimeLog.h"

@implementation CreateActivityViewController
@synthesize type, time, dog, types, days, hours, minutes, activity;

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
    days = [[NSArray alloc] initWithObjects:@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", @"Sunday", nil];
    types = [[NSArray alloc] initWithObjects:@"Feed", @"Walk", @"Play", @"Medicine", nil];
    hours = [[NSArray alloc] initWithObjects:@"0 hours", @"1 hours", @"2 hours", @"3 hours", @"4 hours", @"5 hours", @"6 hours", @"7 hours", @"8 hours", @"9 hours", @"10 hours", @"11 hours", @"12 hours", @"13 hours", @"14 hours", @"15 hours", @"16 hours", @"17 hours", @"18 hours", @"19 hours", @"20 hours", @"21 hours", @"22 hours", @"23 hours", nil];
    minutes = [[NSMutableArray alloc] initWithCapacity:60];
    for (int i=0; i<60; i++) {
        [minutes addObject:[NSString stringWithFormat:@"%d minutes", i]];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    type = nil;
    time = nil;
    days = nil;
    types = nil;
    hours = nil;
    minutes = nil;
    activity = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Actions

- (IBAction) save:(id)sender {
    if (activity == nil) {
        AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
		NSManagedObjectContext * context = [del managedObjectContext];
        Activities *group = [NSEntityDescription
                 insertNewObjectForEntityForName:@"Activities" 
                 inManagedObjectContext:context];
        group.type = [types objectAtIndex:[type selectedRowInComponent:0]];
        NSString *uuid = [self uniqueString];    
        group.uuid = uuid;
        NSString *day = [days objectAtIndex:[time selectedRowInComponent:0]];
        NSString *hour_ = [hours objectAtIndex:[time selectedRowInComponent:1]];
        NSRange range = [hour_ rangeOfString:@" " options:NSLiteralSearch];
        NSLog(@"range.location: %@", NSStringFromRange(range));
        int hour = [[hour_ substringToIndex:range.location] intValue];
        
        NSString *minute_ = [minutes objectAtIndex:[time selectedRowInComponent:2]];
        NSRange range2 = [minute_ rangeOfString:@" " options:NSLiteralSearch];
        NSLog(@"range.location: %@", NSStringFromRange(range2));
        int minute = [[minute_ substringToIndex:range2.location] intValue];
        
        NSLog(@"Hour: %d", hour);
        NSLog(@"Minute: %d", minute);
        NSMutableArray *arrofdates;
        if ([day isEqualToString:@"Friday"]) {
            NSDate *time_ = [self fetchNextSelectedDay:13 hours:hour minutes:minute];
            NSLog(@"%@", time_);
            arrofdates = [self fetchNext64DaysforDayindex:13 withTime:time_];
            NSLog(@"%@", arrofdates);
        }
        else if([day isEqualToString:@"Saturday"]) {
            NSDate *time_ = [self fetchNextSelectedDay:14 hours:hour minutes:minute];
            arrofdates = [self fetchNext64DaysforDayindex:14 withTime:time_];
        }
        else if([day isEqualToString:@"Sunday"]) {
            NSDate *time_ = [self fetchNextSelectedDay:8 hours:hour minutes:minute];
            arrofdates = [self fetchNext64DaysforDayindex:8 withTime:time_];
        }
        else if([day isEqualToString:@"Monday"]) {
            NSDate *time_ = [self fetchNextSelectedDay:9 hours:hour minutes:minute];
            arrofdates = [self fetchNext64DaysforDayindex:9 withTime:time_];
        }
        else if([day isEqualToString:@"Tuesday"]) {
            NSDate *time_ = [self fetchNextSelectedDay:10 hours:hour minutes:minute];
            arrofdates = [self fetchNext64DaysforDayindex:10 withTime:time_];
        }
        else if([day isEqualToString:@"Wednesday"]) {
            NSDate *time_ = [self fetchNextSelectedDay:11 hours:hour minutes:minute];
            arrofdates = [self fetchNext64DaysforDayindex:11 withTime:time_];
        }
        else if([day isEqualToString:@"Thursday"]) {
            NSDate *time_ = [self fetchNextSelectedDay:12 hours:hour minutes:minute];
            arrofdates = [self fetchNext64DaysforDayindex:12 withTime:time_];
        } 
        NSSet *timelogSet = [self setLocalNotifications:arrofdates withDay:day withUID:uuid context:context activity:group];
            
        group.times = timelogSet;
        group.dog = dog;
        NSMutableSet *set = [dog.activities mutableCopy];
        [set addObject:group];
        dog.activities = nil;
        dog.activities = set;
            
        NSError *error;
		if (![context save:&error]) {
			NSLog(@"Whoops, couldn't save: %@", [error description]);
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure" message:@"Unable to save record at the moment." delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
		else {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Activity has been saved." delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
			[alert show];
			[alert release];
            [self dismissModalViewControllerAnimated:YES];
		}
    }
}

#pragma mark - Extra methods

- (NSString *)uniqueString
{
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge NSString *)uuidStr;
} 

- (NSDate *) fetchNextSelectedDay:(int)index hours:(int)hours_ minutes:(int)minutes_ {
    NSDateComponents *weekdayComponents = [[NSCalendar currentCalendar] components:(NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:[NSDate date]];
    int currentWeekday = [weekdayComponents weekday]; //[1;7] ... 1 is sunday, 7 is saturday in gregorian calendar
    
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    [comp setDay:index - currentWeekday];   // add some days so it will become sunday
    
    [comp setWeek:-1];   // add weeks
    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [calendar setTimeZone:[NSTimeZone systemTimeZone]];
    
    NSDate *date = [[NSCalendar currentCalendar] dateByAddingComponents:comp toDate:[NSDate date] options:0];
    
    NSDateComponents *comps = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSYearCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSTimeZoneCalendarUnit) fromDate:date];
    [comps setHour:hours_];
    [comps setMinute:minutes_];
    return [calendar dateFromComponents:comps];
}

-(NSMutableArray *) fetchNext64DaysforDayindex:(int)index withTime:(NSDate *)time_ {
    NSLog(@"pickerDate: %@", time_);
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSDateComponents *dateComponents;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    dateComponents = [calendar components:NSWeekdayCalendarUnit fromDate:time_];
    NSLog(@"%d, %d", [dateComponents weekday], index);
    if ([dateComponents weekday]+7 == index) {
        [arr addObject:time_];
    }
    NSInteger firstMondayOrdinal = index - [dateComponents weekday];
    dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:firstMondayOrdinal];
    NSDate *firstMondayDate = [calendar dateByAddingComponents:dateComponents toDate:time_ options:0];
    
    dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setWeek:1];
    
    for (int i=0; i<500; i++) {
        [dateComponents setWeek:i];
        NSDate *mondayDate = [calendar dateByAddingComponents:dateComponents toDate:firstMondayDate options:0];
        [arr addObject:mondayDate];
    }
    return arr;
}

- (IBAction) goBack:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

-(NSSet *) setLocalNotifications:(NSMutableArray *)arr withDay:(NSString *)day withUID:(NSString *)uuid context:(NSManagedObjectContext *)context activity:(Activities *)activity_ {
    NSLog(@"%d", [arr count]);
    NSMutableSet *set = [NSMutableSet set];
    for (NSDate *date in arr) {
        Class cls = NSClassFromString(@"UILocalNotification");
        if (cls != nil) {
            UILocalNotification *notif = [[cls alloc] init];
            notif.fireDate = date;
            notif.timeZone = [NSTimeZone defaultTimeZone];
            notif.alertBody = @"You need to fed your dog";
            notif.alertAction = @"Ok";
            notif.soundName = UILocalNotificationDefaultSoundName;
            NSDictionary *userDict = [NSDictionary dictionaryWithObject:uuid 
                                                                 forKey:@"UUID"];
            notif.userInfo = userDict;
            [[UIApplication sharedApplication] scheduleLocalNotification:notif];
        }
        ActivityTimeLog *timelog = [NSEntityDescription
                                    insertNewObjectForEntityForName:@"ActivityTimeLog" 
                                    inManagedObjectContext:context];
        timelog.time = date;
        timelog.is_acheived = NO;
        timelog.activity = activity_;
        [set addObject:timelog];
    }
    return set;
}


#pragma mark - UIPicker delegate datasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    if (pickerView == time) {
        return 3;
    }
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    if (pickerView == type) {
        return [types count];
    }
    else {
        if (component == 0) {
            return [days count];
        }
        else if(component == 1) {
            return [hours count];
        }
        else if(component == 2) {
            return [minutes count];
        }
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    if (pickerView == type) {
        return [types objectAtIndex:row];
    }
    else {
        if (component == 0) {
            return [days objectAtIndex:row];
        }
        else if(component == 1) {
            return [hours objectAtIndex:row];
        }
        else if(component == 2) {
            return [minutes objectAtIndex:row];
        }
    }
    return @"";
}

@end
