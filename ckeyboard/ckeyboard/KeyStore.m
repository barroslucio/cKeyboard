//
//  KeyStore.m
//  ckeyboard
//
//  Created by Patrick Magalhães de Lima on 14/05/15.
//  Copyright (c) 2015 BEPiD Fucapi. All rights reserved.
//

#import "KeyStore.h"

@interface KeyStore ()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation KeyStore

static NSString *MODEL_ENTITY_NAME = @"Key";

+ (instancetype) sharedStore {
    static KeyStore *sharedStore;
    if(!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
        
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        sharedStore.managedObjectContext = appDelegate.managedObjectContext;
    }
    return sharedStore;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Couldn't create instance" reason:@"Use [KeyStore sharedStore]" userInfo:NULL];
}

- (instancetype)initPrivate {
    return (self = [super init]);
}

- (Key *)createKeyWithTitle:(NSString *)title AndContent:(NSString *)content {
    Key *key = [NSEntityDescription insertNewObjectForEntityForName:MODEL_ENTITY_NAME inManagedObjectContext:self.managedObjectContext];
    
    key.identifier = [[[NSUUID alloc] init] UUIDString];
    key.title = title;
    key.content = content;
    
    NSError *error;
    if(![self.managedObjectContext save:&error]) {
        NSLog(@"Occured an error saving the key! -> %@ - %@", error, error.debugDescription);
        abort();
    }
    return key;
}

- (NSArray*)getAllKeys {
    NSFetchRequest *fetchedRequestKey = [[NSFetchRequest alloc] initWithEntityName:MODEL_ENTITY_NAME];
    NSError *error;
    NSArray *objects = [self.managedObjectContext executeFetchRequest:fetchedRequestKey error:&error];
    
    if(error) {
        NSLog(@"Error fetching requesting key! -> %@ - %@", error, error.userInfo);
    }
    
    return objects;
}


- (BOOL)saveKeyChanges {
    NSError *error;
    
    if ([self.managedObjectContext hasChanges]) {
        BOOL successful = [self.managedObjectContext save:&error];
        
        if (!successful) {
            NSLog(@"Error saving: %@", [error localizedDescription]);
        }
        
        return successful;
    }
    
    return YES;
}

- (void)removeKey:(Key *)key {
    [self.managedObjectContext deleteObject:key];
}

@end
