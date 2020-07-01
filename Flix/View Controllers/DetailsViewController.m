 //
//  DetailsViewController.m
//  Flix
//
//  Created by meganyu on 6/24/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TrailerViewController.h"
#import "PosterViewController.h"
#import "MovieAPIManager.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backdropView;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property (strong, nonatomic) NSURL *trailerURL;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.movie.title;
    
    self.posterView.layer.shadowColor = UIColor.darkGrayColor.CGColor;
    self.posterView.layer.shadowOffset = CGSizeMake(5.0, 5.0);
    self.posterView.layer.shadowRadius = 25.0;
    self.posterView.layer.shadowOpacity = 0.9;
    self.posterView.layer.cornerRadius = 25.0;
    self.posterView.clipsToBounds = YES;
    [self.posterView setImageWithURL:self.movie.largePosterUrl];
    [self.backdropView setImageWithURL:self.movie.backdropUrl];
    
    [self.titleLabel setFont:[UIFont fontWithName:@"GeezaPro-Bold" size:30]];
    [self.titleLabel setTextColor:[UIColor blackColor]];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.synopsisLabel setFont:[UIFont fontWithName:@"GeezaPro" size:16]];
    [self.synopsisLabel setTextColor:[UIColor blackColor]];
    [self.ratingLabel setTextColor:[UIColor grayColor]];
    
    self.titleLabel.text = self.movie.title;
    self.synopsisLabel.text = self.movie.overview;
    self.ratingLabel.text = [NSString stringWithFormat:@"Rating: %@", self.movie.rating];
    
    [self fetchTrailer]; // FIXME: I'd like to call this in the prepareForSegue so that it only fetches it once I click the poster
    
    // You don't do this in auto layout world
//    [self.titleLabel sizeToFit];
//    [self.synopsisLabel sizeToFit];
}

- (void)fetchTrailer {
    NSString *movieID = self.movie.movieID;
    [[MovieAPIManager shared] fetchTrailerURL:^(NSURL *trailerURL, NSError *error) {
           if (error != nil) {
               NSString *errorMessage = [error localizedDescription];
               UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Network Error"
                      message:errorMessage
               preferredStyle:(UIAlertControllerStyleAlert)];
               
               UIAlertAction *tryAgainAction = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                   [self fetchTrailer];
               }];
               [alert addAction:tryAgainAction];
               [self presentViewController:alert animated:YES completion:nil];
           } else {
               self.trailerURL = trailerURL;
           }
       } forMovie:movieID];
}

- (IBAction)onPosterTap:(UITapGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"posterSegue" sender:nil];
}

- (IBAction)onButtonTap:(id)sender {
    [self performSegueWithIdentifier:@"trailerSegue" sender:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"trailerSegue"]) {
        TrailerViewController *trailerViewController = segue.destinationViewController;
        //[self fetchTrailerURL];
        NSLog(@"The trailer URL is %@", self.trailerURL);
        trailerViewController.trailerURL = self.trailerURL;
    } else if ([[segue identifier] isEqualToString:@"posterSegue"]) {
        PosterViewController *posterViewController = segue.destinationViewController;
        NSLog(@"The poster URL is %@", self.movie.largePosterUrl);
        posterViewController.posterURL = self.movie.largePosterUrl;
        NSLog(@"Tapping on a poster!");
    }
}

@end
