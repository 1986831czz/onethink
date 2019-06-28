//
//  CLImageEditor.m
//
//  Created by sho yakushiji on 2013/10/17.
//  Copyright (c) 2013年 CALACULU. All rights reserved.
//

#import "CLImageEditor.h"

#import "_CLImageEditorViewController.h"

@interface CLImageEditor ()
@end


@implementation CLImageEditor

-(void)viewDidLoad
{
//    [self showSuperSonicIntertitial];
}

- (id)init
{
    return [_CLImageEditorViewController new];
}

- (id)initWithImage:(UIImage*)image
{
    return [self initWithImage:image delegate:nil];
}

- (id)initWithImage:(UIImage*)image delegate:(id<CLImageEditorDelegate>)delegate
{
    return [[_CLImageEditorViewController alloc] initWithImage:image delegate:delegate];
}

- (id)initWithDelegate:(id<CLImageEditorDelegate>)delegate
{
    return [[_CLImageEditorViewController alloc] initWithDelegate:delegate];
}

- (void)showInViewController:(UIViewController*)controller withImageView:(UIImageView*)imageView;
{
    
}
- (CLImageEditorTheme*)theme
{
    return [CLImageEditorTheme theme];
}

/*
#pragma mark -
#pragma mark Super Sonic Advertise
#pragma mark -
-(void)showSuperSonicIntertitial
{
    [[Supersonic sharedInstance] setISDelegate:self];
    [[Supersonic sharedInstance] initISWithAppKey:@"4c3934ed" withUserId:[[[UIDevice currentDevice] identifierForVendor]UUIDString]];
    [[Supersonic sharedInstance] loadIS];
}
-(void)supersonicISInitSuccess
{
     // * Called when initiation process of the Interstitial products has finished successfully.
    NSLog(@"supersonicISInitSuccess");
    [[Supersonic sharedInstance] isInterstitialAvailable];
}

-(void)supersonicISInitFailedWithError:(NSError *)error
{
    // * Called each time an initiation stage fails, or if you have a problem in
    // * the integration
    // * You can learn about the reason by examining the 'error' value
     
    NSLog(@"supersonicISInitFailedWithError %@",error);
    
}
-(void) supersonicISReady
{
    
    // Invoked when Interstitial Ad is ready to be shown after load function was called.
     
    
    NSLog(@"supersonicISReady");
    [[Supersonic sharedInstance] showISWithViewController:self];
}
-(void)supersonicISShowSuccess
{
     // * Called each time the Interstitial window has opened successfully.
     
    
    NSLog(@"supersonicISShowSuccess");
}
-(void)supersonicISShowFailWithError:(NSError *)error
{
    
    // * Called if showing the Interstitial for the user has failed.
    // * You can learn about the reason by examining the ‘error’ value
     
    
    NSLog(@"supersonicISShowFailWithError");
}
-(void)supersonicISAdClicked
{
    // Called each time the end user has clicked on the Interstitial ad.
     
    NSLog(@"supersonicISAdClicked");
    
}
-(void)supersonicISAdClosed
{
    // Called each time the Interstitial window is about to close
     
    
    NSLog(@"supersonicISAdClosed");
}
-(void)supersonicISAdOpened
{
    
    // Called each time the Interstitial window is about to open
    
    NSLog(@"supersonicISAdOpened");
    
}
-(void)supersonicISFailed
{
    
    // Invoked when there is no Interstitial Ad available after calling load function.
     
    NSLog(@"supersonicISFailed");
}
*/
@end

