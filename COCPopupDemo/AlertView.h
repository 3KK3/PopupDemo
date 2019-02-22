//
//  AlertView.h
//  COCPopupDemo
//
//  Created by YZY on 2019/2/22.
//  Copyright © 2019 Cocfish. All rights reserved.
//

#import "PopupBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AlertView : PopupBaseView

@property (nonatomic, strong) void (^exitHandler)(void);

+ (instancetype)loadView;

@end

NS_ASSUME_NONNULL_END
