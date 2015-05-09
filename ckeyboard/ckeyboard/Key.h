//
//  Key.h
//  ckeyboard
//
//  Created by Lúcio Barros on 09/05/15.
//  Copyright (c) 2015 BEPiD Fucapi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Key : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * content;

@end
