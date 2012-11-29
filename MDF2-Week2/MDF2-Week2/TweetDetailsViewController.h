//
//  TweetDetailsViewController.h
//  MDF2-Week2
//
//  Created by Jeremy Fox on 11/28/12.
//  Copyright (c) 2012 Jeremy Fox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetDetailsViewController : UIViewController

@property (nonatomic, weak) NSDictionary* tweetObj;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;

@end
