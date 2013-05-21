//
//  STLevelResultLayer.m
//  Game
//
//  Created by Lukas Seglias on 01.04.13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import "STLevelResultLayer.h"
#import "CCDirector+Transitions.h"
#import "CCControlExtension.h"
#import "CCControlButton.h"
#import "STLayoutConstants.h"
#import "STWorldsConstants.h"
#import "STWorldInfoReader.h"
#import "STChooseWorldLayer.h"
#import "STChooseLevelLayer.h"
#import "STLevelLayer.h"

@implementation STLevelResultLayer
{}

#pragma mark -
#pragma mark Initialise

-(id)initWithWorldID:(unsigned short)worldID
             levelID:(unsigned short)levelID
                time:(int)time
               score:(int)score
             success:(BOOL)success {
    
    self = [super init];
    if (self) {
        [self setUpWithWorldID:worldID levelID:levelID time:time score:score success:success];
    }
    return self;
}

+(id)layerWithWorldID:(unsigned short)worldID
              levelID:(unsigned short)levelID
                 time:(int)time
                score:(int)score
              success:(BOOL)success {
    return [[self alloc] initWithWorldID:worldID levelID:levelID time:time score:score success:success];
}

- (void)setUpWithWorldID:(unsigned short)worldID
                 levelID:(unsigned short)levelID
                    time:(int)time
                   score:(int)score
                 success:(BOOL)success {
    self.worldID = worldID;
    self.levelID = levelID;

    [self unlockNextLevel];
    
    NSString *title = @"Game Over!";
    if(success) {
        title = @"Congratulations!";
    }
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    int m = (time / 60) % 60;
    int s = time % 60;

    NSString *formattedTime = [NSString stringWithFormat:@"%02u:%02u", m, s];
    
    // Scene Title
    CCLabelTTF *titleLabel = [CCLabelTTF labelWithString:title fontName:kTitleFontName fontSize:kTitleFontSize];
    [titleLabel setColor:kTitleTextColor];
    titleLabel.position = ccp(winSize.width / 2, winSize.height - titleLabel.contentSize.height - kPadding);
    [self addChild:titleLabel];

    // Menu
    CCMenu *menu = [CCMenu menuWithItems:
                    [CCMenuItemFont itemWithString:[NSString stringWithFormat:@"Score: %i", score]],
                    [CCMenuItemFont itemWithString:[NSString stringWithFormat:@"Time: %@", formattedTime]],
                    nil];
    
    // Level Overview Button
    CCLabelTTF *levelsLabel = [CCLabelTTF labelWithString:@"Levels" fontName:kButtonFontName fontSize:kButtonFontSize];
    [levelsLabel setColor:kButtonTextColor];
    CCControlButton *levels = [CCControlButton buttonWithLabel:levelsLabel
                                              backgroundSprite:[CCScale9Sprite spriteWithFile:kButtonImageName]];
    [levels addTarget:self action:@selector(levelOverview:) forControlEvents:CCControlEventTouchUpInside];
    [self addChild:levels];

    // Retry Button
    CCLabelTTF *retryLabel = [CCLabelTTF labelWithString:@"Retry" fontName:kButtonFontName fontSize:kButtonFontSize];
    [retryLabel setColor:kButtonTextColor];
    CCControlButton *retry = [CCControlButton buttonWithLabel:retryLabel
                                              backgroundSprite:[CCScale9Sprite spriteWithFile:kButtonImageName]];
    [retry addTarget:self action:@selector(retryLevel:) forControlEvents:CCControlEventTouchUpInside];
    [self addChild:retry];
    
    if(success) {
        // Level Overview Button
        levels.position = ccp(winSize.width / 2, levels.contentSize.height / 2 + kPadding);
        
        // Retry Button
        retry.position = ccp(winSize.width / 2 - levels.contentSize.width / 2 - retry.contentSize.width / 2 - kPadding,
                             retry.contentSize.height / 2 + kPadding);
        
        // Next Level Button
        CCLabelTTF *nextLabel = [CCLabelTTF labelWithString:@"Next" fontName:kButtonFontName fontSize:kButtonFontSize];
        [nextLabel setColor:kButtonTextColor];
        CCControlButton *next = [CCControlButton buttonWithLabel:nextLabel
                                                 backgroundSprite:[CCScale9Sprite spriteWithFile:kButtonImageName]];
        next.position = ccp(winSize.width / 2 + levels.contentSize.width / 2 + next.contentSize.width / 2 + kPadding,
                            next.contentSize.height / 2 + kPadding);
        [next addTarget:self action:@selector(nextLevel:) forControlEvents:CCControlEventTouchUpInside];
        [self addChild:next];
    } else {
        // Retry Button
        retry.position = ccp(winSize.width / 2 - retry.contentSize.width / 2 - kPadding,
                             retry.contentSize.height / 2 + kPadding);
        // Level Overview Button
        levels.position = ccp(winSize.width / 2 + levels.contentSize.width / 2 + kPadding,
                              levels.contentSize.height / 2 + kPadding);
    }
    
    [menu alignItemsVerticallyWithPadding:20];
    [self addChild:menu];
}

