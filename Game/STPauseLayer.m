//
//  STPauseLayer.m
//  Game
//
//  Created by Lukas Seglias on 30.04.13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STPauseLayer.h"
#import "CCDirector+Transitions.h"
#import "CCControlExtension.h"
#import "STLayerConstants.h"

@implementation STPauseLayer
{}

#pragma mark -
#pragma mark Initialise
-(id)initWithWorldID:(unsigned short)worldID
             levelID:(unsigned short)levelID {
    self = [super init];
    if (self) {
        [self setUpWithWorldID:worldID levelID:levelID];
    }
    return self;
}

+(id)layerWithWorldID:(unsigned short)worldID
              levelID:(unsigned short)levelID {
    return [[self alloc] initWithWorldID:worldID levelID:levelID];
}

- (void)setUpWithWorldID:(unsigned short)worldID
                 levelID:(unsigned short)levelID {
    self.worldID = worldID;
    self.levelID = levelID;
    
    // Play Button
    CCControlButton *continueButton = [CCControlButton buttonWithTitle:@"Play" fontName:@"Helvetica" fontSize:30];
    [continueButton setAdjustBackgroundImage:NO];
    [continueButton addTarget:self action:@selector(play:) forControlEvents:CCControlEventTouchUpInside];
    continueButton.position = ccp(kScreenPadding + continueButton.contentSize.width / 2,
                               [[CCDirector sharedDirector] winSize].height - continueButton.contentSize.height / 2 - kScreenPadding);
    [self addChild:continueButton];
    
    // Retry Button
    CCControlButton *retryButton = [CCControlButton buttonWithTitle:@"Retry" fontName:@"Helvetica" fontSize:30];
    [retryButton setAdjustBackgroundImage:NO];
    [retryButton addTarget:self action:@selector(retryLevel:) forControlEvents:CCControlEventTouchUpInside];
    retryButton.position = ccp(kScreenPadding + retryButton.contentSize.width / 2,
                                kScreenPadding + retryButton.contentSize.height / 2);
    [self addChild:retryButton];
    
    // Level Overview Button
    CCControlButton *levelsButton = [CCControlButton buttonWithTitle:@"Levels" fontName:@"Helvetica" fontSize:30];
    [levelsButton setAdjustBackgroundImage:NO];
    [levelsButton addTarget:self action:@selector(levelOverview:) forControlEvents:CCControlEventTouchUpInside];
    levelsButton.position = ccp(kScreenPadding + levelsButton.contentSize.width / 2,
                                kScreenPadding + levelsButton.contentSize.height / 2 + retryButton.contentSize.height + kButtonPadding);
    [self addChild:levelsButton];
}

#pragma mark -
#pragma mark Retry Level
- (IBAction)play:(id)sender {
    NSLog(@"TODO: continue game");
}

#pragma mark -
#pragma mark Retry Level
- (IBAction)retryLevel:(id)sender {
    STScene *scene = [STLevelLayer sceneWithWorldID:self.worldID levelID:self.levelID];
    [[CCDirector sharedDirector] replaceScene: scene
                          withTransitionClass:[CCTransitionFade class]
                                     duration:0.5];
}

#pragma mark -
#pragma mark Level Overview
- (IBAction)levelOverview:(id)sender {
    [[CCDirector sharedDirector] replaceScene: [[STChooseLevelLayer layerWithWorldID:self.worldID] scene]
                          withTransitionClass:[CCTransitionFade class]
                                     duration:0.5];
}

@end
