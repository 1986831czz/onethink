//
//  PhotoEditerView.h
//  DemoPhotoMaker
//
//  Created by Sanjay Kakadiya on 7/19/17.
//  Copyright (c) 2017 Sanay kakadiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface PhotoEditerView : UIViewController
{
    IBOutlet __weak UIImageView *_imageView;
}
@property(nonatomic,strong)UIImage *imgGet;

- (IBAction)btnChooseFrame:(id)sender;
- (IBAction)btnSavePhotos:(id)sender;
- (IBAction)btnback:(id)sender;
- (IBAction)BtnShare:(id)sender;

@end
