//
//  CreateEventViewController.m
//  MDF2-Week1
//
//  Created by Jeremy Fox on 11/24/12.
//  Copyright (c) 2012 Jeremy Fox. All rights reserved.
//

#import "CreateEventViewController.h"
#import <EventKit/EventKit.h>

#define kCancelButtonIndex 0
#define kSaveButtonIndex 1

@interface CreateEventViewController () <UITextFieldDelegate, UIAlertViewDelegate>

@end

@implementation CreateEventViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.eventLocation.delegate = self;
    self.eventTitle.delegate = self;
    
    [self.eventDatePicker setMinimumDate:[NSDate date]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dsimissCreateEventView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveEvent:(id)sender {
    
    [self dismissKeyboard:self];
    
    NSString* errors = @"Please fill in the following required fields: ";
    BOOL canSave = YES;
    
    if (self.eventTitle.text.length == 0) {
        errors = [errors stringByAppendingString:@"\nEvent Title"];
        canSave = NO;
    }
    if (self.eventLocation.text.length == 0) {
        errors = [errors stringByAppendingString:@"\nEvent Location"];
        canSave = NO;
    }
    
    UIAlertView* alert;
    if (canSave) {
        
        NSDate *eventDate = self.eventDatePicker.date;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"MMM dd, yyyy h:mm a";
        
        NSString* message = [NSString stringWithFormat:@"Please look over your event details and confirm all info is accurate. \n%@ \n%@ \n%@",
                             self.eventTitle.text,
                             self.eventLocation.text,
                             [dateFormatter stringFromDate:eventDate]];
        alert = [[UIAlertView alloc] initWithTitle:@"Event Confirmation"
                                           message:message
                                          delegate:self
                                 cancelButtonTitle:@"Cancel"
                                 otherButtonTitles:@"Save", nil];
    } else {
        alert = [[UIAlertView alloc] initWithTitle:@"Oops!"
                                           message:errors
                                          delegate:nil
                                 cancelButtonTitle:@"Ok"
                                 otherButtonTitles:nil];
    }
    
    [alert show];
}

- (IBAction)dismissKeyboard:(id)sender {
    if ([self.eventTitle isFirstResponder]) {
        [self.eventTitle resignFirstResponder];
    }
    if ([self.eventLocation isFirstResponder]) {
        [self.eventLocation resignFirstResponder];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self dismissKeyboard:self];
    return YES;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case kCancelButtonIndex:
            // Do Nothing
            break;
            
        case kSaveButtonIndex: {
            
            NSString* storedCalednarID = [[NSUserDefaults standardUserDefaults] objectForKey:kUserSelectedDefaultCalendar];
            if (storedCalednarID) {
                
                EKEventStore *store = [[EKEventStore alloc] init];
                
                EKCalendar* userSelectedCalendar = [store calendarWithIdentifier:storedCalednarID];
                
                EKEvent* newEvent = [EKEvent eventWithEventStore:store];
                newEvent.title = self.eventTitle.text;
                newEvent.location = self.eventLocation.text;
                newEvent.startDate = self.eventDatePicker.date;
                newEvent.endDate = self.eventDatePicker.date;
                newEvent.calendar = userSelectedCalendar;
                
                NSError* error;
                UIAlertView* alert;
                if ([store saveEvent:newEvent span:EKSpanThisEvent commit:YES error:&error]) {
                    alert = [[UIAlertView alloc] initWithTitle:@"Event Saved!"
                                                       message:@"Your event has been saved to your chosen default calendar."
                                                      delegate:nil
                                             cancelButtonTitle:@"Ok"
                                             otherButtonTitles:nil];
                    [alert show];
                    [self dismissViewControllerAnimated:YES completion:nil];
                } else {
                    alert = [[UIAlertView alloc] initWithTitle:@"Uh Oh!"
                                                       message:@"An unexpected error has occurred. Please try saving your event again."
                                                      delegate:nil
                                             cancelButtonTitle:@"Ok"
                                             otherButtonTitles:nil];
                    [alert show];
                }
                
            } else {
                
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Sorry!"
                                                                message:@"You haven't selected a default calendar yet. Please return to the Events screen and tap the button labelled \"default calendar\" to chose your default calendar."
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
                [alert show];
                
            }
            
            break;
        }
            
        default:
            break;
    }
}

@end
