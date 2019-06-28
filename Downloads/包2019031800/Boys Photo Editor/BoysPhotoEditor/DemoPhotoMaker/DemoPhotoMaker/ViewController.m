//
//  ViewController.m
//  DemoPhotoMaker
//
//  Created by Sanjay Kakadiya on 7/19/17.
//  Copyright (c) 2017 Sanay kakadiya. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    btncamera.titleLabel.textAlignment = NSTextAlignmentCenter; // if you want to
    btnGallery.titleLabel.textAlignment = NSTextAlignmentCenter; // if you want to
    btnmyCreation.titleLabel.textAlignment = NSTextAlignmentCenter; // if you want to

    
    btncamera.layer.cornerRadius = 8.0f;
    btncamera.layer.masksToBounds = NO;
    btncamera.layer.shadowColor = [UIColor colorWithRed:165.0/255.0 green:237.0/255.0 blue:174.0/255.0 alpha:1.0].CGColor;
    btncamera.layer.shadowOpacity = 0.5;
    btncamera.layer.shadowRadius = 5;
    btncamera.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);
    
    
    btnGallery.layer.cornerRadius = 8.0f;
    btnGallery.layer.masksToBounds = NO;
    btnGallery.layer.shadowColor = [UIColor colorWithRed:215.0/255.0 green:160.0/255.0 blue:103.0/255.0 alpha:1.0].CGColor;
    btnGallery.layer.shadowOpacity = 0.5;
    btnGallery.layer.shadowRadius = 5;
    btnGallery.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);
    
    btnmyCreation.layer.cornerRadius = 8.0f;
    btnmyCreation.layer.masksToBounds = NO;
    btnmyCreation.layer.shadowColor = [UIColor colorWithRed:168.0/255.0 green:182.0/255.0 blue:243.0/255.0 alpha:1.0].CGColor;
    btnmyCreation.layer.shadowOpacity = 0.5;
    btnmyCreation.layer.shadowRadius = 5;
    btnmyCreation.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(CallMyCreation) name:@"1page" object:nil];
   // [AppDelegate shareApp].loadViewInterstitial=self;
   // [APPDELEGATE loadBanner:self];


}
-(void)viewWillAppear:(BOOL)animated
{
    [AppDelegate shareApp].strPassName=@"";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsPath error:nil];
    [AppDelegate shareApp].arySavefileImgPath=[[NSMutableArray alloc]init];
    
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]; // NEW LINE 1
    
    for (NSString *filename in dirContents)
    {
        NSString *fileExt = [filename pathExtension];
        if ([fileExt isEqualToString:@"png"])
        {
            NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:filename]; // NEW LINE 2
            [[AppDelegate shareApp].arySavefileImgPath addObject:fullPath]; // NEW LINE 3
        }
    }
    NSLog(@"document folder content list %@ ",[AppDelegate shareApp].arySavefileImgPath);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)selectPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}
-(void)TakePhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    PhotoEditerView *objnewView = [self.storyboard instantiateViewControllerWithIdentifier:@"PhotoEditerView"];
    objnewView.imgGet=chosenImage;
    [self.navigationController pushViewController:objnewView animated:YES];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (IBAction)btnchoosePhoto:(id)sender
{
    [self selectPhoto];
}

- (IBAction)btntakePhoto:(id)sender
{
    [self TakePhoto];
}

- (IBAction)btnmyCreation:(id)sender
{
     [self CallMyCreation];
    
//    if ([AppDelegate shareApp].intLoadAd%2==0)
//    {
//        [AppDelegate shareApp].strSelectedPage=@"1";
//        [[AppDelegate shareApp] loadInterstitial];
//    }
//    else
//    {
//        [AppDelegate shareApp].intLoadAd++;
//        [self CallMyCreation];
//    }

}
-(void)CallMyCreation
{
    MycreationVC *objnewView = [self.storyboard instantiateViewControllerWithIdentifier:@"MycreationVC"];
    objnewView.aryPhotodata=[AppDelegate shareApp].arySavefileImgPath;
    [self.navigationController pushViewController:objnewView animated:YES];
}
@end
