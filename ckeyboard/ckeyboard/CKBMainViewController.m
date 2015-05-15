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
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ButtonCell"];
    Key *key = [[[KeyStore sharedStore] getAllKeys] objectAtIndex:indexPath.row];
    cell.textLabel.text = key.title;
    cell.detailTextLabel.text = key.identifier;
    
    return cell;
}

- (IBAction)saveShortcut:(UIBarButtonItem *)sender {
    if(![_txtFieldTitle hasText] || ![_txtFieldContent hasText])
        return ;
    if(_isEditing) {
        [[KeyStore sharedStore] saveKeyChanges];
        _isEditing = false;
    } else {
        [[KeyStore sharedStore] createKeyWithTitle:_txtFieldTitle.text AndContent:_txtFieldContent.text];
        [_tbViewButtons reloadData];
    }
}

@end
