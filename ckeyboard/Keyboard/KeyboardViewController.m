//
//  KeyboardViewController.m
//  Keyboard
//
//  Created by Lúcio Barros on 16/05/15.
//  Copyright (c) 2015 BEPiD Fucapi. All rights reserved.
//

#import "KeyboardViewController.h"

@interface KeyboardViewController ()
@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];

   
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    CoreData *appDel = [[CoreData alloc] init];
    NSManagedObjectContext *context = appDel.managedObjectContext;
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Key" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:entity];
    
    [request entityName];
    request.returnsObjectsAsFaults = false;
    
    NSArray *results = [[NSArray alloc] init];
    results = [context executeFetchRequest:request error:nil];
    
    
    UILabel *detailTitle = (UILabel *)[cell.contentView viewWithTag:1];
    detailTitle.text = [results[indexPath.row] valueForKey:@"title"];

    return cell;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    CoreData *appDel = [[CoreData alloc] init];
    NSManagedObjectContext *context = appDel.managedObjectContext;
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Key" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:entity];
    
    [request entityName];
    request.returnsObjectsAsFaults = false;
    
    NSArray *results = [[NSArray alloc] init];
    results = [context executeFetchRequest:request error:nil];
    return results.count;
    }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
   }

@end
