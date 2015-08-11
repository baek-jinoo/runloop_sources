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
#import "FTPSize.h"

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

    self.boardCollectionViewDataSource = [[BoardCollectionViewDataSource alloc] initWithArena:self.gameEngine.arena];
    self.boardCollectionView.dataSource = self.boardCollectionViewDataSource;
    self.boardCollectionViewDelegateFlowLayout = [[BoardCollectionViewDelegateFlowLayout alloc] initWithGridSize:[GameEngine arenaSize].width];
    self.boardCollectionView.delegate = self.boardCollectionViewDelegateFlowLayout;

    self.firstRobotColorIndicator.image = [UIImage imageNamed:@"robot1_dot"];
    self.secondRobotColorIndicator.image = [UIImage imageNamed:@"robot2_dot"];
}

- (void)initializeGame;
{
    Arena *arena = [[Arena alloc] initWithArenaSize:[GameEngine arenaSize]];
    self.gameEngine = [[GameEngine alloc] initWithArena:arena];
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
