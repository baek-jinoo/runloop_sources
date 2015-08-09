//
//  Arena.h
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTPSize.h"

@interface Arena : NSObject

@property (strong, nonatomic, readonly) NSArray *cells;

- (void)setArenaSize:(FTPSize *)size;

@end
