//
//  ITSingleton.h
//  Nimblify
//
//  Created by Ilija Tovilo on 2/16/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#ifndef Nimblify_ITSingleton_h
#define Nimblify_ITSingleton_h



#define ITSingletonInterface +(id)sharedInstance;
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
