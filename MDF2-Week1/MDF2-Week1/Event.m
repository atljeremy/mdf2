//
//  Event.m
//  MDF2-Week1
//
//  Created by Jeremy Fox on 11/24/12.
//  Copyright (c) 2012 Jeremy Fox. All rights reserved.
//

#import "Event.h"

@implementation Event

+ (Event*)event {
    return [[self alloc] init];
}

+ (Event*)newEventWithTitle:(NSString*)title location:(NSString*)location andDate:(NSDate*)date {
    
    NSParameterAssert(title);
    NSParameterAssert(location);
    NSParameterAssert(date);
    
    Event* event = [Event event];
    
    event.eventTitle = title;
    event.eventLocation = location;
    event.eventDateTime = date;
    event.eventCalendarTitle = @"Home";
    event.eventNotes = @"These are some static notes that could potentially be added to new events. \nThese are just static notes.";
    
    return event;
}

@end
