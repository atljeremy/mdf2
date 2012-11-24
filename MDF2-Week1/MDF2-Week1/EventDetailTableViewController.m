//
//  EventDetailViewController.m
//  MDF2-Week1
//
//  Created by Jeremy Fox on 11/24/12.
//  Copyright (c) 2012 Jeremy Fox. All rights reserved.
//

#import "EventDetailTableViewController.h"
#import "EventDetailCalendarCell.h"
#import "EventDetailInfoCell.h"
#import "EventDetailNotesCell.h"

#define kEventDetailInfoCell     @"EventDetailInfoCell"
#define kEventDetailCalendarCell @"EventDetailCalendarCell"
#define kEventDetailNotesCell    @"EventDetailNotesCell"

#define kNumberOfRowsInSection 3

#define kInfoRow     0
#define kCalendarRow 1
#define kNotesRow    2

@interface EventDetailTableViewController ()

@end

@implementation EventDetailTableViewController

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
    return kNumberOfRowsInSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    
    switch (indexPath.row) {
        case kInfoRow: {
            static NSString *CellIdentifier = kEventDetailInfoCell;
            EventDetailInfoCell *infoCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            
            infoCell.title.text = self.event.eventTitle;
            infoCell.location.text = self.event.eventLocation;
            
            NSDate *eventDate = self.event.eventDateTime;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"MMMM dd, yyyy";
            infoCell.date.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:eventDate]];
            
            dateFormatter.dateFormat = @"h:mm a";
            infoCell.time.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:eventDate]];
            
            return infoCell;
            
            break;
        }
            
        case kCalendarRow: {
            static NSString *CellIdentifier = kEventDetailCalendarCell;
            EventDetailCalendarCell *calendarCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            calendarCell.calendar.text = self.event.eventCalendarTitle;
            
            return calendarCell;
            
            break;
        }
            
        case kNotesRow: {
            static NSString *CellIdentifier = kEventDetailNotesCell;
            EventDetailNotesCell *notesCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            notesCell.notes.text = self.event.eventNotes;
            return notesCell;
            
            break;
        }
            
        default:
            break;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    int retVal = 0;
    switch (indexPath.row) {
        case kInfoRow:
            retVal = 113;
            break;
            
        case kCalendarRow:
            retVal = 43;
            break;
            
        case kNotesRow:
            retVal = 129;
            break;
            
        default:
            break;
    }
    
    return retVal;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
