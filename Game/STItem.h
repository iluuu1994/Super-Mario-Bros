//
//  STItem.h
//  Game
//
//  Created by Ilija Tovilo on 5/7/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STGameObject.h"

@class STPlayer;

/**
 * An item is a game object, that the player can collect.
 * They have some kind of an effect on the player that collects them.
 */
@interface STItem : STGameObject
{}

/**
 * This method is invoked to award the player.
 * This must be overridden in subclasses.
 * @param player - The player that should be awarded.
 */
- (void)awardPlayer:(STPlayer *)player;

@end
