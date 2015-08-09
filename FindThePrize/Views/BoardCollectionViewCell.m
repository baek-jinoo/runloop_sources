//
//  BoardCollectionViewCell.m
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "BoardCollectionViewCell.h"

@interface BoardCollectionViewCell ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation BoardCollectionViewCell

- (void)awakeFromNib;
{
    _imageView = [[UIImageView alloc] init];
    _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_imageView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_imageView);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_imageView]|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_imageView]|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:views]];

}

- (void)setBoardType:(BoardCellType)boardCellType;
{
    switch (boardCellType) {
        case BoardCellTypeBackground:
            self.imageView.image = [UIImage imageNamed:@"background_tile"];
            break;
        case BoardCellTypePrize:
            self.imageView.image = [UIImage imageNamed:@"money_tile"];
            break;
        case BoardCellTypeRobot1:
            self.imageView.image = [UIImage imageNamed:@"robot1_tile"];
            break;
        case BoardCellTypeRobot1Owned:
            self.imageView.image = [UIImage imageNamed:@"robot1_owned_tile"];
            break;
        case BoardCellTypeRobot2:
            self.imageView.image = [UIImage imageNamed:@"robot2_tile"];
            break;
        case BoardCellTypeRobot2Owned:
            self.imageView.image = [UIImage imageNamed:@"robot2_owned_tile"];
        default:
            break;
    }
}

@end
