//
//  AppDelegate.m
//  DemoPhotoMaker
//
//  Created by Sanjay Kakadiya on 7/19/17.
//  Copyright (c) 2017 Sanay kakadiya. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
   

    [self isUpdateAvailable];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
+(AppDelegate *)shareApp
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
#pragma mark - update app
-(void) isUpdateAvailable
{
    NSDictionary* infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString* appID = infoDictionary[@"CFBundleIdentifier"];
    NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?bundleId=%@",appID];
    
    NSMutableURLRequest *request11 = [[NSMutableURLRequest alloc] init];
    [request11 setURL:[NSURL URLWithString:urlString]];
    [request11 setHTTPMethod:@"GET"];
    [request11 setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLResponse *response;
    NSError *error;
    NSData *data = [NSURLConnection  sendSynchronousRequest:request11 returningResponse: &response error: &error];
    NSError *e = nil;
    
    if (data)
    {
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error: &e];
        
        
        if( [[jsonDict objectForKey:@"results"] count]>0)
        {
            NSString *strVersion = [[[jsonDict objectForKey:@"results"] objectAtIndex:0] objectForKey:@"version"];
            
            NSString *strCurrentVersion =infoDictionary[@"CFBundleShortVersionString"];
            
            
            if([strVersion floatValue]>[strCurrentVersion floatValue])
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Info" message:@"New version available from App Store" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Update", nil];
                
                [alert show];
            }
            else
            {
                
            }
            
        }
    }
    
}
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        NSString *iTunesLink = ITUNES_UPDATE_URL;
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
    }
    
}
@end
