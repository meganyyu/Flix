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

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backdropView;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) NSURL *trailerURL;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = self.movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    [self.posterView setImageWithURL:posterURL];
    
    NSString *backdropURLString = self.movie[@"backdrop_path"];
    NSString *fullBackdropURLString = [baseURLString stringByAppendingString:backdropURLString];
    
    NSURL *backdropURL = [NSURL URLWithString:fullBackdropURLString];
    [self.backdropView setImageWithURL:backdropURL];
    
    self.titleLabel.text = self.movie[@"title"];
    self.synopsisLabel.text = self.movie[@"overview"];
    
    [self fetchTrailerURL]; // FIXME: I'd like to call this in the prepareForSegue so that it only fetches it once I click the poster, but the network request is too slow so the composed URL doesn't get saved fast enough so I just called it here. Alternative?
    
    // You don't do this in auto layout world
    [self.titleLabel sizeToFit];
    [self.synopsisLabel sizeToFit];
}

- (void)fetchTrailerURL {
    NSString *movieID = self.movie[@"id"];
    
    NSString *APIBaseURLString = @"https://api.themoviedb.org/3/movie/";
    NSString *APIKeyString = @"/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed";
    NSString *fullAPIURLString = [NSString stringWithFormat:@"%@%@%@", APIBaseURLString, movieID, APIKeyString];
    NSURL *url = [NSURL URLWithString:fullAPIURLString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSString *errorMessage = [error localizedDescription];
               UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Network Error"
                      message:errorMessage
               preferredStyle:(UIAlertControllerStyleAlert)];
               
               UIAlertAction *tryAgainAction = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                   [self fetchTrailerURL];
               }];
               [alert addAction:tryAgainAction];
               
               [self presentViewController:alert animated:YES completion:nil];
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               
               NSArray *results = dataDictionary[@"results"];
               NSString *trailerKey = results[0][@"key"];
               NSLog(@"The trailer key is: %@", trailerKey);
               NSString *baseURLString = @"https://www.youtube.com/watch?v=";
               NSString *fullTrailerURLString = [baseURLString stringByAppendingString:trailerKey];
               NSLog(@"The trailer URL is %@", fullTrailerURLString);
               self.trailerURL = [NSURL URLWithString:fullTrailerURLString];
           }
       }];
    [task resume];
}

- (IBAction)onPosterTap:(UITapGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"trailerSegue" sender:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TrailerViewController *trailerViewController = segue.destinationViewController;
    
    //[self fetchTrailerURL];
    NSLog(@"The final trailer URL is %@", self.trailerURL);
    trailerViewController.trailerURL = self.trailerURL;
    
    NSLog(@"Tapping on a poster!");
}

@end
