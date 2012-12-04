//
//  CameraViewController.h
//  MDF2-Week3
//
//  Created by Jeremy Fox on 12/3/12.
//  Copyright (c) 2012 Jeremy Fox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface CameraViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UIImagePickerController* imagePickerControl;

@end
