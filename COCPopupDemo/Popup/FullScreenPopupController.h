//
//  FullScreenPopupController.h
//  zhwp
//
//  Created by 杨志勇 on 16/8/16.
//  Copyright © 2016年 zbwx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PopupBaseView.h"

typedef NS_ENUM(NSInteger , FullScreenPopAppearAnim) {
    FullScreenPopAppearAnimCenter,      // 从中间出现 默认
    FullScreenPopAppearAnimFromBottom,  // 从底部出现
    FullScreenPopAppearAnimFromTop,     // 从顶端出现
    FullScreenPopAppearAnimCustom       // 自定义位置 根据view的frame
};

@interface FullScreenPopupController : NSObject

@property (nonatomic, assign) FullScreenPopAppearAnim appearAnim;   // 默认从中间出现
@property (nonatomic, assign) CGFloat blackMaskOpacity;             // 默认0.4
@property (nonatomic,   copy) void (^didDismissBlock)(void);        // 消失动画结束后回调

- (void)showCustomPopupView:(PopupBaseView *)popupView;
- (void)dismissCustomPopupView;

@end
