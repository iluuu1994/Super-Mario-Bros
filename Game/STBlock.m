//
//  STBlock.m
//  Game
//
//  Created by Ilija Tovilo on 2/5/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STBlock.h"
#import "STPlayer.h"

@implementation STBlock

#pragma mark -
#pragma mark Initialise
- (id)init
{
    if (self = [super init]) {
        [self displayFrameWithName:@"block"];
    }
    return self;
}

- (void)setAppearanceType:(STAppearanceType)appearanceType {
    [super setAppearanceType:appearanceType];
    [self displayFrameWithName:@"block"];
}

- (void)setBlockType:(STBlockType)blockType {
    _blockType = blockType;
    [self displayFrameWithName:@"block"];
}

- (STGameObjectBodyType)bodyType {
    return STGameObjectBodyTypeStatic;
}

- (NSString *)appearanceNameForString:(NSString *)name {
    NSString *prefix = @"";
    
    if (self.blockType == STBlockTypeDestroyable) {
        prefix = @"destroyable-";
    } else if (self.blockType == STBlockTypeAlternate) {
        prefix = @"alternate-";
    }
    
    return [super appearanceNameForString:[prefix stringByAppendingString:name]];
}

- (void)collisionWithGameObject:(STGameObject *)gameObject
                           edge:(STRectEdge)edge {
    if (self.isDestroyable && edge == STRectEdgeMinY && [[gameObject class] isSubclassOfClass:[STPlayer class]]) {
        // Play a sound
        [[STSoundManager sharedInstance] playEffect:kSoundBreakBlock];
        [self setDead:YES];
    }
}

@end
