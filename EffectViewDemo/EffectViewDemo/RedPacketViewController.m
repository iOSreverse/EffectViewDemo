//
//  ViewController.m
//  EffectViewDemo
//
//  Created by Arvin on 16/1/14.
//  Copyright © 2016年 Arvin. All rights reserved.
//

#import "RedPacketViewController.h"
#import "UIImageView+LBBlurredImage.h"
#import "Masonry.h"

#define FONT_SIZE 18
#define kWIDTH [UIScreen mainScreen].bounds.size.width
#define RGB(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define Factor_6(A) kWIDTH / 375.0 * (A)



@interface RedPacketViewController ()

@end

@implementation RedPacketViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIImageView *bgImgView = [[UIImageView alloc] init];
    [bgImgView setUserInteractionEnabled:YES];
    [bgImgView setContentMode:UIViewContentModeScaleAspectFill];
    


    // 使用第三方工具类
    [self blurredImage:bgImgView imageNamed:@"huba.jpeg"];
    
    // 头像
    UIImageView *headImgView = [[UIImageView alloc] init];
    [bgImgView addSubview:({
        [headImgView setUserInteractionEnabled:YES];
        [headImgView setImage:[UIImage imageNamed:@"huba.jpeg"]];
        [headImgView setContentMode:UIViewContentModeScaleAspectFill];
        [headImgView.layer setMasksToBounds:YES];
        [headImgView.layer setBorderWidth:6.f];
        [headImgView.layer setBorderColor:RGB(170, 170, 170, 0.5).CGColor];
        [headImgView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                           initWithTarget:self action:@selector(headImgViewClick:)]];
        headImgView;
    })];
    
    [bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    [headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImgView.mas_left).mas_offset(Factor_6(30));
        make.top.equalTo(bgImgView.mas_top).mas_offset(Factor_6(50) + 64);
        make.right.equalTo(bgImgView.mas_right).mas_offset(-Factor_6(30));
        make.height.mas_equalTo(Factor_6(310));
    }];
    
    //关闭
    UIImageView *closeImgView = [[UIImageView alloc] init];
    [bgImgView addSubview:({
        [closeImgView setUserInteractionEnabled:YES];
        [closeImgView setImage:[UIImage imageNamed:@"a_close.png"]];
        [closeImgView setContentMode:UIViewContentModeScaleAspectFill];
        [closeImgView.layer setMasksToBounds:YES];
        [closeImgView.layer setBorderWidth:6.f];
        [closeImgView.layer setBorderColor:RGB(170, 170, 170, 0.5).CGColor];
        [closeImgView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                           initWithTarget:self action:@selector(closeImgViewClick:)]];
        closeImgView;
    })];
    
    [closeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImgView.mas_left).mas_offset(Factor_6(35));
        make.top.equalTo(headImgView.mas_bottom).mas_offset(Factor_6(120));
        make.width.mas_equalTo(Factor_6(150));
        make.height.mas_equalTo(Factor_6(50));
        
    }];
    
    //支付宝
    UIImageView *alipayImgView = [[UIImageView alloc] init];
    [bgImgView addSubview:({
        [alipayImgView setUserInteractionEnabled:YES];
        [alipayImgView setImage:[UIImage imageNamed:@"a_alipay.png"]];
        [alipayImgView setContentMode:UIViewContentModeScaleAspectFill];
        [alipayImgView.layer setMasksToBounds:YES];
        [alipayImgView.layer setBorderWidth:6.f];
        [alipayImgView.layer setBorderColor:RGB(170, 170, 170, 0.5).CGColor];
        [alipayImgView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                           initWithTarget:self action:@selector(alipayImgViewClick:)]];
        alipayImgView;
    })];
    
    [alipayImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgImgView.mas_right).mas_offset(-Factor_6(35));
        make.top.equalTo(headImgView.mas_bottom).mas_offset(Factor_6(120));
        make.width.mas_equalTo(Factor_6(150));
        make.height.mas_equalTo(Factor_6(50));
        
    }];

}




- (void)blurredImage:(UIImageView *)bgImgView imageNamed:(NSString *)name {
    // 对背景图片进行毛玻璃效果处理,参数blurRadius默认是20,可指定,最后一个参数block回调可为nil
    [bgImgView setImageToBlur:[UIImage imageNamed:name] blurRadius:8 completionBlock:nil];
    [self.view addSubview:bgImgView];
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
    
}

-(void)alipayImgViewClick:(UITapGestureRecognizer *)gesture {
    
    NSLog(@"dakai");
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
