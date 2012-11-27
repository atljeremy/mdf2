//
//  MainTableCell.h
//  MDF2-Week2
//
//  Created by Jeremy Fox on 11/25/12.
//  Copyright (c) 2012 Jeremy Fox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel* postText;
@property (nonatomic, weak) IBOutlet UILabel* postUsername;
@property (nonatomic, weak) IBOutlet UILabel* postDateTime;
@property (nonatomic, weak) IBOutlet UIImageView* icon;

@end
