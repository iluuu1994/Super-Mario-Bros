//
//  STGameObject.h
//  Game
//
//  Created by Ilija Tovilo on 4/23/13.
//  Copyright (c) 2013 by Lukas Seglias & Ilija Tovilo. All rights reserved.
//

#import "STAnimatedSprite.h"


#pragma mark -
#pragma mark Enums

#ifndef STGameObjectEnums
#define STGameObjectEnums

/**
 * An enum representing an edge of a game object.
 */
typedef enum {
    // Left edge
    STRectEdgeMinX,
    // Bottom edge
    STRectEdgeMinY,
    // Right edge
    STRectEdgeMaxX,
    // Top edge
    STRectEdgeMaxY
} STRectEdge;

/**
 * Super Mario Bros has 3 kinds of levels:
 * - Normal levels (Like level 1)
 * - Underground Levels
 * - Castle Levels
 *
 * The same object has a different appearance in those different environments.
 * Therefore, we use an enum to represent it.
 */
typedef enum {
    /**
     * Default appearance.
     */
    STAppearanceTypeDefault,
    
    /**
     * Appearance for underground levels.
     */
    STAppearanceTypeDark,
    
    /**
     * Appearance for castle levels.
     */
    STAppearanceTypeCastle
} STAppearanceType;

/**
 * The body type is used for the physics to know how to handle the game object.
 */
typedef enum {
    /** 
     * The body is non-colliding, meaning a collision has no physial consequences.
     */
    STGameObjectBodyTypeNonColliding,
    
    /**
     * The body type is static, meaning it will never be moved.
     */
    STGameObjectBodyTypeStatic,
    
    /**
     * The body type is dynamic, which means it is bound to gravity, and collisions with other objects.
     */
    STGameObjectBodyTypeDynamic,
    
    /**
     * The body type is semi-dynamic, which means it collides with other objects, but is not bound to gravity.
     */
    STGameObjectBodyTypeSemiDynamic
} STGameObjectBodyType;

#endif


#pragma mark -
#pragma mark Protocols

/**
 * This is the delegate protocol for the game objects. The delegate will typically be an STLevelLayer.
 * Subclasses may extend this protocol, to define more methods.
 */
@class STGameObject;
@protocol STGameObjectDelegate <NSObject>
/**
 * The game object delegate has to be able to put more objects on the screen.
 * @param gameObject - the game object that should be put on the screen.
 * @param position - The position that the game object should be put to
 */
- (void)addGameObjectToMap:(STGameObject *)gameObject toPosition:(CGPoint)position;
@end


#pragma mark -
#pragma mark STGameObject Class

/**
 * The game object represents a real object on the screen.
 * It is bound to the laws of physics, and it collides with all the other game objects.
 */
@interface STGameObject : STAnimatedSprite <CCTouchAllAtOnceDelegate>
{}

#pragma mark -
#pragma mark Properties

/**
 * Defines if the game objects receives a touch notification.
 * To actiave, simply override the `needsTouchNotifications` method and return `YES`.
 */
@property (readonly) BOOL needsTouchNotifications;

/**
 * The velocity of the game object is added to the position in every update.
 * This creates smooth movement game objects.
 * It can also create the effect of acceleration, when you constantly increase the velocity.
 */
@property CGPoint velocity;

/**
 * The body type defines how physics should treat the object.
 */
@property STGameObjectBodyType bodyType;

/**
 * Defines if the object differenciates between the different level appearances.
 */
@property (readonly, nonatomic) BOOL differenciatesAppearance;

/**
 * The appearance type defines what appearance the type should have, relative to the level.
 * This only occurs if `differenciatesAppearance` returns `YES`.
 */
@property (nonatomic) STAppearanceType appearanceType;

/**
 * Defines if the game object is dead.
 * If it is dead, it will be removed in the next update.
 */
@property (setter = setDead:) BOOL isDead;

/**
 * Holds the delegate of the game object.
 * This property can be overridden in subclasses.
 */
@property (unsafe_unretained) id<STGameObjectDelegate> delegate;


#pragma mark -
#pragma mark Methods

/**
 * Kills the game object.
 * This most likely plays a sound.
 * To kill a game object silently, do `setDead:`.
 */
- (void)die;

/**
 * Moves the game object by a delta point.
 * @param deltaPoint - The value that the game object should be moved by
 */
- (void)move:(CGPoint)deltaPoint;

/**
 * This method is auctomatically called, if the game object collided with another game object.
 * The game object can then handle the collision.
 * @param gameObject - the game object with which we collided
 * @param edge - The rect edge, wich collided
 */
- (void)collisionWithGameObject:(STGameObject *)gameObject
                           edge:(STRectEdge)edge;

/**
 * This method returns the appearance-specific name of a resource.
 * For example, "block" in a dark-level will return "dark-block".
 * @param name - The base name of the resource/animation/frame
 * @return The adjusted string for the resource/animation/frame
 */
- (NSString *)appearanceNameForString:(NSString *)name;

@end
