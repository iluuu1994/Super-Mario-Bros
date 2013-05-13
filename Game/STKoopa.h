//
//  STKoopa.h
//  Game
//
//  Created by Ilija Tovilo on 5/7/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STNPC.h"
#import "STSoundManager.h"

/**
 * Represents the Koopa enemie
 * If you jump on a Koopa, it will hide in its armor
 * If you jump on the armor, it will start moving fast
 * If you jump on a moving armor, it will stop
 *
 * Koopas move in one direction until they read a wall
 * If they do, they turn around
 * A Koopa in its armor can destroy destroyable blocks
 *
 * A collision with a Koopa, if not with the top edge, will hurt the player
 * If the Koopa hides in its armor, a collision will be deadly for players and NPCs
 */
@interface STKoopa : STNPC
{}

#pragma mark -
#pragma mark Properties

/**
 * Defines if the Koopa hides in his armor
 */
@property (setter = setHidden:) BOOL isHidden;

@end
