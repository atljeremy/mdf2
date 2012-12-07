//
//  VideoCameraViewController.h
//  MDF2-Week3
//
//  Created by Jeremy Fox on 12/3/12.
//  Copyright (c) 2012 Jeremy Fox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface VideoCameraViewController : BaseViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) UIImagePickerController* imagePickerControl;
@property (weak, nonatomic) IBOutlet UIView *videoReviewView;

- (IBAction)dismissCamera:(id)sender;
- (IBAction)cancelVideo:(id)sender;
- (IBAction)saveVideo:(id)sender;

@end
