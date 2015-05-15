//
//  ViewController.m
//  ckeyboard
//
//  Created by Lúcio Barros on 09/05/15.
//  Copyright (c) 2015 BEPiD Fucapi. All rights reserved.
//

#import "CKBMainViewController.h"

@interface CKBMainViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtFieldTitle;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldContent;
@property (weak, nonatomic) IBOutlet UITableView *tbViewButtons;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnCancel;

@property (nonatomic) BOOL isEditing;
@end

@implementation CKBMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isEditing = false;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[KeyStore sharedStore] getAllKeys] count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Key *key = [[[KeyStore sharedStore] getAllKeys] objectAtIndex:indexPath.row];
    _txtFieldTitle.text = key.title;
    _txtFieldContent.text = key.content;
    _isEditing = true;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KeyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ButtonCell"];
    Key *key = [[[KeyStore sharedStore] getAllKeys] objectAtIndex:indexPath.row];
    cell.lblKeyTitle.text = key.title;
    cell.keyIdentifier = key.identifier;
    
    return cell;
}

- (IBAction)saveShortcut:(UIBarButtonItem *)sender {
    if(![_txtFieldTitle hasText] || ![_txtFieldContent hasText])
        return ;
    if(_isEditing) {

    } else {
        [[KeyStore sharedStore] createKeyWithTitle:_txtFieldTitle.text AndContent:_txtFieldContent.text];
    }
    [_tbViewButtons reloadData];
    _txtFieldTitle.text = _txtFieldContent.text = @"";
}

@end
