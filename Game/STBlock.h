//
//  STBlock.h
//  Game
//
//  Created by Ilija Tovilo on 2/5/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STGameObject.h"
#import "STSoundManager.h"


#pragma mark -
#pragma mark Enums

#ifndef STBlockTypeEnum
#define STBlockTypeEnum

/**
 * Defines different block types.
 */
typedef enum {
    /**
     * This block type is used for the ground.
     * It is not destroyable.
     */
    STBlockTypeGround,
    
    /**
     * This block type is destroyable.
     */
    STBlockTypeDestroyable,
    
    /**
     * This block type is an alternative.
     * It is not destroyable.
     */
    STBlockTypeAlternate
} STBlockType;

#endif



#pragma mark -
#pragma mark STBlock Implementation

@class STPlayer;

/**
 * Represents a block.
 * A block is a static game object.
 * It can be used as ground.
 * It can also be destroyed by other game objects.
 * The player can destroy it by hitting it from the bottom edge.
 */
@interface STBlock : STGameObject
{}



#pragma mark -
#pragma mark Properties

/**
 * Defines if the block should be destoryable of not.
 */
@property (nonatomic) BOOL isDestroyable;

/**
 * Defines the type of the block.
 */
@property (nonatomic) STBlockType blockType;




#pragma mark -
#pragma mark Methods

/**
 * Awards the player.
 * This occurs when the player breaks the block.
 */
- (void)awardPlayer:(STPlayer *)player;

@end
