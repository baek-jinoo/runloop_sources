//
//  FTPBoardCollectionViewDataSource.h
//  FindThePrize
//
//  Created by Jin on 8/8/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTPArena.h"

@interface FTPBoardCollectionViewDataSource : NSObject <UICollectionViewDataSource>

- (instancetype)initWithArena:(FTPArena *)arena NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
@end
