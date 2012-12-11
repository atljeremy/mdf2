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
    
    if (!self.moviePlayer && self.movieURL) {
        self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:self.movieURL];
        [self.moviePlayer setShouldAutoplay:YES];
        [self.moviePlayer setScalingMode:MPMovieScalingModeAspectFit];
        CGRect viewFrame = self.view.frame;
        viewFrame.origin.y -= 64;
        self.moviePlayer.view.frame = viewFrame;
    }
    
    if (self.moviePlayer) {
        [self.moviePlayer prepareToPlay];
        [self.view addSubview:self.moviePlayer.view];
        [self.moviePlayer play];
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
