//
//  MainTableViewController.m
//  MDF2-Week4
//
//  Created by Jeremy Fox on 12/9/12.
//  Copyright (c) 2012 Jeremy Fox. All rights reserved.
//

#import "MainTableViewController.h"
#import "DetailViewController.h"
#import "MainTableViewCell.h"
#import "Movie.h"
#import "Theater.h"

@interface MainTableViewController ()

@property (nonatomic, strong) NSArray* movies;

@end

@implementation MainTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Theater* luckyStar = [Theater theaterWithName:@"Lucky Star Cinemas"
                                         location:@"Athens, GA"
                                         andImage:@"lucky_star"];
    Theater* downTown = [Theater theaterWithName:@"Downtown Cinemas"
                                        location:@"Lawrenceville, GA"
                                        andImage:@"downtown"];
    Theater* superior = [Theater theaterWithName:@"Superior Cinemas"
                                        location:@"Duluth, GA"
                                        andImage:@"superior"];
    
    self.movies = [NSArray arrayWithObjects:
                   [Movie movieWithName:@"All Roads Collide"
                              showTimes:[NSArray arrayWithObjects:@"10:00", @"12:00", @"3:00", nil]
                                  image:@"one"
                             trailerURL:[NSURL URLWithString:@""]
                             andTheater:luckyStar],
                   [Movie movieWithName:@"Up In The Air"
                              showTimes:[NSArray arrayWithObjects:@"11:00", @"1:00", @"5:00", nil]
                                  image:@"two"
                             trailerURL:[NSURL URLWithString:@""]
                             andTheater:luckyStar],
                   [Movie movieWithName:@"Down"
                              showTimes:[NSArray arrayWithObjects:@"10:00", @"12:00", @"3:00", nil]
                                  image:@"three"
                             trailerURL:[NSURL URLWithString:@""]
                             andTheater:luckyStar],
                   [Movie movieWithName:@"It Could Happen"
                              showTimes:[NSArray arrayWithObjects:@"10:00", @"12:00", @"3:00", nil]
                                  image:@"four"
                             trailerURL:[NSURL URLWithString:@""]
                             andTheater:luckyStar],
                   [Movie movieWithName:@"Why Me?"
                              showTimes:[NSArray arrayWithObjects:@"10:00", @"12:00", @"3:00", nil]
                                  image:@"five"
                             trailerURL:[NSURL URLWithString:@""]
                             andTheater:luckyStar],
                   [Movie movieWithName:@"The Next"
                              showTimes:[NSArray arrayWithObjects:@"10:00", @"12:00", @"3:00", nil]
                                  image:@"six"
                             trailerURL:[NSURL URLWithString:@""]
                             andTheater:downTown],
                   [Movie movieWithName:@"Inside Out"
                              showTimes:[NSArray arrayWithObjects:@"10:00", @"12:00", @"3:00", nil]
                                  image:@"seven"
                             trailerURL:[NSURL URLWithString:@""]
                             andTheater:downTown],
                   [Movie movieWithName:@"The Walk"
                              showTimes:[NSArray arrayWithObjects:@"10:00", @"12:00", @"3:00", nil]
                                  image:@"eight"
                             trailerURL:[NSURL URLWithString:@""]
                             andTheater:downTown],
                   [Movie movieWithName:@"Zero To Dusk"
                              showTimes:[NSArray arrayWithObjects:@"10:00", @"12:00", @"3:00", nil]
                                  image:@"nine"
                             trailerURL:[NSURL URLWithString:@""]
                             andTheater:downTown],
                   [Movie movieWithName:@"Dumb Me"
                              showTimes:[NSArray arrayWithObjects:@"10:00", @"12:00", @"3:00", nil]
                                  image:@"ten"
                             trailerURL:[NSURL URLWithString:@""]
                             andTheater:downTown],
                   [Movie movieWithName:@"Step It Out"
                              showTimes:[NSArray arrayWithObjects:@"10:00", @"12:00", @"3:00", nil]
                                  image:@"eleven"
                             trailerURL:[NSURL URLWithString:@""]
                             andTheater:superior],
                   [Movie movieWithName:@"Maximum Run"
                              showTimes:[NSArray arrayWithObjects:@"10:00", @"12:00", @"3:00", nil]
                                  image:@"twelve"
                             trailerURL:[NSURL URLWithString:@""]
                             andTheater:superior],
                   [Movie movieWithName:@"Explore The Wild"
                              showTimes:[NSArray arrayWithObjects:@"10:00", @"12:00", @"3:00", nil]
                                  image:@"thirteen"
                             trailerURL:[NSURL URLWithString:@""]
                             andTheater:superior],
                   [Movie movieWithName:@"Wishing You Were Here"
                              showTimes:[NSArray arrayWithObjects:@"10:00", @"12:00", @"3:00", nil]
                                  image:@"fourteen"
                             trailerURL:[NSURL URLWithString:@""]
                             andTheater:superior],
                   [Movie movieWithName:@"Happy Joy Joy"
                              showTimes:[NSArray arrayWithObjects:@"10:00", @"12:00", @"3:00", nil]
                                  image:@"fifteen"
                             trailerURL:[NSURL URLWithString:@""]
                             andTheater:superior],
                   nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray* theaters = [Movie theatersForMovies:self.movies];
    Theater* theater = [theaters objectAtIndex:section];
    if (theater) {
        return theater.theaterName;
    }
    
    return @"Error Getting Theater Name";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[Movie theatersForMovies:self.movies] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* theaters = [Movie theatersForMovies:self.movies];
    Theater* theater = [theaters objectAtIndex:section];
    return [[Movie moviesForTheater:theater fromMovies:self.movies] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* theaters = [Movie theatersForMovies:self.movies];
    Theater* theater = [theaters objectAtIndex:indexPath.section];
    Movie* currentMovie = [[Movie moviesForTheater:theater fromMovies:self.movies] objectAtIndex:indexPath.row];
    
    static NSString *CellIdentifier = @"MovieCell";
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.movieImage.image = [UIImage imageNamed:currentMovie.movieImage];
    cell.movieTitle.text = currentMovie.movieName;
    cell.movieShowtimes.text = [currentMovie allShowtimes];
    
    return cell;
}

#pragma mark - UITableViewDelegate

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:kPushDetailsViewSegue sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([kPushDetailsViewSegue isEqualToString:segue.identifier]) {
        NSIndexPath* indexPath = [self.tableView indexPathForSelectedRow];
        Movie* movie = [self.movies objectAtIndex:indexPath.row];
        DetailViewController* detailVC = (DetailViewController*)segue.destinationViewController;
        detailVC.movie = movie;
    }
}

@end
