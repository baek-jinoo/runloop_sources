//
//  ViewController.m
//  FindThePrize
//
//  Created by Jin on 8/8/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "ViewController.h"
#import "BoardCollectionViewDataSource.h"
#import "BoardCollectionViewDelegateFlowLayout.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *boardCollectionView;
@property (strong, nonatomic) BoardCollectionViewDataSource *boardCollectionViewDataSource;
@property (strong, nonatomic) BoardCollectionViewDelegateFlowLayout *boardCollectionViewDelegateFlowLayout;

@property (weak, nonatomic) IBOutlet UIView *firstRobotColorIndicator;
@property (weak, nonatomic) IBOutlet UIView *secondRobotColorIndicator;
@property (weak, nonatomic) IBOutlet UILabel *firstRobotScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondRobotScoreLabel;

@end

@implementation ViewController

- (IBAction)restartGame:(id)sender {
}

- (void)viewDidLoad;
{
    [super viewDidLoad];

    self.boardCollectionViewDataSource = [[BoardCollectionViewDataSource alloc] init];
    self.boardCollectionViewDelegateFlowLayout = [[BoardCollectionViewDelegateFlowLayout alloc] init];

    self.boardCollectionView.dataSource = self.boardCollectionViewDataSource;
    self.boardCollectionView.delegate = self.boardCollectionViewDelegateFlowLayout;

    CALayer *boardCollectionViewLayer = self.boardCollectionView.layer;
    boardCollectionViewLayer.cornerRadius = 3.0f;
    boardCollectionViewLayer.borderColor = [UIColor brownColor].CGColor;
    boardCollectionViewLayer.borderWidth = 1.0f;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator;
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self.boardCollectionView reloadData];
}

@end
