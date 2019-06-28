//
//  MycreationVC.h
//  DemoPhotoMaker
//
//  Created by Sanjay Kakadiya on 7/29/17.
//  Copyright (c) 2017 Sanay kakadiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewCell.h"
#import "AppDelegate.h"
#import "MycreationDetailVC.h"
@interface MycreationVC : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
{
    
    __weak IBOutlet UICollectionView *collectionMyCreation;
}
@property (nonatomic,retain) NSMutableArray *aryPhotodata;
- (IBAction)btnBack:(id)sender;
@end
