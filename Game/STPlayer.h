//
//  STPlayer.h
//  Game
//
//  Created by Ilija Tovilo on 5/2/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STCreature.h"


#pragma mark -
#pragma mark Enums

#ifndef STPlayerStateEnum
#define STPlayerStateEnum

/**
 * The player state determines the state that the player has
 */
typedef enum {
    /** 
     * The player is small
     * If he is hurt, he immediately dies
     */
    STPlayerStateSmall,
    
    /**
     * The player is large
     * If he is hurt, his state changes to small
     */
    STPlayerStateLarge,
    
    /**
     * The player is large
     * He has the ability to spit fire
     * If he is hurt, his state changes to small
     */
    STPlayerStateFire
} STPlayerState;

#endif


#pragma mark -
#pragma mark Protocols

/**
 * The protocol for the game players delegate
 * The players delegate will typically be a level layer
 */
@class STPlayer;
@protocol STPlayerDelegate <STGameObjectDelegate>

/**
 * The player moved to a new point
 * The leve layer needs this notification to adjust the camera position
 * @param player - The player that moved
 * @param point - The new position of the player
 */
- (void)player:(STPlayer *)player didMoveToPoint:(CGPoint)point;

/**
 * The player should move to a new point
 * The level layer needs this notification to prevent mario from walking out of the bounds of the camera
 * @param player - The player that should move
 * @param point - The new position, to which he should move to
 * @return if the player should move
 */
- (BOOL)player:(STPlayer *)player shouldMoveToPoint:(CGPoint)point;

/**
 * This is invoked if the player died
 * The level layer needs this notification to display the game-over layer
 * @param player - The player that died
 */
- (void)playerDied:(STPlayer *)player;

/**
 * The player, who was invincible because of a star item, did stop playing the invincible effect
 * The level layer needs this notification to resume playing the background music
 * @param player - The player, who stopped playing the invincible song
 */
- (void)playerStopsPlayingInvincibleSong:(STPlayer *)player;
@end



#pragma mark -
#pragma mark STPlayer Class

/**
 * STPlayer is the creature, that the user can control
 * It can either be Mario, or Luigi
 */
@interface STPlayer : STCreature
{}


#pragma mark -
#pragma mark Properties

/**
 * Hold the score that the user has obtained in the current level
 */
@property unsigned int score;

/**
 * Hold the number of coins that the user has obtained in the current level
 */
@property unsigned int coins;

/**
 * Defines if the player is invincible
 * If so, he cannot be hurt by other game-objects
 */
@property (setter = setInvincible:) BOOL isInvincible;

/**
 * Defines, it the other game objects will be killed instantly when a collision occurs
 */
@property BOOL killsInstantly;

/**
 * The state of the player
 * Can be small, large, or fire
 */
@property (nonatomic) STPlayerState playerState;

/**
 * Holds the reference to the players delegate
 * This will typically be a level layer
 */
@property (unsafe_unretained) id<STPlayerDelegate> delegate;




#pragma mark -
#pragma mark Methods

/**
 * Makes the player invincible for a specific amount of time
 * @param isInvincible - Should the user be invincible?
 * @param time - The amount of time the player should be invincible
 * @param invincibleSong - Should the invincible song be played?
 */
- (void)setInvincible:(BOOL)isInvincible forTime:(ccTime)time playingInvincibleSong:(BOOL)invincibleSong;

/**
 * Makes the user kill all game objects instantly in a collision for a specitic amount of time
 * @param killsInstantly - Should the game object kill all other game objects instantly in a collision?
 * @param time - The amount of the time for the user to kill all other game objects instantly
 */
- (void)setKillsInstantly:(BOOL)killsInstantly forTime:(ccTime)time;

/**
 * Makes the player spit a fireball
 * This will only work if the players state is `STPlayerStateFire`
 */
- (void)spitFireball;

/**
 * Makes the user jump
 */
- (void)jump;

@end
