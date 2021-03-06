//
//  MoviesGridViewController.m
//  Flix
//
//  Created by meganyu on 6/24/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "MoviesGridViewController.h"
#import "MovieCollectionCell.h"
#import "UIImageView+AFNetworking.h"
#import "MBProgressHUD.h"
#import "DetailsViewController.h"

@interface MoviesGridViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) NSArray *movies;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSArray *filteredData;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation MoviesGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.searchBar.delegate = self;
    
    [self loadMovies];
    
    self.navigationItem.title = @"Explore";
    self.navigationItem.title = @"Explore";
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;
    
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5;
    
    CGFloat postersPerLine = 2;
    CGFloat itemWidth = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing * (postersPerLine - 1)) / postersPerLine;
    CGFloat itemHeight = itemWidth * 1.5;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
}

- (void)loadMovies {
    //[self.activityIndicator startAnimating];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
    hud.mode = MBProgressHUDModeDeterminate;
    hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
    NSLog(@"Started animation");
    dispatch_async(dispatch_get_global_queue( QOS_CLASS_USER_INITIATED, 0), ^{
        [self fetchMovies];
        dispatch_async(dispatch_get_main_queue(), ^{
            //[self.activityIndicator stopAnimating];
            [hud hideAnimated:YES afterDelay:2.f]; // FIXME: MBProgressHUD only works if I manually set a delay time?
            NSLog(@"Ended animation");
        });
    });
}

- (void)fetchMovies {
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSString *errorMessage = [error localizedDescription];
               UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Network Error"
                      message:errorMessage
               preferredStyle:(UIAlertControllerStyleAlert)];
               
               UIAlertAction *tryAgainAction = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                   [self loadMovies];
               }];
               [alert addAction:tryAgainAction];
               
               [self presentViewController:alert animated:YES completion:nil];
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               
               self.movies = dataDictionary[@"results"];
               self.filteredData = self.movies;
               [self.collectionView reloadData]; 
            }
       }];
    [task resume];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.filteredData.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MovieCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieCollectionCell" forIndexPath:indexPath];
    
    NSDictionary *movie = self.filteredData[indexPath.item];
    
    NSString *baseURLStringLarge = @"https://image.tmdb.org/t/p/w500";
    NSString *baseURLStringSmall = @"https://image.tmdb.org/t/p/w200";
    NSString *posterURLString = movie[@"poster_path"];
    NSString *fullPosterURLStringLarge = [baseURLStringLarge stringByAppendingString:posterURLString];
    NSString *fullPosterURLStringSmall = [baseURLStringSmall stringByAppendingString:posterURLString];
    
    NSURL *posterURLSmall = [NSURL URLWithString:fullPosterURLStringSmall];
    NSURL *posterURLLarge = [NSURL URLWithString:fullPosterURLStringLarge];
    cell.posterView.image = nil;
    NSURLRequest *requestSmall = [NSURLRequest requestWithURL:posterURLSmall];
    NSURLRequest *requestLarge = [NSURLRequest requestWithURL:posterURLLarge];

    __weak MovieCollectionCell *weakCell = cell;
    
    [cell.posterView setImageWithURLRequest:requestSmall placeholderImage:[UIImage imageNamed:@"loading_picture_icon"]
                                    success:^(NSURLRequest *imageRequest, NSHTTPURLResponse *response, UIImage *smallImage) {
        [UIView transitionWithView:weakCell duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            weakCell.posterView.image = smallImage;
            //NSLog(@"Loaded small image"); // FIXME: fade transition doesn't appear to be working for CollectionsView
        } completion:^(BOOL finished) {
            [cell.posterView setImageWithURLRequest:requestLarge placeholderImage:smallImage
                                               success:^(NSURLRequest *imageRequest, NSHTTPURLResponse *response, UIImage *largeImage) {
                weakCell.posterView.image = largeImage;
                //NSLog(@"Loaded large image");
            } failure:nil];
        }];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        [cell.posterView setImageWithURLRequest:requestLarge placeholderImage:[UIImage imageNamed:@"loading_picture_icon"]
                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *largeImage) {
            [UIView transitionWithView:weakCell duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                weakCell.posterView.image = largeImage;
            } completion:nil];
        } failure:nil];
    }];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (searchText.length != 0) {
        
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSDictionary *evaluatedObject, NSDictionary *bindings) {
            return [evaluatedObject[@"title"] containsString:searchText];
        }];
        self.filteredData = [self.movies filteredArrayUsingPredicate:predicate];
    }
    else {
        self.filteredData = self.movies;
    }
    [self.collectionView reloadData];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = NO;
    self.searchBar.text = @"";
    [self.searchBar resignFirstResponder];
    
    self.filteredData = self.movies;
    [self.collectionView reloadData];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UICollectionViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:tappedCell];
    NSDictionary *movie = self.filteredData[indexPath.row];
    
    DetailsViewController *detailsViewController = [segue destinationViewController];
    detailsViewController.movie = movie;
    NSLog(@"Tapping on a movie!");
}

@end
