//
//  STChooseLevelLayer.m
//  Game
//
//  Created by Lukas Seglias on 01.04.13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import "CCDirector+Transitions.h"
#import "CCControlExtension.h"
#import "STLayoutConstants.h"
#import "STWorldInfoReader.h"
#import "STWorldsConstants.h"
#import "STChooseWorldLayer.h"
#import "STChooseLevelLayer.h"
#import "CCScrollLayer.h"
#import "STStartLayer.h"
#import "STLevelLayer.h"

@implementation STChooseLevelLayer
{}

#pragma mark -
#pragma mark Initialise

- (id)initWithWorldID:(unsigned short)worldID
{
    self = [super init];
    if (self) {
        [self setUpWithWorldID:worldID];
    }
    return self;
}

+(id)layerWithWorldID:(unsigned short)worldID {
    return [[self alloc] initWithWorldID:worldID];
}

- (void)setUpWithWorldID:(unsigned short)worldID {
    [super setUp];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    // Scene Title
    CCLabelTTF *title = [CCLabelTTF labelWithString:@"Levels" fontName:kTitleFontName fontSize:kTitleFontSize];
    [title setColor:kTitleTextColor];
    title.position = ccp(winSize.width / 2, winSize.height - title.contentSize.height - kPadding);
    [self addChild:title];
    
    // Retrieve the world with the given id
    self.world = [[STWorldInfoReader sharedInstance] worldWithID:worldID];
    
    NSMutableArray *pages = [[NSMutableArray alloc] init];
    
    for(NSDictionary *level in [self.world objectForKey:kLevelsKey]) {

        unsigned short levelID = [[level valueForKey:kLevelIDKey] shortValue];
        
        CCLayer *page = [[CCLayer alloc] init];
        
        CCSprite *levelIcon = [CCSprite spriteWithFile:[level valueForKey:kLevelIconNameKey]];
        CCSprite *levelIconSelected = [CCSprite spriteWithFile:[level valueForKey:kLevelIconNameKey]];
        
        CCMenuItemSprite *levelItem = [CCMenuItemSprite itemWithNormalSprite:levelIcon
                                                              selectedSprite:levelIconSelected
                                                                      target:self
                                                                    selector:@selector(level:)];
        [levelItem setUserObject:level];
        
        // Level Title
        CCLabelTTF *tlabel = [CCLabelTTF labelWithString:[level valueForKey:kLevelNameKey]
                                                fontName:@"Helvetica" fontSize:20];
        [tlabel setColor:kTextColor];
        CCMenuItemLabel *title = [CCMenuItemLabel itemWithLabel:tlabel target:self selector:@selector(level:)];
        [title setUserObject:level];
        
        // Level Item Menu
        CCMenu *menu = [CCMenu menuWithItems: levelItem, title, nil];
        [menu alignItemsVerticallyWithPadding:20];
        menu.position = ccp(winSize.width / 2, winSize.height / 2);
        
        // If the level is locked
        if(![[STWorldInfoReader sharedInstance] isUnlockedWorldID:worldID levelID:levelID]) {
            // Locked Icon
            CCMenuItemSprite *lock = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:kLockIcon]
                                                             selectedSprite:[CCSprite spriteWithFile:kLockIcon]];
            lock.position = ccp(levelItem.position.x + levelItem.contentSize.width / 2, levelItem.position.y);
            [levelItem addChild:lock];
        }
        
        [page addChild:menu];
        [pages addObject:page];
    }
    
    CCScrollLayer *scroller = [[CCScrollLayer alloc] initWithLayers:pages widthOffset:winSize.width / 1.5];
    [self addChild:scroller];
    
    // Back to World Selection Button
    CCLabelTTF *worldsLabel = [CCLabelTTF labelWithString:@"Worlds" fontName:kButtonFontName fontSize:kButtonFontSize];
    [worldsLabel setColor:kButtonTextColor];
    CCControlButton *worldsButton = [CCControlButton buttonWithLabel:worldsLabel
                                                    backgroundSprite:[CCScale9Sprite spriteWithFile:kButtonImageName]];
    [worldsButton addTarget:self action:@selector(worlds:) forControlEvents:CCControlEventTouchUpInside];
    worldsButton.position = ccp(worldsButton.contentSize.width / 2 + kPadding,
                                worldsButton.contentSize.height / 2 + kPadding);
    [self addChild:worldsButton];
}

#pragma mark -
#pragma mark Select Level

/**
 * When the user selected a level this message is called. Starts the game with the selected level.
 * @param sender - the sender of this message. The STSettingsLayer.
 * @return an IBAction.
 */
- (IBAction)level:(id)sender {
    NSDictionary *level = [sender userObject];
    unsigned short worldID = [[self.world valueForKey:kWorldIDKey] shortValue];
    unsigned short levelID = [[level valueForKey:kLevelIDKey] shortValue];
    BOOL isUnlocked = [[STWorldInfoReader sharedInstance] isUnlockedWorldID:worldID levelID:levelID];
    
    if(isUnlocked) {
        STScene *scene = [[STLevelLayer layerWithWorldID:worldID levelID:levelID] scene];
        [[CCDirector sharedDirector] replaceScene: scene
                              withTransitionClass:[CCTransitionFade class]
                                         duration:0.5];
    }
}

#pragma mark -
#pragma mark Switch Scene

/**
 * When the user wants to  go back to the overview of all worlds this message is called.
 * @param sender - the sender of this message. The STChooseLevelLayer.
 * @return an IBAction.
 */
- (IBAction)worlds:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[STChooseWorldLayer scene]
                          withTransitionClass:[CCTransitionFade class]
                                     duration:0.5];
}

@end
