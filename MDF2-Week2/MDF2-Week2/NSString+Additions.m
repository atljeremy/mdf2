//
//  NSString+Additions.m
//  MDF2-Week2
//
//  Created by Jeremy Fox on 11/27/12.
//  Copyright (c) 2012 Jeremy Fox. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

+ (int)getHeightForString:(NSString *)inputString font:(UIFont *)font {
    int labelHeight;
    CGSize maxSize = CGSizeMake(213.0, 300.0);
    
    CGSize labelSize = [inputString sizeWithFont:font
                               constrainedToSize:maxSize
                                   lineBreakMode:NSLineBreakByWordWrapping];
    
    labelHeight = labelSize.height;
    
    return labelHeight;
}

@end
