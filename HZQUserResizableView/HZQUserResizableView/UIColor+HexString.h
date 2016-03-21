//
//  UIColor+HexString.h
//  HealthManagement
//
//  Created by luoqiang on 15/4/24.
//  Copyright (c) 2015年 guotion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexString)
/**
 *  十六进制的颜色转换为UIColor
 *
 *  @param color   十六进制的颜色
 *
 *  @return   UIColor
 */
+ (UIColor *)colorwithHexString:(NSString *)color;

@end
