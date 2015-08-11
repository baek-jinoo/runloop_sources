//
//  Cell.h
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTPBoardCellType.h"
@class FTPCoordinate;
@class FTPRobot;

@protocol Cell <NSObject>

- (FTPCoordinate *)coordinate;
- (void)clearCell;

@property (assign, nonatomic, readonly) FTPBoardCellType boardCellType;
@property (assign, nonatomic, readonly) BOOL hasPrize;

@end
