//
//  MovieCollectionCell.m
//  Flix
//
//  Created by meganyu on 6/24/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "MovieCollectionCell.h"
#import "UIImageView+AFNetworking.h"

@implementation MovieCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.posterView.layer.shadowColor = UIColor.darkGrayColor.CGColor;
    self.posterView.layer.shadowOffset = CGSizeMake(5.0, 5.0);
    self.posterView.layer.shadowRadius = 25.0;
    self.posterView.layer.shadowOpacity = 0.9;
    self.posterView.layer.cornerRadius = 25.0;
    self.posterView.clipsToBounds = YES;
}

- (void)setMovie:(Movie *)movie {
    _movie = movie;
    
    NSURL *posterURLSmall = movie.smallPosterUrl;
    NSURL *posterURLLarge = movie.largePosterUrl;
    
    self.posterView.image = nil;
    NSURLRequest *requestSmall = [NSURLRequest requestWithURL:posterURLSmall];
    NSURLRequest *requestLarge = [NSURLRequest requestWithURL:posterURLLarge];

    __weak MovieCollectionCell *weakSelf = self;
    
    [self.posterView setImageWithURLRequest:requestSmall placeholderImage:[UIImage imageNamed:@"loading_picture_icon"]
                                    success:^(NSURLRequest *imageRequest, NSHTTPURLResponse *response, UIImage *smallImage) {
        [UIView transitionWithView:weakSelf duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            weakSelf.posterView.image = smallImage;
            //NSLog(@"Loaded small image");
        } completion:^(BOOL finished) {
            [self.posterView setImageWithURLRequest:requestLarge placeholderImage:smallImage
                                               success:^(NSURLRequest *imageRequest, NSHTTPURLResponse *response, UIImage *largeImage) {
                weakSelf.posterView.image = largeImage;
                //NSLog(@"Loaded large image");
            } failure:nil];
        }];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        [self.posterView setImageWithURLRequest:requestLarge placeholderImage:[UIImage imageNamed:@"loading_picture_icon"]
                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *largeImage) {
            [UIView transitionWithView:weakSelf duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                weakSelf.posterView.image = largeImage;
            } completion:nil];
        } failure:nil];
    }];
}

@end
