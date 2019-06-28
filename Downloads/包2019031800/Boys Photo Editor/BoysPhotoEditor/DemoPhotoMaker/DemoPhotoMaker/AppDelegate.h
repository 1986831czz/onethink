//
//  AppDelegate.h
//  DemoPhotoMaker
//
//  Created by Sanjay Kakadiya on 7/19/17.
//  Copyright (c) 2017 Sanay kakadiya. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic , retain) NSString *strPassName;
@property(nonatomic,retain) NSMutableArray *arySavefileImgPath;

+(AppDelegate *)shareApp;


@end

