//
//  STPlayer.h
//  Game
//
//  Created by Ilija Tovilo on 5/2/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STCreature.h"

@class STPlayer;
@protocol STPlayerDelegate <NSObject>
- (void)player:(STPlayer *)player didMoveToPoint:(CGPoint)point;
- (BOOL)player:(STPlayer *)player shouldMoveToPoint:(CGPoint)point;
@end

@interface STPlayer : STCreature
{}

@property unsigned int score;
@property unsigned int coins;
@property Byte lifes;
@property (strong, nonatomic) NSMutableArray *bonusItems;

@property (unsafe_unretained) id<STPlayerDelegate> delegate;

- (void)jump;

@end
