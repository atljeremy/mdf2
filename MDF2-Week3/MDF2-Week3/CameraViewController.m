//
//  CameraViewController.m
//  MDF2-Week3
//
//  Created by Jeremy Fox on 12/3/12.
//  Copyright (c) 2012 Jeremy Fox. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

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
    
    self.imageReviewView.hidden = YES;
    [self.imageReviewView removeFromSuperview];
    
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
                                                        message:@"Your deivce does not support taking photos."
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"Ok", nil];
        [alert show];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
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
    self.imagePickerControl.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage, nil];
    self.imagePickerControl.allowsEditing = YES;
    self.imagePickerControl.showsCameraControls = YES;
    CGRect cameraFrame = self.imagePickerControl.view.frame;
    cameraFrame.size.height = self.view.frame.size.height;
    self.imagePickerControl.view.frame = cameraFrame;
    [self.view addSubview:self.imagePickerControl.view];
    if (![self.view.subviews containsObject:self.imageReviewView]) {
        [self.view addSubview:self.imageReviewView];
    } else {
        [self.view bringSubviewToFront:self.imageReviewView];
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

- (IBAction)cancelPhotos:(id)sender {
    [self hidePictureView];
}

- (IBAction)savePhotos:(id)sender {
    UIImage* origImg = self.originalImageView.image;
    UIImage* editedImg = self.editedImageView.image;
    
    if (origImg && editedImg) {
        UIImageWriteToSavedPhotosAlbum(origImg,
                                       self,
                                       @selector(image:finishedSavingWithError:contextInfo:),
                                       nil);
        UIImageWriteToSavedPhotosAlbum(editedImg,
                                       self,
                                       @selector(image:finishedSavingWithError:contextInfo:),
                                       nil);
    }
    
    [self hidePictureView];
}

- (void)hidePictureView {
    [self createNewImagePicker];
    [UIView animateWithDuration:0.3 animations:^{
        self.imageReviewView.alpha = 0.0;
    } completion:^(BOOL finished){
        self.imageReviewView.hidden = YES;
    }];
}

- (void)showPictureViewWithOriginalImage:(UIImage*)origImg andEditedImage:(UIImage*)editedImg {
    if (origImg && editedImg) {
        self.originalImageView.image = origImg;
        self.editedImageView.image = editedImg;

        self.imageReviewView.alpha = 0.0;
        self.imageReviewView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.imageReviewView.alpha = 1.0;
        }];
    } else {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Sorry!"
                                                        message:@"An unexpected error has occurred while trying to display your new photo. Please try again."
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - UIIMagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"INFO: %@", info);
    
    UIImage* origImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage* editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [self showPictureViewWithOriginalImage:origImage
                            andEditedImage:editedImage];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@""
                          message:@""
                          delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil];
    
    if (error) {
        [alert setTitle:@"Save Failed"];
        [alert setMessage:@"Failed to save image"];
    } else {
        [alert setTitle:@"Save Successful!"];
        [alert setMessage:@"Saved image to your photo album"];
    }
    
    [alert show];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
