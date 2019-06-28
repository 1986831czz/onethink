//
//  ViewController.h
//  DemoPhotoMaker
//
//  Created by Sanjay Kakadiya on 7/19/17.
//  Copyright (c) 2017 Sanay kakadiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoEditerView.h"
#import "MycreationVC.h"
@interface ViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    
    IBOutlet UIButton *btncamera;
    IBOutlet UIButton *btnGallery;
    IBOutlet UIButton *btnmyCreation;
}
- (IBAction)btnchoosePhoto:(id)sender;
- (IBAction)btntakePhoto:(id)sender;
- (IBAction)btnmyCreation:(id)sender;
@end

