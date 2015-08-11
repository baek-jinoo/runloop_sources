//
//  FTPBoardCollectionViewCell.m
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "FTPBoardCollectionViewCell.h"

@interface FTPBoardCollectionViewCell ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation FTPBoardCollectionViewCell

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

- (void)setBoardType:(FTPBoardCellType)boardCellType;
{
    switch (boardCellType) {
        case FTPBoardCellTypeBackground:
            self.imageView.image = [UIImage imageNamed:@"background_tile"];
            break;
        case FTPBoardCellTypePrize:
            self.imageView.image = [UIImage imageNamed:@"money_tile"];
            break;
        case FTPBoardCellTypeRobot1:
            self.imageView.image = [UIImage imageNamed:@"robot1_tile"];
            break;
        case FTPBoardCellTypeRobot1Owned:
            self.imageView.image = [UIImage imageNamed:@"robot1_owned_tile"];
            break;
        case FTPBoardCellTypeRobot2:
            self.imageView.image = [UIImage imageNamed:@"robot2_tile"];
            break;
        case FTPBoardCellTypeRobot2Owned:
            self.imageView.image = [UIImage imageNamed:@"robot2_owned_tile"];
        default:
            break;
    }
}

@end
