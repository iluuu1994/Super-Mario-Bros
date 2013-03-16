//
//  STBlock.m
//  Game
//
//  Created by Ilija Tovilo on 2/5/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STBlock.h"

@implementation STBlock

#pragma mark -
#pragma mark Initialise
- (id)init
{
    if (self = [super initWithFile:@"block.png"]) {
        
    }
    return self;
}

#pragma mark -
#pragma mark Update Demo

// TODO: Remove
- (BOOL)needsUpdate {
    return YES;
}

- (void)update:(ccTime)delta {
    self.position = ccp(self.position.x + (60 * delta), self.position.y);
}

@end
