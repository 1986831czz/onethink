//
//  MycreationDetailVC.m
//  DemoPhotoMaker
//
//  Created by Sanjay Kakadiya on 7/29/17.
//  Copyright (c) 2017 Sanay kakadiya. All rights reserved.
//

#import "MycreationDetailVC.h"

@interface MycreationDetailVC ()

@end

@implementation MycreationDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
  //  [APPDELEGATE loadBanner:self];
    // Do any additional setup after loading the view.
    imgview.image=[UIImage imageWithContentsOfFile:_strImgName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)removeImage:(NSString *)filepath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL success = [fileManager removeItemAtPath:filepath error:&error];
    if (success) {
//        UIAlertView *removedSuccessFullyAlert = [[UIAlertView alloc] initWithTitle:@"Congratulations:" message:@"Successfully removed" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
//        [removedSuccessFullyAlert show];
    }
    else
    {
        NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
    }
}

- (IBAction)btndelete:(id)sender
{
    [self removeImage:_strImgName];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)BtnShare:(id)sender
{
    NSMutableArray *activityItems= [NSMutableArray arrayWithObjects: imgview.image, nil];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityViewController.excludedActivityTypes = @[UIActivityTypePostToWeibo,UIActivityTypePrint,                                                         UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,                                                         UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,                                                         UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,                                                         UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop];
    [self presentViewController:activityViewController animated:YES completion:nil];
}
@end
