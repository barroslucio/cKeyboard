//
//  KeyboardViewController.m
//  Keyboard
//
//  Created by Lúcio Barros on 16/05/15.
//  Copyright (c) 2015 BEPiD Fucapi. All rights reserved.
//

#import "KeyboardViewController.h"
#import "CollectionViewCell.h"

@interface KeyboardViewController ()

@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.spaceKey addTarget:self action:@selector(pressSpaceKey) forControlEvents:UIControlEventTouchUpInside];
    
    [self.returnKey addTarget:self action:@selector(pressReturnKey) forControlEvents:UIControlEventTouchUpInside];
    
    [self.globeKey addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
   
    
}


- (void)pressSpaceKey{
    [self.textDocumentProxy insertText:@" "];
}

- (void)pressReturnKey{
    [self.textDocumentProxy deleteBackward];
}


/*
-(void)buttonPressed:(UIButton *)sender
{
    CGPoint center = CGPointMake(CGRectGetMidX(sender.bounds), CGRectGetMidY(sender.bounds));
    CGPoint transformedCenter = [sender convertPoint:center toView:self.collectionView];
    
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:transformedCenter];
    
    if (indexPath == nil) {
        return;
    }
    
    
    CoreData *appDel = [[CoreData alloc] init];
    NSManagedObjectContext *context = appDel.managedObjectContext;
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Key" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:entity];
    
    [request entityName];
    request.returnsObjectsAsFaults = false;
    
    NSArray *results = [[NSArray alloc] init];
    results = [context executeFetchRequest:request error:nil];

    [self.textDocumentProxy insertText:[results[indexPath.row]valueForKey:@"content" ]];
    
}
*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    /*
    //add dynamic action
    if (cell.button.allTargets.count == 0)
        [cell.button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                                                                                                       
    CoreData *appDel = [[CoreData alloc] init];
    NSManagedObjectContext *context = appDel.managedObjectContext;
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Key" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:entity];
    
    [request entityName];
    request.returnsObjectsAsFaults = false;
    
    NSArray *results = [[NSArray alloc] init];
    results = [context executeFetchRequest:request error:nil];
    
    
    [cell.button setTitle:[results[indexPath.row] valueForKey:@"title"] forState:UIControlStateNormal];

     */
    [cell.button setTitle:@"Title" forState:UIControlStateNormal];
    return cell;
    
 
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   /*
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
    */
    return 10;
 
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
