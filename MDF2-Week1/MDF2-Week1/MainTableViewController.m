//
//  MainTableViewController.m
//  MDF2-Week1
//
//  Created by Jeremy Fox on 11/20/12.
//  Copyright (c) 2012 Jeremy Fox. All rights reserved.
//

#import "MainTableViewController.h"
#import "Event.h"
#import "EventCell.h"
#import "EventDetailTableViewController.h"

#define kEventTableCellIdentifier @"EventTableCellIdentifier"
#define kPushEventDetailsView @"PushEventDetailsView"

@interface MainTableViewController ()
@property (nonatomic, strong) NSMutableArray* events;

@end

@implementation MainTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.events = [NSMutableArray arrayWithCapacity:10];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    NSDate *date = [NSDate date];

    [components setDay:11];
    [components setMonth:1];
    [components setYear:2013];
    [components setHour:7];
    [components setMinute:20];
    date = [gregorian dateFromComponents:components];
    [self.events addObject:[Event newEventWithTitle:@"Visit Mom" location:@"Arkport, NY" andDate:date]];
    
    components = nil;
    components = [[NSDateComponents alloc] init];
    [components setDay:24];
    [components setMonth:2];
    [components setYear:2013];
    [components setHour:8];
    [components setMinute:25];
    date = [gregorian dateFromComponents:components];
    [self.events addObject:[Event newEventWithTitle:@"Pick up dry cleaning" location:@"Dansville, NY" andDate:date]];
    
    components = nil;
    components = [[NSDateComponents alloc] init];
    [components setDay:13];
    [components setMonth:3];
    [components setYear:2013];
    [components setHour:9];
    [components setMinute:30];
    date = [gregorian dateFromComponents:components];
    [self.events addObject:[Event newEventWithTitle:@"Bella's soccer practice" location:@"Athens, GA" andDate:date]];

    components = nil;
    components = [[NSDateComponents alloc] init];
    [components setDay:9];
    [components setMonth:4];
    [components setYear:2013];
    [components setHour:10];
    [components setMinute:35];
    date = [gregorian dateFromComponents:components];
    [self.events addObject:[Event newEventWithTitle:@"Finish school work" location:@"Home Office" andDate:date]];
    
    components = nil;
    components = [[NSDateComponents alloc] init];
    [components setDay:10];
    [components setMonth:5];
    [components setYear:2013];
    [components setHour:11];
    [components setMinute:40];
    date = [gregorian dateFromComponents:components];
    [self.events addObject:[Event newEventWithTitle:@"Pick up TV console" location:@"Lowes, Athens, GA" andDate:date]];
    
    components = nil;
    components = [[NSDateComponents alloc] init];
    [components setDay:8];
    [components setMonth:6];
    [components setYear:2013];
    [components setHour:12];
    [components setMinute:45];
    date = [gregorian dateFromComponents:components];
    [self.events addObject:[Event newEventWithTitle:@"Pick up Courtney" location:@"At the house" andDate:date]];
    
    components = nil;
    components = [[NSDateComponents alloc] init];
    [components setDay:27];
    [components setMonth:7];
    [components setYear:2013];
    [components setHour:13];
    [components setMinute:50];
    date = [gregorian dateFromComponents:components];
    [self.events addObject:[Event newEventWithTitle:@"Dental Appointment" location:@"Norcross, NY" andDate:date]];
    
    components = nil;
    components = [[NSDateComponents alloc] init];
    [components setDay:3];
    [components setMonth:8];
    [components setYear:2013];
    [components setHour:14];
    [components setMinute:55];
    date = [gregorian dateFromComponents:components];
    [self.events addObject:[Event newEventWithTitle:@"Rock out!" location:@"Athens, NY" andDate:date]];
    
    components = nil;
    components = [[NSDateComponents alloc] init];
    [components setDay:1];
    [components setMonth:9];
    [components setYear:2013];
    [components setHour:15];
    [components setMinute:00];
    date = [gregorian dateFromComponents:components];
    [self.events addObject:[Event newEventWithTitle:@"Go for a bike ride" location:@"Atlanta, NY" andDate:date]];
    
    components = nil;
    components = [[NSDateComponents alloc] init];
    [components setDay:18];
    [components setMonth:10];
    [components setYear:2013];
    [components setHour:16];
    [components setMinute:05];
    date = [gregorian dateFromComponents:components];
    [self.events addObject:[Event newEventWithTitle:@"Going skydiving" location:@"Rochester, NY" andDate:date]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Event* currentEvent = [self.events objectAtIndex:indexPath.row];
    
    static NSString *CellIdentifier = kEventTableCellIdentifier;
    EventCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.title.text = currentEvent.eventTitle;
    
    NSDate *eventDate = currentEvent.eventDateTime;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM/dd/yy h:mm a";
    cell.date.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:eventDate]];
    
    dateFormatter.dateFormat = @"dd";
    cell.calendarDay.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:eventDate]];
    
    dateFormatter.dateFormat = @"MMMM";
    cell.calendarMonth.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:eventDate]];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:kPushEventDetailsView sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:kPushEventDetailsView]) {
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        Event* event = [self.events objectAtIndex:path.row];
        [(EventDetailTableViewController*)segue.destinationViewController setEvent:event];
    }
}

@end
