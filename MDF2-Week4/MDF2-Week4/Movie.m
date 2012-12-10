//
//  Movie.m
//  MDF2-Week4
//
//  Created by Jeremy Fox on 12/9/12.
//  Copyright (c) 2012 Jeremy Fox. All rights reserved.
//

#import "Movie.h"

@implementation Movie

+ (Movie*)movieWithName:(NSString*)name
              showTimes:(NSArray*)showTimes
                  image:(NSString*)image
             trailerURL:(NSURL *)trailerURL
             andTheater:(Theater*)theater
{
    Movie* movie = nil;
    
    movie = [[Movie alloc] init];
    if (movie) {
        movie.movieName      = name;
        movie.movieShowTimes = showTimes;
        movie.movieImage     = image;
        movie.movieTheater   = theater;
    }
    
    return movie;
}

+ (NSArray*)theatersForMovies:(NSArray*)movies
{
    NSMutableArray* theaters = [NSMutableArray array];
    
    if (movies && movies.count > 0) {
        for (Movie* movie in movies) {
            if (movie && ![theaters containsObject:movie.movieTheater]) {
                [theaters addObject:movie.movieTheater];
            }
        }
    }
    
    return theaters;
}

+ (NSArray*)moviesForTheater:(Theater*)theater fromMovies:(NSArray*)movies
{
    NSMutableArray* moviesArray = [NSMutableArray array];
    
    if (theater && movies && movies.count > 0) {
        for (Movie* movie in movies) {
            if (movie && [movie.movieTheater.theaterName isEqualToString:theater.theaterName]) {
                [moviesArray addObject:movie];
            }
        }
    }
    
    return moviesArray;
}

- (NSString*)allShowtimes
{
    NSString* allShowtimes = @"";
    
    if (self.movieShowTimes && self.movieShowTimes.count > 0) {
        for (int i = 0; i < self.movieShowTimes.count; i++) {
            NSString* showTime = [self.movieShowTimes objectAtIndex:i];
            if (i == self.movieShowTimes.count - 1) {
                allShowtimes = [allShowtimes stringByAppendingFormat:@"%@", showTime];
            } else {
                allShowtimes = [allShowtimes stringByAppendingFormat:@"%@, ", showTime];
            }
        }
    }
    
    return allShowtimes;
}

@end
