//
//  BoardCollectionViewCell.h
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoardCellType.h"

@interface BoardCollectionViewCell : UICollectionViewCell

- (void)setBoardType:(BoardCellType)boardCellType;

@end
