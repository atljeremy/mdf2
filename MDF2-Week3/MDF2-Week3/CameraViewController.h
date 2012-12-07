//
//  CameraViewController.h
//  MDF2-Week3
//
//  Created by Jeremy Fox on 12/3/12.
//  Copyright (c) 2012 Jeremy Fox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface CameraViewController : BaseViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UIImagePickerController* imagePickerControl;
@property (weak, nonatomic) IBOutlet UIView *imageReviewView;
@property (weak, nonatomic) IBOutlet UIImageView *originalImageView;
@property (weak, nonatomic) IBOutlet UIImageView *editedImageView;

- (IBAction)cancelPhotos:(id)sender;
- (IBAction)savePhotos:(id)sender;
- (IBAction)dismissCamera:(id)sender;

@end
