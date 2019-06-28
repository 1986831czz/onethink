//
//  MycreationVC.m
//  DemoPhotoMaker
//
//  Created by Sanjay Kakadiya on 7/29/17.
//  Copyright (c) 2017 Sanay kakadiya. All rights reserved.
//

#import "MycreationVC.h"
#import "AsyncImageView.h"
@interface MycreationVC ()
{
    NSIndexPath *Selectindx;
}

@end

@implementation MycreationVC

- (void)viewDidLoad
{
    [super viewDidLoad];
  //  [APPDELEGATE loadBanner:self];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(CallPhotoDetail) name:@"2page" object:nil];

    _aryPhotodata= [AppDelegate shareApp].arySavefileImgPath;

    collectionMyCreation.dataSource=self;
    collectionMyCreation.delegate=self;
    [collectionMyCreation reloadData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    }

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UICollectionViewDataSource methods
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(IS_IPHONE_4 || IS_IPHONE_5)
    {
        return CGSizeMake(160,160);
    }
    else if(IS_IPHONE_6)
    {
        return CGSizeMake(187,187);
    }
    else
    {
        return CGSizeMake(207,207);
    }
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _aryPhotodata.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    
    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:cell.imgviewCell];
   cell.imgviewCell.image = [UIImage imageNamed:@"Placeholder.png"];
    cell.imgviewCell.imageURL=[NSURL fileURLWithPath:[_aryPhotodata objectAtIndex:indexPath.row]];
    
   // cell.imgviewCell.image=[UIImage imageWithContentsOfFile:[_aryPhotodata objectAtIndex:indexPath.row]];
    [cell.btnCancelCell setTag:indexPath.row];
    [cell.btnCancelCell addTarget:self action:@selector(btnDeleteFolderTapped:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Selectindx=indexPath;
     [self CallPhotoDetail];
//    if ([AppDelegate shareApp].intLoadAd%2==0)
//    {
//        [AppDelegate shareApp].strSelectedPage=@"2";
//        [[AppDelegate shareApp] loadInterstitial];
//    }
//    else
//    {
//        [AppDelegate shareApp].intLoadAd++;
//        [self CallPhotoDetail];
//    }
    
}
-(void)btnDeleteFolderTapped:(UIButton *)sender
{
    [self removeImage:[_aryPhotodata objectAtIndex:sender.tag]];
    [_aryPhotodata removeObjectAtIndex:sender.tag];
    [collectionMyCreation reloadData];
    // handle your stuff here
}
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

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)CallPhotoDetail
{
    MycreationDetailVC *objnewView = [self.storyboard instantiateViewControllerWithIdentifier:@"MycreationDetailVC"];
    objnewView.strImgName=[_aryPhotodata objectAtIndex:Selectindx.row];
    [self.navigationController pushViewController:objnewView animated:YES];

}
@end
