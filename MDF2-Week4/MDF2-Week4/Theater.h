//
//  Theater.h
//  MDF2-Week4
//
//  Created by Jeremy Fox on 12/9/12.
//  Copyright (c) 2012 Jeremy Fox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Theater : NSObject

@property (nonatomic, strong) NSString* theaterName;
@property (nonatomic, strong) NSString* theaterLocation;
@property (nonatomic, strong) NSString* theaterImage;

+ (Theater*)theaterWithName:(NSString*)name location:(NSString*)location andImage:(NSString*)image;

@end
