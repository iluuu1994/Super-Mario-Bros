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
    if (self = [super initWithFile:@"block.png"]) {
        
    }
    return self;
}

- (STGameObjectBodyType)bodyType {
    return STGameObjectBodyTypeStatic;
}

- (void)collisionWithGameObject:(STGameObject *)gameObject
                           edge:(STRectEdge)edge {
    if (edge == STRectEdgeMinY && [[gameObject class] isSubclassOfClass:[STPlayer class]]) {
        [self setDead:YES];
    }
}

@end
