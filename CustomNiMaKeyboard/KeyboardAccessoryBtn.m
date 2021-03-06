//
//  KeyboardAccessoryBtn.m
//  CustomNiMaKeyboard
//
//  Created by 刘隆昌 on 15-3-28.
//  Copyright (c) 2015年 刘隆昌. All rights reserved.
//

#import "KeyboardAccessoryBtn.h"
#import "UIView+Extension.h"

@interface KeyboardAccessoryBtn ()

@property(nonatomic,weak)UIView * line;

@end


@implementation KeyboardAccessoryBtn



-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,5);
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.adjustsImageWhenHighlighted = NO;
        UIView * line = [[UIView alloc]init];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
        
        self.line = line;
        
        NSString * doneBtnTitle = @"";
        [self setTitle:doneBtnTitle forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        UIImage * image = [UIImage imageNamed:@"hidden"];
        [self setImage:image forState:UIControlStateNormal];
        [self addTarget:self action:@selector(accessoryBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

-(void)accessoryBtnDidClick{
    
    [self.nextResponder resignFirstResponder];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.line.frame = CGRectMake(0, 0, self.width, 1);
    
    CGFloat titleX = 10;
    CGFloat titleY = 0;
    CGFloat titleW = self.width*0.8;
    CGFloat titleH = self.height;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat imageX = CGRectGetMaxX(self.titleLabel.frame)+5;
    CGFloat imageY = titleY;
    CGFloat imageW = self.width*0.2 - 15;
    CGFloat imageH = titleH;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
}


@end
