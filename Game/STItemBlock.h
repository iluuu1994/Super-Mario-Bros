//
//  STItemBlock.h
//  Game
//
//  Created by Ilija Tovilo on 5/11/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STBlock.h"

/**
 * An item block can hold multiple items.
 * The items get revealed if the player hits its minY edge.
 *
 * The item block either holds:
 * - A Mushroom
 * - A Flower
 * - A Star
 * - 5 Coins
 */
@interface STItemBlock : STBlock

/**
 * The array of items that the item block holds.
 */
@property (readonly, nonatomic) NSMutableArray *items;

@end
