//
//  MovieCell.h
//  Flix
//
//  Created by meganyu on 6/24/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;


@end

NS_ASSUME_NONNULL_END
