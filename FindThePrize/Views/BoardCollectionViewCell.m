//
//  BoardCollectionViewCell.m
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "BoardCollectionViewCell.h"

@implementation BoardCollectionViewCell

- (void)willMoveToSuperview:(UIView *)newSuperview;
{
    [super willMoveToSuperview:newSuperview];
}

- (void)updateCircleRadius;
{
    self.layer.cornerRadius = self.bounds.size.width / 2.0;
}

@end
