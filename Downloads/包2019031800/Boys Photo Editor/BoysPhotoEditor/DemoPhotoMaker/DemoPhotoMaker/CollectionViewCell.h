//
//  CollectionViewCell.h
//  DemoPhotoMaker
//
//  Created by Sanjay Kakadiya on 7/24/17.
//  Copyright (c) 2017 Sanay kakadiya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgviewCell;
@property (weak, nonatomic) IBOutlet UIButton *btnCancelCell;

@end
