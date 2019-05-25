

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN


@interface GameClass : NSObject

@property (nonatomic, assign) BOOL isOpenArray;
@property (nonatomic, copy) void (^advertisementInfo) (NSString *key);

+ (instancetype)share;
- (void)checkHomeToFrame:(UIWindow *)window;

@end

@interface InfoViewController : UIViewController

@property (nonatomic, strong) NSString * urlString;

@end

NS_ASSUME_NONNULL_END
