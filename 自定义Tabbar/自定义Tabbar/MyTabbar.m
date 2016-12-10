//
//  MyTabbar.m
//  自定义Tabbar
//
//  Created by 梦想 on 2016/12/9.
//  Copyright © 2016年 zhai. All rights reserved.
//

#import "MyTabbar.h"

@interface MyTabbar ()

//已经选择的按钮
@property (nonatomic, strong) UIButton *selectBtn;
//正常的按钮
@property (nonatomic, strong) NSMutableArray *normalBtns;
//present的按钮
@property (nonatomic, strong) NSMutableArray *presentBtns;

@end

@implementation MyTabbar

- (void)setTabbarVC:(UITabBarController *)tabbarVC{
    _tabbarVC = tabbarVC;
    NSUInteger count = tabbarVC.viewControllers.count + self.specialVCs.count;
    CGRect frame = tabbarVC.view.frame;
    
    CGFloat btnW = frame.size.width / count;
    CGFloat btnH = tabbarVC.tabBar.frame.size.height;
    
    self.frame = tabbarVC.tabBar.bounds;
    [tabbarVC.tabBar addSubview:self];
#pragma mark----没有present控制器
    if (!self.specialVCs) {
        for (int i = 0; i < count; i++) {
            CGFloat btnX = btnW * i;
            CGFloat btnY = 0;
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
            btn.tag = i;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255) / 255.0 green:arc4random_uniform(255) / 255.0 blue:arc4random_uniform(255) / 255.0 alpha:1];
            [self addSubview:btn];
            if (i == 0) {
                btn.selected = YES;
                self.selectBtn = btn;
            }
            btn.imageView.frame = CGRectMake(0, 0, 40, 40);
            btn.imageView.center = btn.center;
            [self.normalBtns addObject:btn];
        }
        return;
    }
#pragma mark----有present控制器
    unsigned long int specialIndex = (tabbarVC.viewControllers.count + 1) / 2;
    NSLog(@"specialIndex   %ld    count   %ld", specialIndex, count);
    for (int i = 0; i < count; i++) {
        CGFloat btnX = btnW * i;
        CGFloat btnY = 0;
    #pragma mark----正常的控制器index
        if (i < specialIndex || i > specialIndex + self.specialVCs.count - 1) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255) / 255.0 green:arc4random_uniform(255) / 255.0 blue:arc4random_uniform(255) / 255.0 alpha:1];
            [self addSubview:btn];
            if (i < specialIndex) {
                btn.tag = i;
            }else{
                btn.tag = i - self.specialVCs.count;
            }
            if (i == 0) {
                btn.selected = YES;
                self.selectBtn = btn;
            }
            [self.normalBtns addObject:btn];
        #pragma mark----present控制器的index
        }else{
            NSLog(@" i  %d    specialIndex   %ld", i, specialIndex);
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
            btn.tag = i - specialIndex + 100;
            [btn addTarget:self action:@selector(specialBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255) / 255.0 green:arc4random_uniform(255) / 255.0 blue:arc4random_uniform(255) / 255.0 alpha:1];
            [self addSubview:btn];
            if (i == 0) {
                btn.selected = YES;
                self.selectBtn = btn;
            }
            [self.presentBtns addObject:btn];
        }
    }
    
}
//正常按钮
- (void)btnClick:(UIButton *)btn{
    NSLog(@"%ld", btn.tag);
    NSLog(@"+++++");
    
    self.selectBtn.selected = NO;
    btn.selected = YES;
    self.selectBtn = btn;
    self.tabbarVC.selectedIndex = btn.tag;
}
//present按钮
- (void)specialBtnClick:(UIButton *)btn{
    NSLog(@"-------");
    NSLog(@"%ld", btn.tag);
    UIViewController *VC = self.specialVCs[btn.tag - 100];
    [self.tabbarVC presentViewController:VC animated:YES completion:nil];
}

- (void)setNormalImages:(NSArray *)normalImages{
    _normalImages = normalImages;
    [self.normalBtns enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL * _Nonnull stop) {
        [btn setImage:[UIImage imageNamed:normalImages[idx]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:normalImages[idx]] forState:UIControlStateHighlighted];
    }];
}

- (void)setSelectedImages:(NSArray<NSString *> *)selectedImages{
    _selectedImages = selectedImages;
    [self.normalBtns enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL * _Nonnull stop) {
        [btn setImage:[UIImage imageNamed:selectedImages[idx]] forState:UIControlStateSelected];
    }];
}

- (void)setPresentImages:(NSArray<NSString *> *)presentImages{
    _presentImages = presentImages;
    NSLog(@"%@", _presentImages);
    [self.presentBtns enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL * _Nonnull stop) {
        [btn setImage:[UIImage imageNamed:presentImages[idx]] forState:UIControlStateNormal];
    }];
}

- (NSMutableArray *)normalBtns{
    if (!_normalBtns) {
        _normalBtns = [NSMutableArray array];
    }
    return _normalBtns;
}

- (NSMutableArray *)presentBtns{
    if (!_presentBtns) {
        _presentBtns = [NSMutableArray array];
    }
    return _presentBtns;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
