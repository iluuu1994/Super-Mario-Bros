//
//  AppDelegate.h
//  Game
//
//  Created by Ilija Tovilo on 1/26/13.
//  Copyright Ilija Tovilo 2013. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

#pragma mark -
#pragma mark MyNavigationController Interface

@interface MyNavigationController : UINavigationController <CCDirectorDelegate>
@end



#pragma mark -
#pragma mark AppController Interface

/**
 * The start point of our application
 * It configures and initializes Cocos2d
 */
@interface AppController : NSObject <UIApplicationDelegate>
{
	UIWindow *window_;
	MyNavigationController *navController_;
}

/**
 * The main window of the application
 */
@property (nonatomic, strong) UIWindow *window;

/**
 * The main navigation controller
 * This is used for rotation of the device
 */
@property (readonly) MyNavigationController *navController;

/**
 * The director for Cocos2d
 */
@property (unsafe_unretained, readonly) CCDirectorIOS *director;

@end
