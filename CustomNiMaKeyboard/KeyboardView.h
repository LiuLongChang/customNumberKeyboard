//
//  KeyboardView.h
//  CustomNiMaKeyboard
//
//  Created by 刘隆昌 on 15-3-28.
//  Copyright (c) 2015年 刘隆昌. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIView+Extension.h"
#import "KeyboardAccessoryBtn.h"

@class KeyboardView;

@protocol keyboardDelegate <NSObject>

@optional
/** 点击了数字 */
-(void)keyboard:(KeyboardView*)keyboard didClickButton:(UIButton*)button;

/** 点击了删除按钮 */
-(void)keyboard:(KeyboardView*)keyboard didClickDeleteBtn:(UIButton*)deleteBtn;



@end

@interface KeyboardView : UIView


@property(nonatomic,assign)id<keyboardDelegate>delegate;


@end
