//
//  FTPPrizeCell.m
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "FTPPrizeCell.h"

@interface FTPPrizeCell ()

@property (strong, nonatomic) Coordinate *coordinate;

@end

@implementation FTPPrizeCell

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
    return BoardCellTypePrize;
}

@end
