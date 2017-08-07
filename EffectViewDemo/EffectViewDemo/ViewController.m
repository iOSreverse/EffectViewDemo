//
//  ViewController.m
//  EffectViewDemo
//
//  Created by Arvin on 16/1/14.
//  Copyright © 2016年 Arvin. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Extension.h"
#import "UIImageView+LBBlurredImage.h"

#define FONT_SIZE 18
#define kWIDTH [UIScreen mainScreen].bounds.size.width
#define RGB(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

static NSString *const TestBURL = @"alipay://";

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIImageView *bgImgView = [[UIImageView alloc] init];
    [bgImgView setFrame:self.view.bounds];
    [bgImgView setUserInteractionEnabled:YES];
    [bgImgView setContentMode:UIViewContentModeScaleAspectFill];

    // 使用第三方工具类
    [self blurredImage:bgImgView];
    
    // 头像
    UIImageView *headImgView = [[UIImageView alloc] init];
    [bgImgView addSubview:({
        [headImgView setUserInteractionEnabled:YES];
        [headImgView setFrame:(CGRect){bgImgView.centerX-(kWIDTH/1.28)/2, bgImgView.centerY-(kWIDTH/1.28)*0.8, kWIDTH/1.28, (kWIDTH/1.28)*1.18}];
        [headImgView setImage:[UIImage imageNamed:@"huba.jpeg"]];
        [headImgView setContentMode:UIViewContentModeScaleAspectFill];
//        [headImgView.layer setCornerRadius:CGRectGetHeight(headImgView.frame)*0.5];
        [headImgView.layer setMasksToBounds:YES];
        [headImgView.layer setBorderWidth:6.f];
        [headImgView.layer setBorderColor:RGB(170, 170, 170, 0.5).CGColor];
        [headImgView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                           initWithTarget:self action:@selector(headImgViewClick:)]];
        headImgView;
    })];
    
    //关闭
    UIImageView *closeImgView = [[UIImageView alloc] init];
    [bgImgView addSubview:({
        [closeImgView setUserInteractionEnabled:YES];
        [closeImgView setFrame:(CGRect){headImgView.x-35, headImgView.y+headImgView.frame.size.height+120, bgImgView.size.width/2-10, 50}];
        [closeImgView setImage:[UIImage imageNamed:@"a_close.png"]];
        [closeImgView setContentMode:UIViewContentModeScaleAspectFill];
        //        [headImgView.layer setCornerRadius:CGRectGetHeight(headImgView.frame)*0.5];
        [closeImgView.layer setMasksToBounds:YES];
        [closeImgView.layer setBorderWidth:6.f];
        [closeImgView.layer setBorderColor:RGB(170, 170, 170, 0.5).CGColor];
        [closeImgView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                           initWithTarget:self action:@selector(closeImgViewClick:)]];
        closeImgView;
    })];
    
    //支付宝
    UIImageView *alipayImgView = [[UIImageView alloc] init];
    [bgImgView addSubview:({
        [alipayImgView setUserInteractionEnabled:YES];
        [alipayImgView setFrame:(CGRect){closeImgView.x+closeImgView.size.width+5, headImgView.y+headImgView.frame.size.height+120, bgImgView.size.width/2-10, 50}];
        [alipayImgView setImage:[UIImage imageNamed:@"a_alipay.png"]];
        [alipayImgView setContentMode:UIViewContentModeScaleAspectFill];
        //        [headImgView.layer setCornerRadius:CGRectGetHeight(headImgView.frame)*0.5];
        [alipayImgView.layer setMasksToBounds:YES];
        [alipayImgView.layer setBorderWidth:6.f];
        [alipayImgView.layer setBorderColor:RGB(170, 170, 170, 0.5).CGColor];
        [alipayImgView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                           initWithTarget:self action:@selector(alipayImgViewClick:)]];
        alipayImgView;
    })];
    
}




- (void)blurredImage:(UIImageView *)bgImgView {
    // 方法1,没有blurRadius参数,因为默认是20
    //[bgImgView setImageToBlur:[UIImage imageNamed:@"huoying4.jpg"] completionBlock:nil];
    
    // 方法2,对背景图片进行毛玻璃效果处理,参数blurRadius默认是20,可指定,最后一个参数block回调可为nil
    [bgImgView setImageToBlur:[UIImage imageNamed:@"huba.jpeg"] blurRadius:8 completionBlock:nil];
    [self.view addSubview:bgImgView];
    
//    CGRect frame = CGRectMake(0, bgImgView.h-80, kWIDTH, 30);
//    [bgImgView addSubview:[self labelWithFrame:frame text:@"LBBlurredImage"]];
}


- (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:FONT_SIZE];
    return label;
}


- (void)headImgViewClick:(UITapGestureRecognizer *)gesture {
    NSLog(@"%@->你点我干啥?",gesture);
}

-(void)closeImgViewClick:(UITapGestureRecognizer *)gesture {
    NSLog(@"%@->close",gesture);
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL  URLWithString:@"mqq://"]]){
        NSLog(@"install--");
    }else{
        NSLog(@"no---");
    }
    
   
}

-(void)alipayImgViewClick:(UITapGestureRecognizer *)gesture {
    
    NSURL *url = [NSURL URLWithString:@"alipay://"];
    BOOL result = [[UIApplication sharedApplication] canOpenURL:url];
    
    if (result) {
        
        [[UIApplication sharedApplication] openURL:url];
        
    }else{
        NSString *openUrl = @"itms-apps ://itunes.apple.com/cn/app/id333206289";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl]];
    }
 
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
