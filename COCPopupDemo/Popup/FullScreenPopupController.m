//
//  FullScreenPopupController.m
//  zhwp
//
//  Created by 杨志勇 on 16/8/16.
//  Copyright © 2016年 zbwx. All rights reserved.
//

#import "FullScreenPopupController.h"

#define SCREEN_WIDTH             [[UIScreen mainScreen]bounds].size.width
#define SCREEN_HEIGHT            [[UIScreen mainScreen]bounds].size.height

@interface FullScreenPopupController ()
@property (nonatomic, strong) FullScreenPopupController *strongSelf;
@property (nonatomic,   weak) UIImageView *bgMaskImgView;
@property (nonatomic,   weak) PopupBaseView *popupView;
@property (nonatomic, strong) UIView *customBoxView;
@property (nonatomic, strong) UIView *containerView;
@end

@implementation FullScreenPopupController

- (instancetype)init {
    self = [super init];
    if (self) {
        _appearAnim = FullScreenPopAppearAnimCenter;
        _blackMaskOpacity = 0.4;
    }
    return self;
}

- (void)showCustomPopupView:(PopupBaseView *)popupView {
    _strongSelf = self;
    _popupView = popupView;
    
    UIView * keyWindow = [UIApplication sharedApplication].keyWindow;
    
    UIView *containerView = [[UIView alloc] initWithFrame: keyWindow.bounds];
    [keyWindow addSubview: containerView];
    self.containerView = containerView;
    containerView.backgroundColor = [UIColor clearColor];
    [containerView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self
                                                                                 action: @selector(bgMaskTapAction)]];
    
    UIImageView *bgMaskImgView = [[UIImageView alloc] initWithFrame: [UIScreen mainScreen].bounds];
    bgMaskImgView.backgroundColor = [UIColor blackColor];
    [containerView addSubview: bgMaskImgView];
    _bgMaskImgView = bgMaskImgView;
    
    CGRect popupViewInitialRect = CGRectZero;
    
    switch (_appearAnim) {
        case FullScreenPopAppearAnimCenter: {
            popupViewInitialRect = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - popupView.frame.size.width / 2,
                                              [UIScreen mainScreen].bounds.size.height / 2 - popupView.frame.size.height / 2 - 20,
                                        
                                              popupView.frame.size.width,
                                              popupView.frame.size.height);
        }
            
            break;
            
        case FullScreenPopAppearAnimFromTop: {
            popupViewInitialRect = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - popupView.frame.size.width / 2,
                                              - popupView.frame.size.height,
                                              popupView.frame.size.width,
                                              popupView.frame.size.height);
        }
            
            break;
            
        case FullScreenPopAppearAnimFromBottom: {
            popupViewInitialRect = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - popupView.frame.size.width / 2,
                                              SCREEN_HEIGHT + popupView.frame.size.height,
                                              popupView.frame.size.width,
                                              popupView.frame.size.height);
        }
            break;
            
        case FullScreenPopAppearAnimCustom: {
            popupViewInitialRect = CGRectMake(0,
                                              - popupView.frame.size.height,
                                              popupView.frame.size.width,
                                              popupView.frame.size.height);
        }
            break;
    }

    if (FullScreenPopAppearAnimCustom == _appearAnim) {
        [keyWindow addSubview: self.customBoxView];
        [self.customBoxView addSubview: _popupView];
        
    } else {
        [keyWindow addSubview: popupView];
    }
    
    popupView.frame = popupViewInitialRect;
    
    /// 初始化动画
    [self initialAnim];
    
    [self showAnim];
}

- (void)initialAnim {
    
    switch (_appearAnim) {
        case FullScreenPopAppearAnimCenter: {
            _popupView.alpha = 0;
            _bgMaskImgView.alpha = 0;
        }
            break;
            
        case FullScreenPopAppearAnimFromBottom: {
            _bgMaskImgView.alpha = 0;
        }
            break;
            
        case FullScreenPopAppearAnimFromTop: {
            _bgMaskImgView.alpha = 0;
        }
            break;
            
        case FullScreenPopAppearAnimCustom: {
            _bgMaskImgView.alpha = 0;
        }
            break;
    }
}

- (void)showAnim {
    [UIView animateWithDuration: 0.3 animations:^{
        
        switch (_appearAnim) {
            case FullScreenPopAppearAnimCenter: {
                _bgMaskImgView.alpha = self.blackMaskOpacity;
                _popupView.alpha = 1;
            }
                break;
                
            case FullScreenPopAppearAnimFromBottom: {
                _bgMaskImgView.alpha = self.blackMaskOpacity;
                _popupView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - _popupView.frame.size.width / 2,
                                              [UIScreen mainScreen].bounds.size.height - _popupView.frame.size.height,
                                              
                                              _popupView.frame.size.width,
                                              
                                              _popupView.frame.size.height);
            }
                break;
                
            case FullScreenPopAppearAnimFromTop: {
                _bgMaskImgView.alpha = self.blackMaskOpacity;
                _popupView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - _popupView.frame.size.width / 2,
                                              0,
                                              
                                              _popupView.frame.size.width,
                                              
                                              _popupView.frame.size.height);
            }
                break;
                
            case FullScreenPopAppearAnimCustom: {
                _bgMaskImgView.alpha = self.blackMaskOpacity;
                _popupView.frame = CGRectMake(0, 0, _popupView.frame.size.width, _popupView.frame.size.height);
            }
                break;
        }
    }];
}

- (void)dismissAnim {
    [UIView animateWithDuration: 0.3 animations:^{
        
        switch (_appearAnim) {
            case FullScreenPopAppearAnimCenter: {
                _bgMaskImgView.alpha = 0;
                _popupView.alpha = 0;
            }
                
                break;
                
            case FullScreenPopAppearAnimFromTop: {
                _bgMaskImgView.alpha = 0;

                _popupView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - _popupView.frame.size.width / 2,
                                              - _popupView.frame.size.height,
                                              _popupView.frame.size.width,
                                              _popupView.frame.size.height);
            }
                
                break;
                
            case FullScreenPopAppearAnimFromBottom: {
                _bgMaskImgView.alpha = 0;
                _popupView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - _popupView.frame.size.width / 2,
                                              SCREEN_HEIGHT + _popupView.frame.size.height,
                                              _popupView.frame.size.width,
                                              _popupView.frame.size.height);
            }
                break;
                
            case FullScreenPopAppearAnimCustom: {
                _bgMaskImgView.alpha = 0;
                _popupView.frame = CGRectMake(0,
                                              - _popupView.frame.size.height,
                                              _popupView.frame.size.width,
                                              _popupView.frame.size.height);

            }
                break;
        }
    }completion:^(BOOL finished) {
        
        [self deinit];
        
        if (self.didDismissBlock) {
            self.didDismissBlock();
        }
    }];
}


- (void)bgMaskTapAction {
    [self dismissCustomPopupView];
}

- (void)dismissCustomPopupView {
    
    [self dismissAnim];
}

- (void)deinit {
    [_popupView removeFromSuperview];
    [_bgMaskImgView removeFromSuperview];
    [_containerView removeFromSuperview];
    [_customBoxView removeFromSuperview];
    _strongSelf = nil;
}

#pragma mark ==========   getter   ==========
- (UIView *)customBoxView {
    if (!_customBoxView) {
        _customBoxView = [[UIView alloc] initWithFrame: self.popupView.frame];
        _customBoxView.clipsToBounds = YES;
    }
    return _customBoxView;
}

@end










