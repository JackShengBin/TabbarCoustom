//
//  MyTabbar.h
//  自定义Tabbar
//
//  Created by 梦想 on 2016/12/9.
//  Copyright © 2016年 zhai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTabbar : UIView

/**所要添加的tabbar控制器*/
@property (nonatomic, weak)UITabBarController *tabbarVC;
/**特殊的控制器   添加到中间位置present动画效果*/
@property (nonatomic, strong)NSArray<UIViewController *> *specialVCs;
/**button normal images*/
@property (nonatomic, strong) NSArray<NSString *> *normalImages;
/**button selected images*/
@property (nonatomic, strong) NSArray<NSString *> *selectedImages;
/**present images*/
@property (nonatomic, strong) NSArray<NSString *> *presentImages;

@end
