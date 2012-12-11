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
                              showTimes:[NSArray arrayWithObjects:@"10:00 AM", @"12:00 PM", @"3:00 PM", nil]
                                  image:@"tickets"
                             trailerURL:[NSURL URLWithString:@"http://trailers.apple.com/movies/universal/oblivion/oblivion-tlr1_h480p.mov"]
                             andTheater:luckyStar],
                   [Movie movieWithName:@"Up In The Air"
                              showTimes:[NSArray arrayWithObjects:@"11:00 AM", @"1:00 PM", @"5:00 PM", nil]
                                  image:@"tickets"
                             trailerURL:[NSURL URLWithString:@"http://trailers.apple.com/movies/paramount/startrekintodarkness/startrekintodarkness-usajj60sneak_h480p.mov"]
                             andTheater:luckyStar],
                   [Movie movieWithName:@"Down"
                              showTimes:[NSArray arrayWithObjects:@"1:00 PM", @"1:45 PM", @"6:00 PM", @"7:00 PM", nil]
                                  image:@"tickets"
                             trailerURL:[NSURL URLWithString:@"http://trailers.apple.com/movies/fox_searchlight/hitchcock/hitchcock-clip2_h480p.mov"]
                             andTheater:luckyStar],
                   [Movie movieWithName:@"It Could Happen"
                              showTimes:[NSArray arrayWithObjects:@"11:15 AM", @"2:00 PM", nil]
                                  image:@"tickets"
                             trailerURL:[NSURL URLWithString:@"http://trailers.apple.com/movies/independent/waitingforlightning/waitingforlightning-clip2_h480p.mov"]
                             andTheater:luckyStar],
                   [Movie movieWithName:@"Why Me?"
                              showTimes:[NSArray arrayWithObjects:@"11:45 AM", @"12:00 PM", @"1:00 PM", @"2:30 PM", @"5:00 PM", nil]
                                  image:@"tickets"
                             trailerURL:[NSURL URLWithString:@"http://trailers.apple.com/movies/magnolia_pictures/thesorcererandthewhitesnake/sorcererandthewhitesnake-tlr1_h480p.mov"]
                             andTheater:luckyStar],
                   [Movie movieWithName:@"The Next Big Thing"
                              showTimes:[NSArray arrayWithObjects:@"9:00 AM", @"12:00 PM", @"3:00 PM", nil]
                                  image:@"tickets"
                             trailerURL:[NSURL URLWithString:@"http://trailers.apple.com/movies/dreamworks/thecroods/croods-tlr2_h480p.mov"]
                             andTheater:downTown],
                   [Movie movieWithName:@"Inside Out"
                              showTimes:[NSArray arrayWithObjects:@"12:00 PM", @"6:00 PM", nil]
                                  image:@"tickets"
                             trailerURL:[NSURL URLWithString:@"http://trailers.apple.com/movies/independent/tchoupitoulas/tchoup-clip1_h480p.mov"]
                             andTheater:downTown],
                   [Movie movieWithName:@"The Walk"
                              showTimes:[NSArray arrayWithObjects:@"1:00 PM", @"2:00 PM", @"2:45 PM", @"3:40 PM", @"5:15 PM", nil]
                                  image:@"tickets"
                             trailerURL:[NSURL URLWithString:@"http://trailers.apple.com/movies/independent/onlytheyoung/onlytheyoung-clip1_h480p.mov"]
                             andTheater:downTown],
                   [Movie movieWithName:@"Zero To Dusk"
                              showTimes:[NSArray arrayWithObjects:@"1:00 PM", @"3:40 PM", @"7:30 PM", nil]
                                  image:@"tickets"
                             trailerURL:[NSURL URLWithString:@"http://trailers.apple.com/movies/independent/awarewolfboy/warewolfboy-tlr1_h480p.mov"]
                             andTheater:downTown],
                   [Movie movieWithName:@"Dumb Me"
                              showTimes:[NSArray arrayWithObjects:@"3:00 PM", @"6:00 PM", @"8:00 PM", @"9:00 PM", nil]
                                  image:@"tickets"
                             trailerURL:[NSURL URLWithString:@"http://trailers.apple.com/movies/independent/upstreamcolor/upstreamcolor-tsr1_h480p.mov"]
                             andTheater:downTown],
                   [Movie movieWithName:@"Step It Out"
                              showTimes:[NSArray arrayWithObjects:@"6:00 PM", @"7:00 PM", @"9:00 PM", nil]
                                  image:@"tickets"
                             trailerURL:[NSURL URLWithString:@"http://trailers.apple.com/movies/independent/mollystheory/mollystheory-tlr1_h480p.mov"]
                             andTheater:superior],
                   [Movie movieWithName:@"Maximum Run"
                              showTimes:[NSArray arrayWithObjects:@"10:00 AM", @"3:00 PM", @"4:00 PM", nil]
                                  image:@"tickets"
                             trailerURL:[NSURL URLWithString:@"http://trailers.apple.com/movies/ifc_films/savethedate/savethedate-clip1_h480p.mov"]
                             andTheater:superior],
                   [Movie movieWithName:@"Explore The Wild"
                              showTimes:[NSArray arrayWithObjects:@"11:50 PM", @"5:20 PM", @"8:45 PM", @"10:10 PM", nil]
                                  image:@"tickets"
                             trailerURL:[NSURL URLWithString:@"http://trailers.apple.com/movies/focus_features/admission/admission-tlr1_h480p.mov"]
                             andTheater:superior],
                   [Movie movieWithName:@"Wishing You Were Here"
                              showTimes:[NSArray arrayWithObjects:@"4:10 PM", @"6:15 PM", @"9:40 PM", @"11:35 PM", nil]
                                  image:@"tickets"
                             trailerURL:[NSURL URLWithString:@"http://trailers.apple.com/movies/magnolia_pictures/deadfall/deadfall-clip2_h480p.mov"]
                             andTheater:superior],
                   [Movie movieWithName:@"Happy Joy Joy"
                              showTimes:[NSArray arrayWithObjects:@"11:00 AM", @"2:00 PM", @"9:05 PM", nil]
                                  image:@"tickets"
                             trailerURL:[NSURL URLWithString:@"http://trailers.apple.com/movies/independent/thehost/thehost-tlr2_h480p.mov"]
                             andTheater:superior],
                   nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
        NSArray* theaters = [Movie theatersForMovies:self.movies];
        Theater* theater = [theaters objectAtIndex:indexPath.section];
        Movie* movie = [[Movie moviesForTheater:theater fromMovies:self.movies] objectAtIndex:indexPath.row];
        DetailViewController* detailVC = (DetailViewController*)segue.destinationViewController;
        detailVC.movie = movie;
    }
}

@end
