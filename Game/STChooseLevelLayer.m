//
//  STChooseLevelLayer.m
//  Game
//
//  Created by Lukas Seglias on 01.04.13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import "STChooseLevelLayer.h"
#import "STWorldsConstants.h"
#import "CCControlExtension.h"
#import "CCDirector+Transitions.h"
#import "NSBundle+Resources.h"
#import "STLayerConstants.h"

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
    
    NSArray *root = [NSDictionary dictionaryWithContentsOfFile:[NSBundle pathForResource:kWorldsFile]];

    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    // Retrieve the world with the given id
    NSDictionary *selectedWorld;
    for(NSDictionary *world in [root valueForKey:kWorldsKey]) {
        if(worldID == [[world objectForKey:kWorldIDKey] integerValue]) {
            selectedWorld = world;
            break;
        }
    }
    self.world = selectedWorld;
    
    NSMutableArray *pages = [[NSMutableArray alloc] init];
    
    for(NSDictionary *level in [selectedWorld objectForKey:kLevelsKey]) {

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
        CCMenuItemLabel *title = [CCMenuItemLabel itemWithLabel:tlabel target:self selector:@selector(level:)];
        [title setUserObject:level];
        
        // Level Item Menu
        CCMenu *menu = [CCMenu menuWithItems: levelItem, title, nil];
        [menu alignItemsVerticallyWithPadding:20];
        menu.position = ccp(winSize.width / 2, winSize.height / 2);
        
        if([[level valueForKey:kLevelIsLockedKey] boolValue]) {
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
    CCControlButton *worldsButton = [CCControlButton buttonWithTitle:@"Back" fontName:@"Helvetica" fontSize:30];
    [worldsButton setAdjustBackgroundImage:NO];
    [worldsButton addTarget:self action:@selector(worlds:) forControlEvents:CCControlEventTouchUpInside];
    worldsButton.position = ccp(worldsButton.contentSize.width / 2 + kScreenPadding, worldsButton.contentSize.height / 2 + kScreenPadding);
    [self addChild:worldsButton];
}

#pragma mark -
#pragma mark Select Level
- (IBAction)level:(id)sender {
    NSDictionary *level = [sender userObject];
    BOOL isLocked = [[level valueForKey:kLevelIsLockedKey] boolValue];
    
    if(!isLocked) {
        STScene *scene = [[STLevelLayer layerWithWorldID:[[self.world valueForKey:kWorldIDKey] shortValue]
                                                levelID:[[level valueForKey:kLevelIDKey] shortValue]] scene];
        [[CCDirector sharedDirector] replaceScene: scene
                              withTransitionClass:[CCTransitionFade class]
                                         duration:0.5];
    }
}

#pragma mark -
#pragma mark Switch Scene
- (IBAction)worlds:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[STChooseWorldLayer scene]
                          withTransitionClass:[CCTransitionFade class]
                                     duration:0.5];
}

@end
