//
//  HelloWorldLayer.m
//  Game
//
//  Created by Ilija Tovilo on 1/26/13.
//  Copyright Ilija Tovilo 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	
	HelloWorldLayer *layer = [HelloWorldLayer node];
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
    
    
    // Das isch nur sample-code!
    // Isch oberhässlech.
    // Mir wärde ner am beschte e TiledMapScene mache, subclass CCScene
    // Und ner für jedi map die nomau subclasse wome nur der name vor map cha age
    // und die würd ner o gad die sublayers uselese usw.
    
    
	if(self = [super init]) {
        self.tiledMap = [CCTMXTiledMap tiledMapWithTMXFile:@"temple.tmx"];
        self.backgroundLayer = [self.tiledMap layerNamed:@"bg"];
        
        CGSize winSize = [CCDirector sharedDirector].winSize;

        if (winSize.width > self.tiledMap.mapSize.width) {
            self.tiledMap.anchorPoint = ccp(-0.5, self.tiledMap.anchorPoint.y);
        }
        if (winSize.height > self.tiledMap.mapSize.height) {
            self.tiledMap.anchorPoint = ccp(self.tiledMap.anchorPoint.x, -0.5);
        }

        [self addChild:self.tiledMap  z:-1];
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	self.tiledMap = nil;
    self.backgroundLayer = nil;
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
