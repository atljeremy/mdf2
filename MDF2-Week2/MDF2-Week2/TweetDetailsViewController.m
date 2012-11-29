//
//  TweetDetailsViewController.m
//  MDF2-Week2
//
//  Created by Jeremy Fox on 11/28/12.
//  Copyright (c) 2012 Jeremy Fox. All rights reserved.
//

#import "TweetDetailsViewController.h"

@interface TweetDetailsViewController ()

@end

@implementation TweetDetailsViewController

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
	
    if (self.tweetObj) {
        NSString* tweetText = @"";
        NSString* tweetDate = @"";
        NSString* tweetUser = @"";
        NSURL* userImageURL = nil;
            
        // Get the tweet text
        tweetText = [self.tweetObj objectForKey:kTweetTextKey];
        
        // Get the tweet date
        NSString* tempTweetDate = [self.tweetObj objectForKey:kTweetCreatedAtKey];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"eee MMM dd HH:mm:ss ZZZZ yyyy"];
        NSDate *origDate = [dateFormatter dateFromString:tempTweetDate];
        [dateFormatter setDateFormat:@"MM/dd/yy h:mm a"];
        tweetDate = [dateFormatter stringFromDate:origDate];
        
        // Get the "user" object
        NSDictionary* userObj = [self.tweetObj objectForKey:kTweetUserObjectKey];
        if (userObj) {
            
            // Get the username
            tweetUser = [userObj objectForKey:kTweetUserScreenNameKey];
            
            userImageURL = [NSURL URLWithString:[userObj objectForKey:kTweetUserProfileImageURLKey]];
            
        }
        
        if (tweetText.length > 0) {
            self.tweetText.text = tweetText;
            [self.tweetText sizeToFit];
        }
        if (tweetDate.length > 0) {
            self.date.text = tweetDate;
        }
        if (tweetUser.length > 0) {
            self.username.text = tweetUser;
        }

    } else {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                        message:@"An unexpected error has occurred. Please try again."
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
