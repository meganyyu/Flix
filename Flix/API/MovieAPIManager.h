//
//  MovieAPIManager.h
//  Flix
//
//  Created by meganyu on 7/1/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieAPIManager : NSObject

+ (instancetype)shared;

- (void)fetchNowPlaying:(void(^)(NSArray *movies, NSError *error))completion;

- (void)fetchPopular:(void(^)(NSArray *movies, NSError *error))completion;

- (void)fetchTrailerURL:(void(^)(NSURL *trailerURL, NSError *error))completion forMovie:(NSString *)movieID;

@end

NS_ASSUME_NONNULL_END
