//
//  ViewController.m
//  COCPopupDemo
//
//  Created by YZY on 2019/2/22.
//  Copyright © 2019 Cocfish. All rights reserved.
//

#import "ViewController.h"
#import "FullScreenPopupController.h"
#import "AlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    AlertView *alerView = [AlertView loadView];
    alerView.autoScrollToAppearKeyboardEnable = YES; // 是否自动滚动防止键盘遮挡
    
    FullScreenPopupController *controller = [[FullScreenPopupController alloc] init];
    controller.appearAnim = FullScreenPopAppearAnimFromBottom; // 动画出现方式
    [controller showCustomPopupView: alerView];
    
    alerView.exitHandler = ^{
        [controller dismissCustomPopupView];
    };
}


@end
