//
//  ITSingleton.h
//  Nimblify
//
//  Created by Ilija Tovilo on 2/16/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

/**
 * Helper for all singleton classes
 * Defines shortcuts for interface and implementation
 */

#ifndef Nimblify_ITSingleton_h
#define Nimblify_ITSingleton_h

// Interface
#define ITSingletonInterface +(id)sharedInstance;

// Implementation
#define ITSingletonImplementation \
    static id sharedSingleton; \
    + (id)sharedInstance \
    { \
        \
        @synchronized(self) \
        { \
            if (!sharedSingleton) {  \
                sharedSingleton = [[self alloc] init]; \
            } \
            return sharedSingleton; \
        } \
    }




#endif
