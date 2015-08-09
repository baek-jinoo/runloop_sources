//
//  Cell.h
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coordinate.h"
#import "BoardCellType.h"

@protocol Cell <NSObject>

- (Coordinate *)coordinate;
- (BoardCellType)boardCellType;

@end
