//
//  STGumba.h
//  Game
//
//  Created by Ilija Tovilo on 5/7/13.
//  Copyright (c) 2013 by Lukas Seglias & Ilija Tovilo. All rights reserved.
//

#import "STNPC.h"
#import "STSoundManager.h"

/**
 * Represents the Gumba enemie.
 * Gumbas are simple to defeat.
 * The player must jump on its head.
 * If a collision occurs other than with the top edge, the player gets hurt.
 *
 * Gumbas walk in one direction until they read a wall.
 * If they do, they turn around.
 */
@interface STGumba : STNPC
{}

@end
