//
//  AlertView.m
//  COCPopupDemo
//
//  Created by YZY on 2019/2/22.
//  Copyright © 2019 Cocfish. All rights reserved.
//

#import "AlertView.h"

@implementation AlertView

+ (instancetype)loadView {
    return [[NSBundle mainBundle] loadNibNamed: @"AlertView"
                                         owner: nil
                                       options: nil].firstObject;
}

- (IBAction)exitBtnAction:(id)sender {
    self.exitHandler();
}


@end
