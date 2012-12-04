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
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
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
    } else {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Sorry!"
                                                        message:@"Your deivce does not support taking photos."
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"Ok", nil];
        [alert show];
    }

    UISwipeGestureRecognizer* swipeRecognizer = [[UISwipeGestureRecognizer alloc]
                                                 initWithTarget:self
                                                 action:@selector(dismissCamera:)];
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.imagePickerControl.view addGestureRecognizer:swipeRecognizer];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissCamera:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
            
        default:
            break;
    }
}

#pragma mark - UIIMagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"INFO: %@", info);
    
    UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
//    [self showPictureView];
//    self.picture.image = image;
    
    UIImageWriteToSavedPhotosAlbum(image,
                                   self,
                                   @selector(image:finishedSavingWithError:contextInfo:),
                                   nil);
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@""
                          message:@""
                          delegate:self
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil];
    
    if (error) {
        [alert setTitle:@"Save Failed"];
        [alert setMessage:@"Failed to save image"];
    } else {
        [alert setTitle:@"Save Successful!"];
        [alert setMessage:@"Saved original and edited images to your photo album"];
    }
    
    [alert show];
}


@end
