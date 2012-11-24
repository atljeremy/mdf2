//
//  EventDetailViewController.h
//  MDF2-Week1
//
//  Created by Jeremy Fox on 11/24/12.
//  Copyright (c) 2012 Jeremy Fox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventDetailTableViewController : UITableViewController

@property (nonatomic, weak) Event* event;

@end
