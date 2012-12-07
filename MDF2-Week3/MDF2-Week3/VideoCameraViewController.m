//
//  VideoCameraViewController.m
//  MDF2-Week3
//
//  Created by Jeremy Fox on 12/3/12.
//  Copyright (c) 2012 Jeremy Fox. All rights reserved.
//

#import "VideoCameraViewController.h"

@interface VideoCameraViewController ()
@property (nonatomic, strong) NSString *moviePath;

@end

@implementation VideoCameraViewController

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
	
    self.videoReviewView.hidden = YES;
    [self.videoReviewView removeFromSuperview];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [self createNewImagePicker];
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Please Note"
                                                        message:@"To exit the camera and return to the main screen, simply swipe from left to right anywhere on the screen at anytime."
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];

    } else {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Sorry!"
                                                        message:@"Your deivce does not support taking videos."
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"Ok", nil];
        [alert show];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.moviePath = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createNewImagePicker {
    if (self.imagePickerControl) {
        for (UIGestureRecognizer* recongizer in self.imagePickerControl.view.gestureRecognizers) {
            if (recongizer) {
                [self.imagePickerControl.view removeGestureRecognizer:recongizer];
            }
        }
        [self.imagePickerControl.view removeFromSuperview];
        self.imagePickerControl = nil;
    }
    self.imagePickerControl = [[UIImagePickerController alloc] init];
    self.imagePickerControl.delegate = self;
    self.imagePickerControl.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePickerControl.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeMovie, nil];
    self.imagePickerControl.allowsEditing = NO;
    self.imagePickerControl.showsCameraControls = YES;
    self.imagePickerControl.videoQuality = UIImagePickerControllerQualityTypeMedium;
    self.imagePickerControl.videoMaximumDuration = 20;
    CGRect cameraFrame = self.imagePickerControl.view.frame;
    cameraFrame.size.height = self.view.frame.size.height;
    self.imagePickerControl.view.frame = cameraFrame;
    [self.view addSubview:self.imagePickerControl.view];
    if (![self.view.subviews containsObject:self.videoReviewView]) {
        [self.view addSubview:self.videoReviewView];
    } else {
        [self.view bringSubviewToFront:self.videoReviewView];
    }
    
    UISwipeGestureRecognizer* swipeRecognizer = [[UISwipeGestureRecognizer alloc]
                                                 initWithTarget:self
                                                 action:@selector(dismissCamera:)];
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.imagePickerControl.view addGestureRecognizer:swipeRecognizer];
}

- (IBAction)dismissCamera:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)cancelVideo:(id)sender {
    [self hideConfirmationView];
}

- (IBAction)saveVideo:(id)sender {
    if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(self.moviePath))
    {
        // Copy it to the camera roll.
        UISaveVideoAtPathToSavedPhotosAlbum(self.moviePath, self, @selector(video:didFinishSavingWithError:contextInfo:), (__bridge void *)(self.moviePath));
    }
    
    [self hideConfirmationView];
}

- (void)hideConfirmationView {
    self.moviePath = nil;
    [self createNewImagePicker];
    [UIView animateWithDuration:0.3 animations:^{
        self.videoReviewView.alpha = 0.0;
    } completion:^(BOOL finished){
        self.videoReviewView.hidden = YES;
    }];
}

- (void)showConfirmationViewWithVideoURL:(NSString*)moviePath {
    if (moviePath) {
        
        self.videoReviewView.alpha = 0.0;
        self.videoReviewView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.videoReviewView.alpha = 1.0;
        }];

    } else {
        [self showErrorDialog];
    }
}

- (void)showErrorDialog {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Sorry!"
                                                    message:@"An unexpected error has occurred. Please try again."
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark - UIIMagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"INFO: %@", info);
    
    self.moviePath = [[info objectForKey:UIImagePickerControllerMediaURL] path];
    
    [self showConfirmationViewWithVideoURL:self.moviePath];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@""
                          message:@""
                          delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil];
    
    if (error) {
        [alert setTitle:@"Save Failed"];
        [alert setMessage:@"Failed to save video"];
    } else {
        [alert setTitle:@"Save Successful!"];
        [alert setMessage:@"Saved video to your photo album"];
    }
    
    [alert show];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
