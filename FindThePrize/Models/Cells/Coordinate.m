//
//  Coordinate.m
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "Coordinate.h"

@implementation Coordinate

- (instancetype)initWithX:(NSInteger)x Y:(NSInteger)y;
{
    self = [super init];
    if (self) {
        _x = x;
        _y = y;
    }
    return self;
}

+ (instancetype)withX:(NSInteger)x Y:(NSInteger)y;
{
    return [[self alloc] initWithX:x Y:y];

}

@end
