//
//  Man.m
//  Game
//
//  Created by Ilija Tovilo on 2/3/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "Frei.h"
#import "SKAnimationConfiguration.h"

@implementation Frei

- (id)init
{
    self = [super initWithDefaultSpriteFrameName:@"Frame1"
                         animationConfigurations:@[
                                [SKAnimationConfiguration configurationWithName:@"Haija"
                                                               frameNamePattern:@"Frame%d"
                                                                          delay:1.0]
            ]];
    
    if (self) {
        [self runAction:[CCRepeatForever actionWithAction:
                         [CCAnimate actionWithAnimation:self.animations[@"Haija"]]]];
        
        
    }
    return self;
}

@end
