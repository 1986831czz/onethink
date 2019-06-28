//
//  MycreationDetailVC.h
//  DemoPhotoMaker
//
//  Created by Sanjay Kakadiya on 7/29/17.
//  Copyright (c) 2017 Sanay kakadiya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MycreationDetailVC : UIViewController
{
    __weak IBOutlet UIImageView *imgview;
    
}
@property (nonatomic,retain)NSString *strImgName;
- (IBAction)btndelete:(id)sender;
- (IBAction)btnBack:(id)sender;
- (IBAction)BtnShare:(id)sender;
@end
