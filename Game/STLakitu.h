//
//  STLakitu.h
//  Game
//
//  Created by Ilija Tovilo on 5/9/13.
//  Copyright (c) 2013 by Lukas Seglias & Ilija Tovilo. All rights reserved.
//

#import "STNPC.h"


#pragma mark -
#pragma mark Protocols

/**
 * The Lakitus delegate.
 * This will typically be a level layer.
 *
 */
@protocol STLakituDelegate <STGameObjectDelegate>

/**
 * The level layer must know where the player is.
 * The delegate must provide this information
 */
- (CGPoint)positionOfPlayer;
@end




#pragma mark -
#pragma mark STNPC Interface

/**
 * Lakitu is an enemie of the player.
 *
 * It flies in a clowd, and follows the player.
 * It can be defeated by the user jumping on it's head.
 *
 * From time to time, Lakitu throws Spiny enemies from its cloud.
 */
@interface STLakitu : STNPC

/**
 * The Lakitus delegate.
 */
@property (unsafe_unretained) id<STLakituDelegate> delegate;

@end