#pragma mark -
#pragma mark Retry Level

/**
 * When the user wants to retry the level this message is called. Restarts the level.
 * @param sender - the sender of this message. The STLevelResultLayer.
 * @return an IBAction.
 */
- (IBAction)retryLevel:(id)sender {    
    STScene *scene = [[STLevelLayer layerWithWorldID:self.worldID levelID:self.levelID] scene];
    [[CCDirector sharedDirector] replaceScene: scene
                          withTransitionClass:[CCTransitionFade class]
                                     duration:0.5];
}

#pragma mark -
#pragma mark Level Overview

/**
 * When the user wants to go to the levels overview this message is called.
 * Switches to the overview of all levels.
 * @param sender - the sender of this message. The STLevelResultLayer.
 * @return an IBAction.
 */
- (IBAction)levelOverview:(id)sender {
    [[CCDirector sharedDirector] replaceScene: [[STChooseLevelLayer layerWithWorldID:self.worldID] scene]
                          withTransitionClass:[CCTransitionFade class]
                                     duration:0.5];
}

#pragma mark -
#pragma mark Next Level

/**
 * When the user wants to start the next level this message is called. Starts the next level.
 * @param sender - the sender of this message. The STLevelResultLayer.
 * @return an IBAction.
 */
- (IBAction)nextLevel:(id)sender {
    // Which is the next level?
    NSDictionary *nextLevel = [[STWorldInfoReader sharedInstance]
                               nextLevelFromWorldID:self.worldID levelID:self.levelID];
    
    // Unlock next world if we finished the last level of the current world.
    if([[STWorldInfoReader sharedInstance] isLastLevel:self.levelID fromWorld:self.worldID]) {
        [[CCDirector sharedDirector] replaceScene: [STChooseWorldLayer scene]
                              withTransitionClass:[CCTransitionFade class]
                                         duration:0.5];
    } else {
        unsigned short levelID = [[nextLevel valueForKey:kLevelIDKey] shortValue];

        STScene *scene = [[STLevelLayer layerWithWorldID:self.worldID levelID:levelID] scene];
        [[CCDirector sharedDirector] replaceScene: scene
                              withTransitionClass:[CCTransitionFade class]
                                         duration:0.5];
    }
}

/**
 * Unlocks the next level. If the current level is the last of the current world, the next world is unlocked. 
 */
- (void)unlockNextLevel {
    // Which is the next world?
    NSDictionary *nextWorld = [[STWorldInfoReader sharedInstance] nextWorldFromWorldID:self.worldID];
    // Which is the next level?
    NSDictionary *nextLevel = [[STWorldInfoReader sharedInstance]
                               nextLevelFromWorldID:self.worldID levelID:self.levelID];
    
    // Unlock next world if we finished the last level of the current world.
    if([[STWorldInfoReader sharedInstance] isLastLevel:self.levelID fromWorld:self.worldID]) {
        // If there is a new world we unlock it.
        if(nextWorld) {
            [[STWorldInfoReader sharedInstance] unlockWorldID:[[nextWorld valueForKey:kWorldIDKey] shortValue]];
        }
    } else {
        unsigned short levelID = [[nextLevel valueForKey:kLevelIDKey] shortValue];
        [[STWorldInfoReader sharedInstance] unlockWorldID:self.worldID levelID:levelID];
    }
}

@end
