//
//  ViewController.m
//  CustomNiMaKeyboard
//
//  Created by 刘隆昌 on 15-3-28.
//  Copyright (c) 2015年 刘隆昌. All rights reserved.
//

#import "ViewController.h"




@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITextField *textField;

@property(nonatomic,strong)KeyboardView * keyboard;

@property(nonatomic,copy)NSMutableString * passWord;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    self.textField.inputAccessoryView = [[KeyboardAccessoryBtn alloc]init];
    self.textField.inputView = self.keyboard;
    self.textField.delegate = self;
    
}



-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    
    //self.textField.text = nil;
    //self.passWord = nil;
    
    CGFloat x = 0;
    CGFloat y = self.view.height - 216;
    CGFloat w = self.view.width;
    CGFloat h = 216;
    self.keyboard = [[KeyboardView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    self.keyboard.delegate = self;
    self.textField.inputView = _keyboard;
    
    return YES;
    
}




-(void)keyboard:(KeyboardView *)keyboard didClickButton:(UIButton *)button{
    
//    if (self.passWord.length > 5) {
//        return;
//    }
    
    [self.passWord appendString:button.currentTitle];
    self.textField.text = self.passWord;
    
}

-(void)keyboard:(KeyboardView *)keyboard didClickDeleteBtn:(UIButton *)deleteBtn{
    
    NSUInteger loc = self.passWord.length;
    if (loc == 0) {
        return;
    }
    
    NSRange range = NSMakeRange(loc-1, 1);
    [self.passWord deleteCharactersInRange:range];
    self.textField.text = self.passWord;
    
}


-(NSMutableString*)passWord{
    if (!_passWord) {
        _passWord = [NSMutableString stringWithCapacity:6];
    }
    return _passWord;
}

-(IBAction)btnAction:(id)sender {
    [self.textField resignFirstResponder];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
