//
//  STControlsLayer.m
//  Game
//
//  Created by Lukas Seglias on 30.04.13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STControlsLayer.h"
#import "CCControlExtension.h"
#import "STLayerConstants.h"

@implementation STControlsLayer
{}

#pragma mark -
#pragma mark Initialise
- (void)setUp {
    [super setUp];
    
    // Joystick
//    SneakyJoystickSkinnedBase *joystick = [SneakyJoystickSkinnedBase node];
//    [joystick setIsDPad:YES];
//    [joystick setNumberOfDirections:4];
//    joystick.position = ccp(kScreenPadding + joystick.contentSize.width / 2 ,
//                        kScreenPadding + joystick.contentSize.height / 2);
//    [self addChild:joystick];
    
    SneakyJoystickSkinnedBase *leftJoy = [[SneakyJoystickSkinnedBase alloc] init];
    leftJoy.position = ccp(64,64);
    leftJoy.backgroundSprite = [ColoredCircleSprite circleWithColor:ccc4(255, 0, 0, 128) radius:64];
    leftJoy.thumbSprite = [ColoredCircleSprite circleWithColor:ccc4(0, 0, 255, 200) radius:32];
    leftJoy.joystick = [[SneakyJoystick alloc] initWithRect:CGRectMake(0,0,128,128)];
    [self addChild:leftJoy];
    
    // Pause Button
    CCControlButton *pauseButton = [CCControlButton buttonWithTitle:@"II" fontName:@"Helvetica" fontSize:30];
    [pauseButton setAdjustBackgroundImage:NO];
    [pauseButton addTarget:self action:@selector(b:) forControlEvents:CCControlEventTouchUpInside];
    pauseButton.position = ccp(kScreenPadding + pauseButton.contentSize.width / 2,
                               [[CCDirector sharedDirector] winSize].height - pauseButton.contentSize.height / 2 - kScreenPadding);
    [self addChild:pauseButton];
    
    // A Button
    CCControlButton *aButton = [CCControlButton buttonWithTitle:@"A" fontName:@"Helvetica" fontSize:30];
    [aButton setAdjustBackgroundImage:NO];
    [aButton addTarget:self action:@selector(a:) forControlEvents:CCControlEventTouchUpInside];
    aButton.position = ccp([[CCDirector sharedDirector] winSize].width - aButton.contentSize.width - kScreenPadding, aButton.contentSize.height / 2 + kScreenPadding);
    [self addChild:aButton];
    
    // B Button
    CCControlButton *bButton = [CCControlButton buttonWithTitle:@"B" fontName:@"Helvetica" fontSize:30];
    [bButton setAdjustBackgroundImage:NO];
    [bButton addTarget:self action:@selector(b:) forControlEvents:CCControlEventTouchUpInside];
    bButton.position = ccp([[CCDirector sharedDirector] winSize].width - bButton.contentSize.width - aButton.contentSize.width - 2 * kScreenPadding, bButton.contentSize.height / 2 + kScreenPadding);
    [self addChild:bButton];
}

#pragma mark -
#pragma mark Buttons
- (IBAction)a:(id)sender {
    NSLog(@"Pressed A Button.");
}

- (IBAction)b:(id)sender {
    NSLog(@"Pressed B Button.");
}

@end
