//
//  KeyboardView.m
//  CustomNiMaKeyboard
//
//  Created by 刘隆昌 on 15-3-28.
//  Copyright (c) 2015年 刘隆昌. All rights reserved.
//

#import "KeyboardView.h"


#define KeyboardCols 3
#define KeyboardTextFont 20



@interface KeyboardView ()

/**
*删除按钮
*/
@property(nonatomic,weak)UIButton* deleteBtn;

/**
 *符号按钮
 */
@property(nonatomic,weak)UIButton* symbolBtn;

/**
*ABC 文字按钮
*/

@property(nonatomic,weak)UIButton * textBtn;


@end


@implementation KeyboardView



-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
     
        UIImage * image = [UIImage imageNamed:@"keyboardBtn"];
        image = [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
        
        
        UIImage * highImage = [UIImage imageNamed:@"keyboardBtnSel"];
        highImage = [highImage stretchableImageWithLeftCapWidth:highImage.size.width*0.5 topCapHeight:highImage.size.height*0.5];
        
        [self setupTopButtonWithImage:image highImage:highImage];
        [self setupBottomButtonsWithImage:highImage highImage:image];
        
    }
    return self;
}

-(void)setupTopButtonWithImage:(UIImage*)image highImage:(UIImage*)highImage{
    
    NSMutableArray * arrM = [NSMutableArray array];
    [arrM removeAllObjects];
    
    
    for (int i=0; i<10; i++) {
       // int j = arc4random_uniform(10);
        NSNumber * number = [[NSNumber alloc]initWithInt:i];
//        if ([arrM containsObject:number]) {
//            i--;
//            continue;
//        }
        [arrM addObject:number];
    }
    
    
    for (int i=0; i<10; i++) {
        
        UIButton * numBtn = [[UIButton alloc] init];
        NSNumber * number = arrM[i];
        NSString * title = number.stringValue;
        [numBtn setTitle:title forState:UIControlStateNormal];
        
        [numBtn setBackgroundImage:image forState:UIControlStateNormal];
        [numBtn setBackgroundImage:highImage forState:UIControlStateHighlighted];
        numBtn.titleLabel.font = [UIFont boldSystemFontOfSize:KeyboardTextFont];
        
        [numBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [numBtn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:numBtn];
        
    }
    
    
}

-(void)numBtnClick:(UIButton*)numBtn{
    
    if ([self.delegate respondsToSelector:@selector(keyboard:didClickButton:)]) {
        [self.delegate keyboard:self didClickButton:numBtn];
    }
    
}



-(void)setupBottomButtonsWithImage:(UIImage*)image highImage:(UIImage*)highImage{
    
    self.symbolBtn = [self setupBottomButtonWithTitle:@"return" image:image];
   // self.textBtn = [self setupBottomButtonWithTitle:@"ABC" image:image];
    
    
    //删除按钮
    self.deleteBtn = [self setupBottomButtonWithTitle:nil image:nil];
    [self.deleteBtn setBackgroundImage:[UIImage imageNamed:@"numKeyboardDelBtn"] forState:UIControlStateNormal];
    [self.deleteBtn setBackgroundImage:[UIImage imageNamed:@"numKeyboardDelBtnSel"] forState:UIControlStateHighlighted];
    
    
    self.deleteBtn.contentMode = UIViewContentModeCenter;
    [self.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)deleteBtnClick:(UIButton*)deleteBtn{
    
    if ([self.delegate respondsToSelector:@selector(keyboard:didClickDeleteBtn:)]) {
        [self.delegate keyboard:self didClickDeleteBtn:deleteBtn];
    }
    
}

-(UIButton*)setupBottomButtonWithTitle:(NSString*)title image:(UIImage*)image{
    
    UIButton * bottomBtn = [[UIButton alloc]init];
    if (title) {
        [bottomBtn setTitle:title forState:UIControlStateNormal];
        //bottomBtn.titleLabel.font = [UIFont boldSystemFontOfSize:KeyboardTextFont];
        bottomBtn.titleLabel.font = [UIFont systemFontOfSize:KeyboardTextFont];
        [bottomBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    if (image) {
        UIImage * highImage = [UIImage imageNamed:@"keyboardBtn"];
        highImage = [highImage stretchableImageWithLeftCapWidth:highImage.size.width*0.5 topCapHeight:highImage.size.height*0.5];
        
        [bottomBtn setBackgroundImage:image forState:UIControlStateNormal];
        [bottomBtn setBackgroundImage:highImage forState:UIControlStateHighlighted];
        bottomBtn.userInteractionEnabled = YES;
    }
    
    if (!self.symbolBtn) {
        [bottomBtn addTarget:self action:@selector(returnBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self addSubview:bottomBtn];
    return bottomBtn;
}


-(void)returnBtnClick{
    [self.nextResponder resignFirstResponder];
}




-(void)layoutSubviews{
    
    CGFloat topMargin = 17;
    CGFloat bottomMargin = 3;
    CGFloat leftMargin =3;
    CGFloat colMargin = 5;
    CGFloat rowMargin =3;
    
    CGFloat topBtnW = (self.width - 2*leftMargin - 2*colMargin)/3;
    CGFloat topBtnH = (self.height - topMargin-bottomMargin-3*rowMargin)/4;
    NSUInteger count = self.subviews.count;
    
    
    for (NSUInteger i = 0; i<count; i++) {
        
        if (i==0) {
            UIButton * buttonZero = self.subviews[i];
            buttonZero.height = topBtnH;
            buttonZero.width = topBtnW;
            buttonZero.centerX = self.centerX;
            buttonZero.centerY = self.height - bottomMargin - buttonZero.height*0.5;
            
            
            //符号 文字 及 删除按钮的位置
            self.deleteBtn.x = CGRectGetMaxX(buttonZero.frame)+colMargin;
            self.deleteBtn.y = buttonZero.y;
            self.deleteBtn.width = buttonZero.width;
            self.deleteBtn.height = buttonZero.height;
            
            
            self.symbolBtn.x = leftMargin;
            self.symbolBtn.y = buttonZero.y;
            self.symbolBtn.width = buttonZero.width/1 ;// - colMargin/2;
            self.symbolBtn.height = buttonZero.height;
//          self.textBtn.x = CGRectGetMaxX(self.symbolBtn.frame)+colMargin;
//          self.textBtn.y = buttonZero.y;
//          
//          self.textBtn.width = self.symbolBtn.width;
//          self.textBtn.height = self.symbolBtn.height;
            
            
        }
        
        
        
        if (i>0 && i<10) {
            
            UIButton * topButton = self.subviews[i];
            CGFloat row = (i-1)/3;
            CGFloat col = (i-1)%3;
            
            topButton.x = leftMargin + col * (topBtnW + colMargin);
            topButton.y = topMargin+row*(topBtnH+rowMargin);
            topButton.width = topBtnW;
            topButton.height = topBtnH;
            
        }
        
    }
    
    
}


@end
