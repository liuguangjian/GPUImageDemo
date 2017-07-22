//
//  LJImageFilterTool.h
//  leJiaMeiTuXiu
//
//  Created by 乐家 on 16/7/26.
//  Copyright © 2016年 zengqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LJImageFilterTool : NSObject
/*
 说明:图片滤镜处理工具类
 */
+ (instancetype)shareInstance;
/**
 *  传入一张图片和明暗度的到一张调节了对比度的图片
 *
 *  @param image      传入的图片
 *  @param birghtness 传入的明暗度
 *
 *  @return 返回新的图片
 */
- (UIImage *)brightnessImage:(UIImage *)image brightness:(CGFloat) birghtness;
/**
 *  传入一张图片和对比度的到一张调节了对比度的图片
 *
 *  @param image         传入图片
 *  @param contrastValue 传入的对比度
 *
 *  @return 新图片
 */
- (UIImage *)contrastImage:(UIImage *)image contrast:(CGFloat)contrastValue;
/**
 *  传入一张图片和饱和度得到一张调节了饱和度的图片
 *
 *  @param image           传入的图片
 *  @param saturationValue 传入的饱和度
 *
 *  @return 返回的新图片
 */
- (UIImage *)saturationImage:(UIImage *)image saturationValue:(CGFloat)saturationValue;
/**
 *  传入一张图片和锐化度的到一张调节了锐化度的图片
 *
 *  @param image           传入图片
 *  @param saturationValue 传入的锐化度
 *
 *  @return 返回的新图片
 */
- (UIImage *)sharpenImage:(UIImage *)image sharpenValue:(CGFloat)sharpenValue;
// 黑白
- (UIImage *)averageLuminanceThresholdFilterImage:(UIImage *)image thresholdMultiplierValue:(CGFloat)thresholdMultiplier;
// 素描
- (UIImage *)sketchFilterImage:(UIImage *)image;
// 浮雕效果
- (UIImage *)embossFilter:(UIImage *)image;
@end
