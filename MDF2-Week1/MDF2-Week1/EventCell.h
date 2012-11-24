//
//  EventCell.h
//  MDF2-Week1
//
//  Created by Jeremy Fox on 11/24/12.
//  Copyright (c) 2012 Jeremy Fox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *calendarDay;
@property (weak, nonatomic) IBOutlet UILabel *calendarMonth;

@end
