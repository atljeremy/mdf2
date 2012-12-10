//
//  Theater.m
//  MDF2-Week4
//
//  Created by Jeremy Fox on 12/9/12.
//  Copyright (c) 2012 Jeremy Fox. All rights reserved.
//

#import "Theater.h"

@implementation Theater

+ (Theater*)theaterWithName:(NSString*)name location:(NSString*)location andImage:(NSString*)image
{
    Theater* theater = nil;
    
    theater = [[Theater alloc] init];
    if (theater) {
        theater.theaterName     = name;
        theater.theaterLocation = location;
        theater.theaterImage    = image;
    }
    
    return theater;
}

@end
