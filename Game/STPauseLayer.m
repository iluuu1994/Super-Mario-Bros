//
//  STPauseLayer.m
//  Game
//
//  Created by Lukas Seglias on 30.04.13.
//  Copyright (c) 2013 by Lukas Seglias & Ilija Tovilo. All rights reserved.
//

#import "STPauseLayer.h"
#import "CCDirector+Transitions.h"
#import "CCControlExtension.h"
#import "STGameFlowManager.h"
#import "STWorldInfoReader.h"
#import "STWorldsConstants.h"
#import "STLayoutConstants.h"
#import "STChooseLevelLayer.h"
#import "STLevelLayer.h"

// Button images
#define kRepeatButtonImage @"repeat.png"
#define kLevelsButtonImage @"levels.png"
#define kPlayButtonImage @"play.png"

// Format of the displayed world and level number
#define kWorldLevelNumberFormat @"%02u-%02u"

// Color of the background layer
#define kPausePanelColor ccc4(128, 128, 128, 128)

@implementation STPauseLayer
{}

#pragma mark -
#pragma mark Initialise

-(id)initWithDelegate:(id <STPauseDelegate>)delegate
              worldID:(unsigned short)worldID
              levelID:(unsigned short)levelID {
    self = [super init];
    if (self) {
        [self setUpWithDelegate:delegate worldID:worldID levelID:levelID];
    }
    return self;
}

+(id)layerWithDelegate:(id <STPauseDelegate>)delegate
               worldID:(unsigned short)worldID
               levelID:(unsigned short)levelID {
    return [[self alloc] initWithDelegate:delegate worldID:worldID levelID:levelID];
}

- (void)setUpWithDelegate:(id <STPauseDelegate>)delegate
                  worldID:(unsigned short)worldID
                  levelID:(unsigned short)levelID {
    self.worldID = worldID;
    self.levelID = levelID;
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    // Level Information
    NSDictionary *world = [[STWorldInfoReader sharedInstance] worldWithID:worldID];
    NSDictionary *level = [[STWorldInfoReader sharedInstance] levelWithWorldID:worldID levelID:levelID];
    NSString *levelInfo = [NSString stringWithFormat:kWorldLevelNumberFormat,
                           [[world valueForKey:kWorldShortNameKey] integerValue],
                           [[level valueForKey:kLevelShortNameKey] integerValue]];
    CCLabelTTF *levelLabel = [CCLabelTTF labelWithString:levelInfo fontName:kButtonFontName fontSize:kButtonFontSize];
    [levelLabel setColor:kTextColor];
    levelLabel.position = ccp(kPadding + levelLabel.contentSize.width / 2,
                         winSize.height - levelLabel.contentSize.height / 2 - kPadding);
    [self addChild:levelLabel];
    
    // Play Button
    CCControlButton *continueButton = [CCControlButton buttonWithBackgroundSprite:
                                    [CCScale9Sprite spriteWithFile:kPlayButtonImage]];
    [continueButton setAdjustBackgroundImage:NO];
    continueButton.scale = 0.8;
    [continueButton addTarget:delegate action:@selector(play:) forControlEvents:CCControlEventTouchUpInside];
    continueButton.position = ccp(levelLabel.position.x,
                                  winSize.height - continueButton.contentSize.height / 2
                                  - levelLabel.contentSize.height - 2 * kPadding);
    [self addChild:continueButton];
    
    // Retry Button
    CCControlButton *retryButton = [CCControlButton buttonWithBackgroundSprite:
                                       [CCScale9Sprite spriteWithFile:kRepeatButtonImage]];
    [retryButton setAdjustBackgroundImage:NO];
    retryButton.scale = 0.8;
    [retryButton addTarget:delegate action:@selector(retryLevel:) forControlEvents:CCControlEventTouchUpInside];
    retryButton.position = ccp(levelLabel.position.x,
                               kPadding + retryButton.contentSize.height / 2);
    [self addChild:retryButton];
    
    // Level Overview Button
    CCControlButton *levelsButton = [CCControlButton buttonWithBackgroundSprite:
                                    [CCScale9Sprite spriteWithFile:kLevelsButtonImage]];
    [levelsButton setAdjustBackgroundImage:NO];
    levelsButton.scale = 0.8;
    [levelsButton addTarget:self action:@selector(levelOverview:) forControlEvents:CCControlEventTouchUpInside];
    levelsButton.position = ccp(levelLabel.position.x,
                                kPadding + levelsButton.contentSize.height / 2 + retryButton.contentSize.height + kPadding);
    [self addChild:levelsButton];
    
    [self addChild:[CCLayerColor layerWithColor:kPausePanelColor
                                          width:levelLabel.contentSize.width + 2 * kPadding
                                         height:[[CCDirector sharedDirector] winSize].height] z:-5];
}

#pragma mark -
#pragma mark Level Overview

/**
 * Switch to the level overview.
 * @param sender - the sender of this message. The STPauseLayer.
 * @return an IBAction.
 */
- (IBAction)levelOverview:(id)sender {
    [[STGameFlowManager sharedInstance] resumeWithMusicOn:NO];
    [[CCDirector sharedDirector] replaceScene: [[STChooseLevelLayer layerWithWorldID:self.worldID] scene]
                          withTransitionClass:[CCTransitionFade class]
                                     duration:0.5];
}

@end
