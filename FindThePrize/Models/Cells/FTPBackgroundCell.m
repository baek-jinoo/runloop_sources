//
//  FTPBackgroundCell.m
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "FTPBackgroundCell.h"


@interface FTPBackgroundCell ()

@property (strong, nonatomic) Coordinate *coordinate;

@end

@implementation FTPBackgroundCell

- (instancetype)initWithX:(NSUInteger)x Y:(NSUInteger)y;
{
    self = [super init];
    if (self) {
        _coordinate = [[Coordinate alloc] initWithX:x Y:y];
    }
    return self;
}

- (BoardCellType)boardCellType;
{
    return BoardCellTypeBackground;
}

@end
