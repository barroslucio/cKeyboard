//
//  KeyStore.h
//  ckeyboard
//
//  Created by Patrick Magalhães de Lima on 14/05/15.
//  Copyright (c) 2015 BEPiD Fucapi. All rights reserved.
//

@import CoreData;
#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "Key.h"

@interface KeyStore : NSObject

+ (instancetype)sharedStore;

- (Key*)createKeyWithTitle:(NSString*)title AndContent:(NSString*)content;
- (Key*)getKeyWithIdentifier:(NSString*)identifier;
- (NSArray*)getAllKeys;
- (void)removeKey:(Key*)key;
- (BOOL)saveKeyChanges;

@end
