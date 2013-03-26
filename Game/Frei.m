//
//  Man.m
//  Game
//
//  Created by Ilija Tovilo on 2/3/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "Frei.h"

@implementation Frei
{}

#pragma mark -
#pragma mark Initialise
- (id)init
{
    if (self = [super initWithPlistFile:@"Frei.plist"]) {
        //NSLog(@"%@", self.animations[@"default"]);
        
        [self runAction:
            [CCRepeatForever actionWithAction:
                [CCAnimate actionWithAnimation:
                    self.animations[@"default"]]]];
    }
    return self;
}

@end
