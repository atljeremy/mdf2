//
//  CalendarViewController.m
//  MDF2-Week1
//
//  Created by Jeremy Fox on 11/24/12.
//  Copyright (c) 2012 Jeremy Fox. All rights reserved.
//

#import "CalendarTableViewController.h"
#import <EventKit/EventKit.h>
#import "CalendarTableViewCell.h"

#define kCalendarTableViewCell @"CalendarTableViewCell"

@interface CalendarTableViewController ()
@property (nonatomic, strong) NSMutableArray* calendars;
@property (nonatomic, strong) EKEventStore* store;
@end

@implementation CalendarTableViewController

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
	// Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.calendars = [NSMutableArray array];
    
    self.store = [[EKEventStore alloc] init];
    [self.store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (granted) {
            self.calendars = [[self.store calendarsForEntityType:EKEntityTypeEvent] mutableCopy];
            [self.tableView reloadData];
        } else {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Access Denied"
                                                            message:@"Sorry, but without being granted access to your calendars, we will be unable to select a default calendar."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dsimissCalendarSelection:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.calendars.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EKCalendar* selectedCalendar = [self.calendars objectAtIndex:indexPath.row];
    
    static NSString *CellIdentifier = kCalendarTableViewCell;
    CalendarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.title.text = selectedCalendar.title;
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    
    NSString* storedDefaultCalID = [[NSUserDefaults standardUserDefaults] objectForKey:kUserSelectedDefaultCalendar];
    if (storedDefaultCalID) {
        EKCalendar* storedCal = [self.store calendarWithIdentifier:storedDefaultCalID];
        if (storedCal && [storedCal.calendarIdentifier isEqualToString:selectedCalendar.calendarIdentifier]) {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    EKCalendar* calendar = [self.calendars objectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:calendar.calendarIdentifier forKey:kUserSelectedDefaultCalendar];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
