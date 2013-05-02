//
//  STPlayer.h
//  Game
//
//  Created by Ilija Tovilo on 5/2/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STCreature.h"

@interface STPlayer : STCreature
{}

@property unsigned int score;
@property unsigned int coins;
@property Byte lives;
@property (strong, nonatomic) NSMutableArray *bonusItems;

@end
