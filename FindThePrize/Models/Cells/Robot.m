//
//  Robot.m
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "Robot.h"

@implementation Robot

@synthesize coordinate = _coordinate;

- (instancetype)initWithX:(NSUInteger)x Y:(NSUInteger)y;
{
    self = [super init];
    if (self) {
        _coordinate = [[Coordinate alloc] initWithX:x Y:y];
    }
    return self;
}

@end
