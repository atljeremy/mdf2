//
//  MainTableViewController.m
//  MDF2-Week2
//
//  Created by Jeremy Fox on 11/25/12.
//  Copyright (c) 2012 Jeremy Fox. All rights reserved.
//

#import "MainViewController.h"
#import "MainTableCell.h"
#import "TweetDetailsViewController.h"

#define kMainTableViewCellIdentifier @"MainTableViewCell"
#define kMainTableCellHeight 100

@interface MainViewController ()
@property (nonatomic, strong) NSMutableArray* jsonResponse;
@property (nonatomic, strong) UIAlertView* loadingAlert;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self refreshTimeline:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Social

- (void)checkTwitterStatus {
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
                         NSURL *twitterURL = [[NSURL alloc] initWithString:@"https://api.twitter.com/1.1/statuses/home_timeline.json"];
                         
                         SLRequest *requestUsersTweets = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                                            requestMethod:SLRequestMethodGET
                                                                                      URL:twitterURL
                                                                               parameters:nil];
                         [requestUsersTweets setAccount:twitterAccount];
                         
                         [requestUsersTweets performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error2) {
                              
                              self.jsonResponse = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
                              NSLog(@"%@", self.jsonResponse);
                              NSLog(@"Response Code: %i", [urlResponse statusCode]);
                             
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  [self hideLoadingAlert];
                                  [self.tableView reloadData];
                              });
                              
                          }];

                     } else {
                         
                          dispatch_async(dispatch_get_main_queue(), ^{
                              [self hideLoadingAlert];
                              [self showTwitterAccountError];
                          });
                         
                     }
                     
                 } else {
                     
                      dispatch_async(dispatch_get_main_queue(), ^{
                          [self hideLoadingAlert];
                          NSLog(@"Permission Not Granted");
                          NSLog(@"Error: %@", error);
                      });
                     
                 }
             }];
        }
        
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideLoadingAlert];
            [self showTwitterAccountError];
        });
    }
}

- (IBAction)composeTweet:(id)sender {
    SLComposeViewController *composeController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    [composeController setInitialText:@"This is my awesome tweet!"];
    
    [self presentViewController:composeController
                       animated:YES
                     completion:nil];
}

- (IBAction)refreshTimeline:(id)sender {
    [self showLoadingAlert];
    dispatch_queue_t imageQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(imageQueue, ^{
        [self checkTwitterStatus];
    });

}

- (void)showLoadingAlert {
    if (!self.loadingAlert) {
        self.loadingAlert = [[UIAlertView alloc] initWithTitle:@"Loading"
                                                       message:@"\n\n"
                                                      delegate:nil
                                             cancelButtonTitle:nil
                                             otherButtonTitles:nil];
        
        UIActivityIndicatorView *actIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        actIndicator.center = CGPointMake(139.5, 75.5); // .5 so it doesn't blur
        [self.loadingAlert addSubview:actIndicator];
        [actIndicator startAnimating];
    }
    [self.loadingAlert show];
}

- (void)hideLoadingAlert {
    if (self.loadingAlert) {
        [self.loadingAlert dismissWithClickedButtonIndex:0 animated:YES];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.jsonResponse.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = kMainTableViewCellIdentifier;
    MainTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary* tweetObj = [self.jsonResponse objectAtIndex:indexPath.row];
    NSString* tweetText = @"";
    NSString* tweetDate = @"";
    NSString* tweetUser = @"";
    NSURL* userImageURL = nil;
    if (tweetObj) {
        
        // Get the tweet text
        tweetText = [tweetObj objectForKey:kTweetTextKey];
        
        // Get the tweet date
        NSString* tempTweetDate = [tweetObj objectForKey:kTweetCreatedAtKey];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"eee MMM dd HH:mm:ss ZZZZ yyyy"];
        NSDate *origDate = [dateFormatter dateFromString:tempTweetDate];
        [dateFormatter setDateFormat:@"MM/dd/yy h:mm a"];
        tweetDate = [dateFormatter stringFromDate:origDate];
        
        // Get the "user" object
        NSDictionary* userObj = [tweetObj objectForKey:kTweetUserObjectKey];
        if (userObj) {
            
            // Get the username
            tweetUser = [userObj objectForKey:kTweetUserScreenNameKey];
            
            userImageURL = [NSURL URLWithString:[userObj objectForKey:kTweetUserProfileImageURLKey]];
            
        }
    }
    
    if (tweetText.length > 0) {
        cell.postText.text = tweetText;
    }
    if (tweetDate.length > 0) {
        cell.postDateTime.text = tweetDate;
    }
    if (tweetUser.length > 0) {
        cell.postUsername.text = tweetUser;
    }
    if (userImageURL) {
        [cell.icon setImageWithURL:userImageURL];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary* tweetObj = [self.jsonResponse objectAtIndex:indexPath.row];
    NSString* tweetText = @"";
    if (tweetObj) {
        // Get the tweet text
        tweetText = [tweetObj objectForKey:kTweetTextKey];
    }
    
    int height = 0;
    if (tweetText) {
        height = [NSString getHeightForString:tweetText font:[UIFont fontWithName:@"Arial" size:14]];
    } else {
        return kMainTableCellHeight;
    }
    
    return kMainTableCellHeight + height;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:kPushTweetDetailsView sender:self];
}

#pragma mark - Prepare For Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kPushTweetDetailsView]) {
        NSDictionary* tweetObj = [self.jsonResponse objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        if (tweetObj) {
            [(TweetDetailsViewController*)segue.destinationViewController setTweetObj:tweetObj];
        }
    }
}

@end
