//
//  MainTableViewController.h
//  MDF2-Week2
//
//  Created by Jeremy Fox on 11/25/12.
//  Copyright (c) 2012 Jeremy Fox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)composeTweet:(id)sender;
- (IBAction)refreshTimeline:(id)sender;

@end
