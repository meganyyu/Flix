//
//  MovieCollectionCell.m
//  Flix
//
//  Created by meganyu on 6/24/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "MovieCollectionCell.h"

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

@end
