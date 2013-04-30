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
    
    // Pause Button
    CCControlButton *pauseButton = [CCControlButton buttonWithTitle:@"II" fontName:@"Helvetica" fontSize:30];
    [pauseButton setAdjustBackgroundImage:NO];
    [pauseButton addTarget:self action:@selector(b:) forControlEvents:CCControlEventTouchUpInside];
    pauseButton.position = ccp(kScreenPadding + pauseButton.contentSize.width,
                               [[CCDirector sharedDirector] winSize].height - pauseButton.contentSize.height / 2 - kScreenPadding);
    [self addChild:pauseButton];
    
    // A Button
    CCControlButton *aButton = [CCControlButton buttonWithTitle:@"A" fontName:@"Helvetica" fontSize:30];
    [aButton setAdjustBackgroundImage:NO];
    [aButton addTarget:self action:@selector(a:) forControlEvents:CCControlEventTouchUpInside];
    aButton.position = ccp([[CCDirector sharedDirector] winSize].width - aButton.contentSize.width - kScreenPadding, aButton.contentSize.height / 2 + kScreenPadding);
    [self addChild:aButton];
    
    // B Button
    CCControlButton *bButton = [CCControlButton buttonWithTitle:@"A" fontName:@"Helvetica" fontSize:30];
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
