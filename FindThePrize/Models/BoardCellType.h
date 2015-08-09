//
//  BoardCellType.h
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BoardCellType) {
    BoardCellTypeBackground = 1,
    BoardCellTypeRobot1Owned,
    BoardCellTypeRobot1,
    BoardCellTypeRobot2Owned,
    BoardCellTypeRobot2,
    BoardCellTypePrize,
};
