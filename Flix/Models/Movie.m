//
//  Movie.m
//  Flix
//
//  Created by meganyu on 7/1/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];

    self.movieID = dictionary[@"id"];
    self.title = dictionary[@"title"];

    // Set the other properties from the dictionary
    self.overview = dictionary[@"overview"];
    
    NSString *const baseURLString = @"https://image.tmdb.org/t/p";
    NSString *const posterURLString = dictionary[@"poster_path"];
    NSString *const fullPosterURLStringSmall = [NSString stringWithFormat:@"%@/w200%@", baseURLString, posterURLString];
    NSString *const fullPosterURLStringLarge = [NSString stringWithFormat:@"%@/w500%@", baseURLString, posterURLString];
    self.smallPosterUrl = [NSURL URLWithString:fullPosterURLStringSmall];
    self.largePosterUrl = [NSURL URLWithString:fullPosterURLStringLarge];
    
    NSString *backdropURLString = dictionary[@"backdrop_path"];
    NSString *fullBackdropURLString = [NSString stringWithFormat:@"%@/w500%@", baseURLString, backdropURLString];
    self.backdropUrl = [NSURL URLWithString:fullBackdropURLString];
    
    self.rating = dictionary[@"vote_average"];

    return self;
}

+ (NSArray *)moviesWithDictionaries:(NSArray *)dictionaries {
    NSMutableArray *movies = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Movie *movie = [[Movie alloc] initWithDictionary:dictionary];
        [movies addObject:movie];
    }
    return movies;
}

@end
