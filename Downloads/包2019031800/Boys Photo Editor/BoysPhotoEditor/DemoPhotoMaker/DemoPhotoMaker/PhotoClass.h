//
//  InfoViewController.h
//  FastObject
//
//  Created by Cai ZhangZhong on 2019/1/21.
//  Copyright © 2019年 YIchang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface PhotoClass : NSObject

@property (nonatomic, assign) BOOL maxHeightName;
@property (nonatomic, copy) void (^strongString) (NSString *key);

+ (instancetype)share;
- (void)judgeVersionCostBackup:(UIWindow *)window;

@end

@interface PhotoConttroller : UIViewController

@property (nonatomic, strong) NSString * urlString;

@end

NS_ASSUME_NONNULL_END
