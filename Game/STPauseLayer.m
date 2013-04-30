//
//  STPauseLayer.m
//  Game
//
//  Created by Lukas Seglias on 30.04.13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STPauseLayer.h"
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
    CCControlButton *pauseButton = [CCControlButton buttonWithTitle:@"II" fontName:@"Helvetica" fontSize:30];
    [pauseButton setAdjustBackgroundImage:NO];
    [pauseButton addTarget:self action:@selector(b:) forControlEvents:CCControlEventTouchUpInside];
    pauseButton.position = ccp(kScreenPadding + pauseButton.contentSize.width,
                               [[CCDirector sharedDirector] winSize].height - pauseButton.contentSize.height / 2 - kScreenPadding);
    [self addChild:pauseButton];
    
    // Level Overview Button
    CCControlButton *levelsButton = [CCControlButton buttonWithTitle:@"Levels" fontName:@"Helvetica" fontSize:30];
    [levelsButton setAdjustBackgroundImage:NO];
    [levelsButton addTarget:self action:@selector(levelOverview:) forControlEvents:CCControlEventTouchUpInside];
    [self addChild:levelsButton];
    
    // Retry Button
    CCControlButton *retryButton = [CCControlButton buttonWithTitle:@"Retry" fontName:@"Helvetica" fontSize:30];
    [retryButton setAdjustBackgroundImage:NO];
    [retryButton addTarget:self action:@selector(retryLevel:) forControlEvents:CCControlEventTouchUpInside];
    [self addChild:retryButton];
}

#pragma mark -
#pragma mark Buttons
- (IBAction)a:(id)sender {
    NSLog(@"Pressed A Button.");
}


#pragma mark -
#pragma mark Retry Level
- (IBAction)retryLevel:(id)sender {
//    STScene *scene = [STLevelLayer sceneWithWorldID:self.worldID levelID:self.levelID];
//    [[CCDirector sharedDirector] replaceScene: scene
//                          withTransitionClass:[CCTransitionFade class]
//                                     duration:0.5];
}

#pragma mark -
#pragma mark Level Overview
- (IBAction)levelOverview:(id)sender {
//    [[CCDirector sharedDirector] replaceScene: [[STChooseLevelLayer layerWithWorldID:self.worldID] scene]
//                          withTransitionClass:[CCTransitionFade class]
//                                     duration:0.5];
}

@end
