//
//  FTPSize.m
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "FTPSize.h"

@implementation FTPSize

- (instancetype)initWithWidth:(NSUInteger)width height:(NSUInteger)height;
{
    self = [super init];
    if (self) {
        _width = width;
        _height = height;
    }
    return self;
}

@end
