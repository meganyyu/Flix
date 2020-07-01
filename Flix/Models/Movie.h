//
//  Movie.h
//  Flix
//
//  Created by meganyu on 7/1/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Movie : NSObject

// MARK: Properties
@property (nonatomic, strong) NSString *movieID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *overview;
@property (nonatomic, strong) NSURL *smallPosterUrl;
@property (nonatomic, strong) NSURL *largePosterUrl;
@property (nonatomic, strong) NSURL *backdropUrl;
@property (nonatomic, strong) id rating;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)moviesWithDictionaries:(NSArray *)dictionaries;

@end

NS_ASSUME_NONNULL_END
