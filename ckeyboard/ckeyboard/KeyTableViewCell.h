//
//  KeyTableViewCell.h
//  ckeyboard
//
//  Created by Patrick Magalhães de Lima on 15/05/15.
//  Copyright (c) 2015 BEPiD Fucapi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyTableViewCell : UITableViewCell
// a primeira label (lblKeyTitle) serve para guardar o título, que será exibido na table view
// a segunda label (keyIdentifier) guardará o identificador, visto que as células serão recuperadas do
// core data e todas as operações subsequentes (alteração e exclusão) dependem desse identificador, que
// será invisível ao usuário.
@property (weak, nonatomic) IBOutlet UILabel *lblKeyTitle;
@property (weak, nonatomic) NSString *keyIdentifier;
@end
