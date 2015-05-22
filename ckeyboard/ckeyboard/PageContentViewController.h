//
//  PageContentViewController.h
//  ckeyboard
//
//  Created by Pedro Luis Berbel dos Santos on 22/05/15.
//  Copyright (c) 2015 BEPiD Fucapi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;


@property NSUInteger pageIndex;
@property NSString *imageFile;
@property NSString *titleText;

@end
