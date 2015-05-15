//
//  KeyTableViewCell.h
//  ckeyboard
//
//  Created by Patrick Magalhães de Lima on 15/05/15.
//  Copyright (c) 2015 BEPiD Fucapi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblKeyTitle;
@property (weak, nonatomic) NSString *keyIdentifier;
@end
