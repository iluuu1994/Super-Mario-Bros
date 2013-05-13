//
//  STControlsLayer.m
//  Game
//
//  Created by Lukas Seglias on 30.04.13.
//  Copyright (c) 2013 by Lukas Seglias & Ilija Tovilo. All rights reserved.
//

#import "STControlsLayer.h"
#import "CCControlExtension.h"
#import "SneakyJoystickSkinnedBase.h"
#import "STLayoutConstants.h"
#import "ColoredCircleSprite.h"
#import "ColoredSquareSprite.h"

@implementation STControlsLayer
{}

#pragma mark -
#pragma mark Initialise

- (id)initWithDelegate:(id <STControlsDelegate>)delegate {
    self = [super init];
    if (self) {
        [self setDelegate:delegate];
        [self setUpWithDelegate:delegate];
    }
    return self;
}

+ (id)layerWithDelegate:(id <STControlsDelegate>)delegate {
    return [[self alloc] initWithDelegate:delegate];
}

- (void)setUpWithDelegate:(id <STControlsDelegate>)delegate {
    [super setUp];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    // Joystick
    SneakyJoystickSkinnedBase *leftJoy = [[SneakyJoystickSkinnedBase alloc] init];
    leftJoy.position = ccp(kPadding + kJoystickBaseRadius, winSize.height - kJoystickBaseRadius - kPadding);
    leftJoy.backgroundSprite = [ColoredCircleSprite circleWithColor:kJoystickBaseColor radius:kJoystickBaseRadius];
    leftJoy.thumbSprite = [ColoredCircleSprite circleWithColor:kJoystickColor radius:kJoystickRadius];
    leftJoy.joystick = [[SneakyJoystick alloc] initWithRect:kJoystickRect];
    self.joystick = leftJoy.joystick;
    [self addChild:leftJoy];

    // Pause Button
    CCControlButton *pauseButton = [CCControlButton buttonWithBackgroundSprite:
                                    [CCScale9Sprite spriteWithFile:kPauseButtonImage]];
    pauseButton.adjustBackgroundImage = NO;
    pauseButton.scale = 0.8;
    [pauseButton addTarget:delegate action:@selector(pause:) forControlEvents:CCControlEventTouchUpInside];
    pauseButton.position = ccp(kPadding + pauseButton.contentSize.width / 2,
                               kPadding + pauseButton.contentSize.height / 2);
    [self addChild:pauseButton];
    
    // A Button
    CCControlButton *aButton = [CCControlButton buttonWithBackgroundSprite:[CCScale9Sprite spriteWithFile:kAButtonImage]];
    [aButton setAdjustBackgroundImage:NO];
    aButton.scale = 0.8;
    [aButton addTarget:delegate action:@selector(a:) forControlEvents:CCControlEventTouchUpInside];
    aButton.position = ccp(winSize.width - aButton.contentSize.width / 2 - kPadding,
                           winSize.height - aButton.contentSize.height / 2 - kPadding);
    [self addChild:aButton];

    // B Button
    CCControlButton *bButton = [CCControlButton buttonWithBackgroundSprite:[CCScale9Sprite spriteWithFile:kBButtonImage]];
    [bButton setAdjustBackgroundImage:NO];
    bButton.scale = 0.8;
    [bButton addTarget:delegate action:@selector(b:) forControlEvents:CCControlEventTouchUpInside];
    bButton.position = ccp(winSize.width - bButton.contentSize.width / 2 - aButton.contentSize.width - 2 * kPadding,
                           winSize.height - bButton.contentSize.height / 2 - kPadding);
    [self addChild:bButton];
}

#pragma mark -
#pragma mark Update

/**
 * Determines whether the update method of this object should be called regularly.
 * @return TRUE if this objects update method should be called. NO if not.
 */
- (BOOL)needsUpdate {
    return YES;
}

- (void)update:(ccTime)delta {
    if([self delegate]) {
        [[self delegate] joystick:self.joystick delta:delta];
    }
}

@end
