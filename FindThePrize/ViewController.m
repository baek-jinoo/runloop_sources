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
#import "GameEngine.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *boardCollectionView;
@property (strong, nonatomic) BoardCollectionViewDataSource *boardCollectionViewDataSource;
@property (strong, nonatomic) BoardCollectionViewDelegateFlowLayout *boardCollectionViewDelegateFlowLayout;

@property (weak, nonatomic) IBOutlet UIImageView *firstRobotColorIndicator;
@property (weak, nonatomic) IBOutlet UIImageView *secondRobotColorIndicator;
@property (weak, nonatomic) IBOutlet UILabel *firstRobotScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondRobotScoreLabel;

@property (strong, nonatomic) GameEngine *gameEngine;

@end

@implementation ViewController

- (IBAction)restartGame:(id)sender {
}

- (void)viewDidLoad;
{
    [super viewDidLoad];

    [self initializeGame];

    self.boardCollectionViewDataSource = [[BoardCollectionViewDataSource alloc] init];
    self.boardCollectionView.dataSource = self.boardCollectionViewDataSource;
    FTPSize *arenaSize = [self.gameEngine arenaSize];
    self.boardCollectionViewDelegateFlowLayout = [[BoardCollectionViewDelegateFlowLayout alloc] initWithGridSize:arenaSize.width];
    self.boardCollectionView.delegate = self.boardCollectionViewDelegateFlowLayout;

    self.firstRobotColorIndicator.image = [UIImage imageNamed:@"robot1_dot"];
    self.secondRobotColorIndicator.image = [UIImage imageNamed:@"robot2_dot"];
}

- (void)initializeGame;
{
    Arena *arena = [[Arena alloc] init];
    self.gameEngine = [[GameEngine alloc] initWithArena:arena];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator;
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self.boardCollectionView reloadData];
}

@end
