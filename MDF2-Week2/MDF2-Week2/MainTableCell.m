//
//  MainTableCell.m
//  MDF2-Week2
//
//  Created by Jeremy Fox on 11/25/12.
//  Copyright (c) 2012 Jeremy Fox. All rights reserved.
//

#import "MainTableCell.h"

@implementation MainTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
