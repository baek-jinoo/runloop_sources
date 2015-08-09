//
//  Arena.m
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "Arena.h"
#import "BoardCellType.h"

@interface Arena ()

@property (strong, nonatomic) NSMutableArray *internalCells;

@end

@implementation Arena

- (instancetype)init
{
    self = [super init];
    if (self) {
        _internalCells = [NSMutableArray array];
    }
    return self;
}

- (void)setArenaSize:(FTPSize *)size;
{
    for (int i = 0; i < size.width * size.height; i++) {
        [self.internalCells addObject:@(BoardCellTypeBackground)];
    }
}

@end
