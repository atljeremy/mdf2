//
//  MovieViewController.m
//  MDF2-Week4
//
//  Created by Jeremy Fox on 12/9/12.
//  Copyright (c) 2012 Jeremy Fox. All rights reserved.
//

#import "MovieViewController.h"

@interface MovieViewController ()

@property (nonatomic, strong) MPMoviePlayerController* moviePlayer;

@end

@implementation MovieViewController

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
    
    if (!self.moviePlayer) {
        self.moviePlayer = [[MPMoviePlayerController alloc] init];
        self.moviePlayer.view.frame = self.view.frame;
        [self.view addSubview:self.moviePlayer.view];
    }
    
    if (self.movieURL && self.movieURL.length > 0) {
        [self.moviePlayer setContentURL:[NSURL URLWithString:self.movieURL]];
    } else {
        [self showUnexpectedErrorDialog];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)showUnexpectedErrorDialog {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Sorry!"
                                                    message:@"An unexpected error has occurred. Please try again."
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];

}

@end
