//
//  Event.h
//  MDF2-Week1
//
//  Created by Jeremy Fox on 11/24/12.
//  Copyright (c) 2012 Jeremy Fox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property (nonatomic, strong) NSString* eventTitle;
@property (nonatomic, strong) NSString* eventLocation;
@property (nonatomic, strong) NSDate*   eventDateTime;
@property (nonatomic, strong) NSString* eventCalendarTitle;
@property (nonatomic, strong) NSString* eventNotes;

+ (Event*)event;
+ (Event*)newEventWithTitle:(NSString*)title location:(NSString*)location andDate:(NSDate*)date;

@end
