//
//  UserDetailsViewController.h
//  MDF2-Week2
//
//  Created by Jeremy Fox on 11/28/12.
//  Copyright (c) 2012 Jeremy Fox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDetailsViewController : UIViewController

@property (nonatomic, strong) NSDictionary* userObject;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *actualName;
@property (weak, nonatomic) IBOutlet UILabel *followers;
@property (weak, nonatomic) IBOutlet UILabel *friends;
@property (weak, nonatomic) IBOutlet UILabel *description;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *followersTitle;
@property (weak, nonatomic) IBOutlet UILabel *friendsTitle;

- (IBAction)dsimissUserDetailsView:(id)sender;
@end
