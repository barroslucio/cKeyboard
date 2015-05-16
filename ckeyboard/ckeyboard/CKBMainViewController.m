//
//  ViewController.m
//  ckeyboard
//
//  Created by Lúcio Barros on 09/05/15.
//  Copyright (c) 2015 BEPiD Fucapi. All rights reserved.
//

#import "CKBMainViewController.h"

#define MAX_TITLE_CHARACTERS 10
#define MAX_CONTENT_CHARACTERS 25

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
    [self shouldEnableButtonCancel];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KeyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ButtonCell"];
    Key *key = [[[KeyStore sharedStore] getAllKeys] objectAtIndex:indexPath.row];
    cell.lblKeyTitle.text = key.title;
    cell.keyIdentifier = key.identifier;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Key *key = [[[KeyStore sharedStore] getAllKeys] objectAtIndex:indexPath.row];
        [[KeyStore sharedStore] removeKey:key];
        [[KeyStore sharedStore] saveKeyChanges];
        [self.tbViewButtons reloadData];
    }
}

- (IBAction)saveShortcut:(UIBarButtonItem *)sender {
    if(![_txtFieldTitle hasText] || ![_txtFieldContent hasText])
        return ;
    if(_isEditing) {
        Key *key = [[[KeyStore sharedStore] getAllKeys] objectAtIndex:[self.tbViewButtons indexPathForSelectedRow].row];
        key.title = _txtFieldTitle.text;
        key.content = _txtFieldContent.text;
        [[KeyStore sharedStore] saveKeyChanges];
        _isEditing = false;
    } else {
        [[KeyStore sharedStore] createKeyWithTitle:_txtFieldTitle.text AndContent:_txtFieldContent.text];
    }
    [_tbViewButtons reloadData];
    _txtFieldTitle.text = _txtFieldContent.text = @"";
    [self shouldEnableButtonCancel];
}

- (IBAction)cancelAddOrEdition:(UIBarButtonItem *)sender {
    _txtFieldTitle.text = _txtFieldContent.text = @"";
    _isEditing = false;
    [self shouldEnableButtonCancel];
}

- (void)shouldEnableButtonCancel {
    if(![_txtFieldTitle hasText] && ![_txtFieldContent hasText])
        [_btnCancel setEnabled:NO];
    else
        [_btnCancel setEnabled:YES];
}

- (IBAction)activateBtnCancel1:(id)sender {
    [self shouldEnableButtonCancel];
}

- (IBAction)activateBtnCancel2:(id)sender {
    [self shouldEnableButtonCancel];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    int MAX_LENGTH;
    if(textField == _txtFieldTitle) {
        MAX_LENGTH = MAX_TITLE_CHARACTERS;
    } else {
        MAX_LENGTH = MAX_CONTENT_CHARACTERS;
    }
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    NSLog(@"%ld", newLength);
        NSLog(@"%ld\n\n", range.location);
    return newLength <= MAX_LENGTH;
}
@end
