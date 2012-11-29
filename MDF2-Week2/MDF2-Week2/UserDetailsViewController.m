//
//  UserDetailsViewController.m
//  MDF2-Week2
//
//  Created by Jeremy Fox on 11/28/12.
//  Copyright (c) 2012 Jeremy Fox. All rights reserved.
//

#import "UserDetailsViewController.h"

@interface UserDetailsViewController ()

@end

@implementation UserDetailsViewController

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
    
	[self loadUserDetails];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadUserDetails {
    self.username.hidden = YES;
    self.actualName.hidden = YES;
    self.followers.hidden = YES;
    self.friends.hidden = YES;
    self.description.hidden = YES;
    self.followersTitle.hidden = YES;
    self.friendsTitle.hidden = YES;
    [self.activityIndicator startAnimating];
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        ACAccountStore *acStore = [[ACAccountStore alloc] init];
        ACAccountType *twitterAccountType = [acStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        
        if (acStore && twitterAccountType) {
            [acStore requestAccessToAccountsWithType:twitterAccountType options:nil completion:^(BOOL granted, NSError *error) {
                if (granted) {
                    NSArray *accounts = [acStore accountsWithAccountType:twitterAccountType];
                    ACAccount *twitterAccount = nil;
                    if (accounts && accounts.count > 0) {
                        
                        twitterAccount = [accounts lastObject];
                        NSString* url = [NSString stringWithFormat:@"https://api.twitter.com/1/users/show.json?screen_name=%@", twitterAccount.username];
                        NSURL *twitterURL = [[NSURL alloc] initWithString:url];
                        
                        SLRequest *requestUsersTweets = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                                           requestMethod:SLRequestMethodGET
                                                                                     URL:twitterURL
                                                                              parameters:nil];
                        [requestUsersTweets setAccount:twitterAccount];
                        
                        [requestUsersTweets performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error2) {
                            
                            self.userObject = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
                            NSLog(@"%@", self.userObject);
                            NSLog(@"Response Code: %i", [urlResponse statusCode]);
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [self setUserDetails];
                            });
                            
                        }];
                        
                    } else {
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self setUserDetails];
                        });
                        
                    }
                    
                } else {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self setUserDetails];
                        NSLog(@"Permission Not Granted");
                        NSLog(@"Error: %@", error);
                    });
                    
                }
            }];
        }
        
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setUserDetails];
            [self showTwitterAccountError];
        });
    }
}

- (void)showTwitterAccountError {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"No Twitter Account"
                                                    message:@"Sorry, We were not able to find a Twitter account. Please open the Settings application and login to a Twitter account and return to the application."
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)setUserDetails {
    if (self.userObject) {
        NSString* username    = @"";
        NSString* actualName  = @"";
        NSString* followers   = @"";
        NSString* friends     = @"";
        NSString* description = @"";
        
        username    = [self.userObject objectForKey:kTweetUserScreenNameKey];
        actualName  = [self.userObject objectForKey:kUserNameKey];
        followers   = [NSString stringWithFormat:@"%@", [self.userObject objectForKey:kUserFollowersCountKey]];
        friends     = [NSString stringWithFormat:@"%@", [self.userObject objectForKey:kUserFriendsCountKey]];
        description = [self.userObject objectForKey:kUserDescriptionKey];
        
        if (username.length > 0) {
            self.username.text = username;
        }
        if (actualName.length > 0) {
            self.actualName.text = actualName;
        }
        if (followers.length > 0) {
            self.followers.text = followers;
        }
        if (friends.length > 0) {
            self.friends.text = friends;
        }
        if (description.length > 0) {
            self.description.text = description;
            [self.description sizeToFit];
        }
        
    } else {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                        message:@"An unexpected error has occurred. Please try again."
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }
    self.username.hidden = NO;
    self.actualName.hidden = NO;
    self.followers.hidden = NO;
    self.friends.hidden = NO;
    self.description.hidden = NO;
    self.followersTitle.hidden = NO;
    self.friendsTitle.hidden = NO;
    [self.activityIndicator stopAnimating];
}

- (IBAction)dsimissUserDetailsView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
