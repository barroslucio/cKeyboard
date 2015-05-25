//
//  KeyboardViewController.h
//  Keyboard
//
//  Created by Lúcio Barros on 16/05/15.
//  Copyright (c) 2015 BEPiD Fucapi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import <CoreData/CoreData.h>

@interface KeyboardViewController : UIInputViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIButton *globeKey;
@property (strong, nonatomic) IBOutlet UIButton *spaceKey;
@property (strong, nonatomic) IBOutlet UIButton *returnKey;

@end
