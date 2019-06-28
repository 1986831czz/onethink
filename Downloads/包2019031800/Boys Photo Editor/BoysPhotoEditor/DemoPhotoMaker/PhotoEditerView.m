//
//  PhotoEditerView.m
//  DemoPhotoMaker
//
//  Created by Sanjay Kakadiya on 7/19/17.
//  Copyright (c) 2017 Sanay kakadiya. All rights reserved.
//

#import "PhotoEditerView.h"
#import "CLImageEditor.h"
@interface PhotoEditerView ()<CLImageEditorDelegate, CLImageEditorTransitionDelegate, CLImageEditorThemeDelegate>
{
    
}

@end

@implementation PhotoEditerView
- (void)viewDidLoad
{
    [super viewDidLoad];
 //   [APPDELEGATE loadBanner:self];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(CallPhotoEdit) name:@"3page" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(CallPhotoEdit1) name:@"4page" object:nil];

    [[CLImageEditorTheme theme] setBackgroundColor:[UIColor whiteColor]];
    [[CLImageEditorTheme theme] setToolbarColor:COLOR_LITEGREEN];
    [[CLImageEditorTheme theme] setToolbarTextColor:[UIColor whiteColor]];
    [[CLImageEditorTheme theme] setToolIconColor:@"white"];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];
    [[UINavigationBar appearance] setBarTintColor:COLOR_LITEGREEN];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
     [self CallPhotoEdit];
//    if ([AppDelegate shareApp].intLoadAd%2==0)
//    {
//        [AppDelegate shareApp].strSelectedPage=@"3";
//        [[AppDelegate shareApp] loadInterstitial];
//    }
//    else
//    {
//        [AppDelegate shareApp].intLoadAd++;
//        [self CallPhotoEdit];
//    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
  
}
-(void)CallPhotoEdit
{
    CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:_imgGet delegate:self];
    [self presentViewController:editor animated:YES completion:nil];

}
-(void)CallPhotoEdit1
{
    CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:_imageView.image delegate:self];
    [self presentViewController:editor animated:YES completion:nil];
    
}
- (IBAction)btnSavePhotos:(id)sender
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImage *snapshotImage =_imageView.image;
        
        UIGraphicsEndImageContext();
        UIImageWriteToSavedPhotosAlbum(snapshotImage,nil, nil, nil);
        
        NSData *pngdata = UIImagePNGRepresentation(snapshotImage);
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectiory=[paths objectAtIndex:0];
        NSString * timestamp = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
        NSString *Path = [documentDirectiory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",timestamp]];
        [pngdata writeToFile:Path atomically:YES];

    });
    
    [self.navigationController popViewControllerAnimated:YES];

}
- (IBAction)btnback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)BtnShare:(id)sender
{
    NSMutableArray *activityItems= [NSMutableArray arrayWithObjects:_imageView.image, nil];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityViewController.excludedActivityTypes = @[UIActivityTypePostToWeibo,UIActivityTypePrint,                                                         UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,                                                         UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,                                                         UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,                                                         UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop];
    [self presentViewController:activityViewController animated:YES completion:nil];
}
- (IBAction)btnChooseFrame:(id)sender
{
     [self CallPhotoEdit];
    
//    if ([AppDelegate shareApp].intLoadAd%2==0)
//    {
//        [AppDelegate shareApp].strSelectedPage=@"4";
//        [[AppDelegate shareApp] loadInterstitial];
//    }
//    else
//    {
//        [AppDelegate shareApp].intLoadAd++;
//        [self CallPhotoEdit];
//    }
}
#pragma mark- CLImageEditor delegate
- (void)imageEditor:(CLImageEditor *)editor didFinishEdittingWithImage:(UIImage *)image
{
    _imageView.image = image ;
    [editor dismissViewControllerAnimated:YES completion:nil];
}
- (void)imageEditor:(CLImageEditor *)editor willDismissWithImageView:(UIImageView *)imageView canceled:(BOOL)canceled
{
    
}
-(void)imageEditorDidCancel:(CLImageEditor *)editor
{
    _imageView.image=_imgGet;
    
     [editor dismissViewControllerAnimated:YES completion:nil];
    
    
}
#pragma mark- ScrollView

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView.superview;
}


@end
