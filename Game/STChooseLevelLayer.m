//
//  STChooseLevelLayer.m
//  Game
//
//  Created by Lukas Seglias on 01.04.13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import "STChooseLevelLayer.h"
#import "WorldsConstrants.h"
#import "CCControlExtension.h"
#import "CCDirector+Transitions.h"
#import "NSBundle+Resources.h"
#import "LayerConstants.h"

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

+(id)sceneWithWorldID:(unsigned short)worldID {
    
    STChooseLevelLayer *layer = [STChooseLevelLayer layerWithWorldID:worldID];
    STScene *scene = [STScene node];
    [scene addChild:layer];
    return scene;
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
    
    NSLog(@"before levels holen, selectedWorld: %@", [selectedWorld valueForKey:kWorldIDKey]);
    
    // TODO: getting multiple levels
    NSMutableArray *pages = [[NSMutableArray alloc] init];
//    NSArray *levels = [selectedWorld objectsForKeys:[NSArray arrayWithObjects:kLevelsKey, nil]
//                                     notFoundMarker:[NSNull null]];
    
    //NSLog(@"levels: %i", [[selectedWorld objectForKey:kLevelsKey]);
    
    //if([levels objectAtIndex:0] != (id)[NSNull null] && [levels count] > 0) {
        
        for(NSDictionary *level in [selectedWorld objectForKey:kLevelsKey]) {
            
            NSLog(@"inside loop");
            
            CCLayer *page = [[CCLayer alloc] init];
            
            CCSprite *levelIcon = [CCSprite spriteWithFile:[level valueForKey:kLevelIconNameKey]];
            CCSprite *levelIconSelected = [CCSprite spriteWithFile:[level valueForKey:kLevelIconNameKey]];
            
            NSDictionary *userObject = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:selectedWorld, level, nil]
                                                                   forKeys:[NSArray arrayWithObjects:kDictionaryWorldKey, kDictionaryLevelKey, nil]];
            
            CCMenuItemSprite *levelItem = [CCMenuItemSprite itemWithNormalSprite:levelIcon
                                                                  selectedSprite:levelIconSelected
                                                                          target:self
                                                                        selector:@selector(level:)];
            [levelItem setUserObject:userObject];
            
            // Level Title
            CCLabelTTF *tlabel = [CCLabelTTF labelWithString:[level valueForKey:kLevelNameKey] fontName:@"Helvetica" fontSize:20];
            CCMenuItemLabel *title = [CCMenuItemLabel itemWithLabel:tlabel target:self selector:@selector(level:)];
            [title setUserObject:userObject];
            
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
        
    //}
    
    // Back to Menu Button
    CCControlButton *menuButton = [CCControlButton buttonWithTitle:@"Back" fontName:@"Helvetica" fontSize:30];
    [menuButton setAdjustBackgroundImage:NO];
    [menuButton addTarget:self action:@selector(menu:) forControlEvents:CCControlEventTouchUpInside];
    menuButton.position = ccp(menuButton.contentSize.width / 2 + kScreenPadding, menuButton.contentSize.height / 2 + kScreenPadding);
    [self addChild:menuButton];
}

#pragma mark -
#pragma mark Select Level
- (IBAction)level:(id)sender {
    NSDictionary *data = [sender userObject];
    NSDictionary *world = [data valueForKey:kDictionaryWorldKey];
    NSDictionary *level = [data valueForKey:kDictionaryLevelKey];
    BOOL isLocked = [[level valueForKey:kLevelIsLockedKey] boolValue];
    
    if(!isLocked) {
        STScene *scene = [STLevelLayer sceneWithWorldID:[[world valueForKey:kWorldIDKey] shortValue]
                                                levelID:[[level valueForKey:kLevelIDKey] shortValue]];
        [[CCDirector sharedDirector] replaceScene: scene
                              withTransitionClass:[CCTransitionFade class]
                                         duration:0.5];
    }
}

#pragma mark -
#pragma mark Switch Scene
- (IBAction)menu:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[STStartLayer scene]
                          withTransitionClass:[CCTransitionFade class]
                                     duration:0.5];
}

@end
