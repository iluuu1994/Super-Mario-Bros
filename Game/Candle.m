//
//  Candle.m
//  Game
//
//  Created by Lukas Seglias on 02.02.13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import "Candle.h"
#import "STAnimationConfiguration.h"

@implementation Candle

#pragma mark -
#pragma mark Initialise
- (id)init
{
    self = [super initWithDefaultSpriteFrameName:@"Candle_1.png"
                         animationConfigurations:@[
                            [STAnimationConfiguration configurationWithName:@"Burn"
                                                           frameNamePattern:@"Candle_%d.png" delay:0.1]
            ]];
    
    if (self) {
        [self runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:self.animations[@"Burn"]]]];
    }
    return self;
}

@end
