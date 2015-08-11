//
//  FTPViewController.m
//  FindThePrize
//
//  Created by Jin on 8/8/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "FTPViewController.h"
#import "FTPBoardCollectionViewDataSource.h"
#import "FTPBoardCollectionViewDelegateFlowLayout.h"
#import "FTPGameEngine.h"
#import "FTPSize.h"

@interface FTPViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *boardCollectionView;
@property (strong, nonatomic) FTPBoardCollectionViewDataSource *boardCollectionViewDataSource;
@property (strong, nonatomic) FTPBoardCollectionViewDelegateFlowLayout *boardCollectionViewDelegateFlowLayout;

@property (weak, nonatomic) IBOutlet UIImageView *firstRobotColorIndicator;
@property (weak, nonatomic) IBOutlet UIImageView *secondRobotColorIndicator;
@property (weak, nonatomic) IBOutlet UILabel *firstRobotScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondRobotScoreLabel;

@property (strong, nonatomic) FTPGameEngine *gameEngine;

@end

@implementation FTPViewController
- (IBAction)startGame:(id)sender
{
    [self.gameEngine startGame];
    [self.boardCollectionView reloadData];
}

- (void)updateScreen;
{
    [self.boardCollectionView reloadData];
}

- (void)viewDidLoad;
{
    [super viewDidLoad];

    [self initializeGame];

    self.boardCollectionViewDataSource = [[FTPBoardCollectionViewDataSource alloc] initWithArena:self.gameEngine.arena];
    self.boardCollectionView.dataSource = self.boardCollectionViewDataSource;
    self.boardCollectionViewDelegateFlowLayout = [[FTPBoardCollectionViewDelegateFlowLayout alloc] initWithGridSize:[FTPGameEngine arenaSize].width];
    self.boardCollectionView.delegate = self.boardCollectionViewDelegateFlowLayout;

    self.firstRobotColorIndicator.image = [UIImage imageNamed:@"robot1_dot"];
    self.secondRobotColorIndicator.image = [UIImage imageNamed:@"robot2_dot"];
}

- (void)initializeGame;
{
    FTPArena *arena = [[FTPArena alloc] initWithArenaSize:[FTPGameEngine arenaSize]];
    self.gameEngine = [[FTPGameEngine alloc] initWithArena:arena];
    self.gameEngine.gameUIInteractionDelegate = self;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator;
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self.boardCollectionView reloadData];
}

- (void)updateScores;
{
    NSArray *scores = [self.gameEngine scores];
    self.firstRobotScoreLabel.text = [scores objectAtIndex:0];
    self.secondRobotScoreLabel.text = [scores objectAtIndex:1];
}

@end
