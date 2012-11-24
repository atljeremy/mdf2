//
//  CreateEventViewController.h
//  MDF2-Week1
//
//  Created by Jeremy Fox on 11/24/12.
//  Copyright (c) 2012 Jeremy Fox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateEventViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *eventTitle;
@property (weak, nonatomic) IBOutlet UITextField *eventLocation;
@property (weak, nonatomic) IBOutlet UIDatePicker *eventDatePicker;

- (IBAction)dismissKeyboard:(id)sender;
- (IBAction)dsimissCreateEventView:(id)sender;
- (IBAction)saveEvent:(id)sender;

@end
