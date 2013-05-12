//
//  STBlock.h
//  Game
//
//  Created by Ilija Tovilo on 2/5/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STGameObject.h"
#import "STSoundManager.h"

#ifndef STBlockTypeEnum
#define STBlockTypeEnum

typedef enum {
    STBlockTypeGround,
    STBlockTypeDestroyable,
    STBlockTypeAlternate
} STBlockType;

#endif

@class STPlayer;
@interface STBlock : STGameObject
{}

@property (nonatomic) BOOL isDestroyable;
@property (nonatomic) STBlockType blockType;

- (void)awardPlayer:(STPlayer *)player;

@end
