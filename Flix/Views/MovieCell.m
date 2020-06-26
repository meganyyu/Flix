//
//  MovieCell.m
//  Flix
//
//  Created by meganyu on 6/24/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "MovieCell.h"

@implementation MovieCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.posterView.layer.shadowColor = UIColor.darkGrayColor.CGColor;
    self.posterView.layer.shadowOffset = CGSizeMake(5.0, 5.0);
    self.posterView.layer.shadowRadius = 25.0;
    self.posterView.layer.shadowOpacity = 0.9;
    self.posterView.layer.cornerRadius = 25.0;
    self.posterView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
