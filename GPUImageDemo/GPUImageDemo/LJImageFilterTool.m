//
//  LJImageFilterTool.m
//  leJiaMeiTuXiu
//
//  Created by 乐家 on 16/7/26.
//  Copyright © 2016年 zengqiang. All rights reserved.
//
#import "LJImageFilterTool.h"
#import <GPUImage.h>
#import "GPUImageCropFilter.h"
#import "GPUImageEmbossFilter.h"
@interface LJImageFilterTool()
@property (nonatomic, strong) GPUImageBrightnessFilter *brightnessFilter;
@property (nonatomic, strong) GPUImageContrastFilter *contrastFilter;
@property (nonatomic, strong) GPUImageSaturationFilter *saturationFilter;
@property (nonatomic, strong) GPUImageSharpenFilter *sharpenFilter;
@property (nonatomic, strong) GPUImagePicture *stillImageSource;
@property (nonatomic, strong)  GPUImageAverageLuminanceThresholdFilter *averageLuminanceThresholdFilter;
@property (nonatomic, strong) GPUImageSketchFilter *sketchFilter;
@property (nonatomic, strong) GPUImageEmbossFilter *embossFilter;
@end
@implementation LJImageFilterTool

+ (instancetype)shareInstance {
    
    static LJImageFilterTool *filterTool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        filterTool = [[self alloc] init];

    });
    return filterTool;
}
- (GPUImagePicture *)stillImageSource {
    if (_stillImageSource == nil) {
        _stillImageSource = [[GPUImagePicture alloc] init];
    }
    return _stillImageSource;
}

- (GPUImageBrightnessFilter *)brightnessFilter {
    if (_brightnessFilter == nil) {
        _brightnessFilter = [[GPUImageBrightnessFilter alloc] init];
    }
    return _brightnessFilter;
}

- (GPUImageContrastFilter *)contrastFilter {
    if (_contrastFilter == nil) {
        _contrastFilter = [[GPUImageContrastFilter alloc] init];
    }
    return _contrastFilter;
}

- (GPUImageSaturationFilter *)saturationFilter {
    if (_saturationFilter == nil) {
        _saturationFilter = [[GPUImageSaturationFilter alloc] init];
    }
    return _saturationFilter;
}

- (GPUImageSharpenFilter *)sharpenFilter {
    if (_sharpenFilter == nil) {
        _sharpenFilter = [[GPUImageSharpenFilter alloc] init];
    }
    return _sharpenFilter;
}

- (GPUImageAverageLuminanceThresholdFilter *)averageLuminanceThresholdFilter {
    if (_averageLuminanceThresholdFilter == nil) {
        _averageLuminanceThresholdFilter = [[GPUImageAverageLuminanceThresholdFilter alloc] init];
    }
    return _averageLuminanceThresholdFilter;
}

- (GPUImageSketchFilter *)sketchFilter {
    if (_sketchFilter == nil) {
        _sketchFilter = [[GPUImageSketchFilter alloc] init];
    }
    return _sketchFilter;
}

- (GPUImageEmbossFilter *)embossFilter {
    if (_embossFilter == nil) {
        _embossFilter = [[GPUImageEmbossFilter alloc] init];
    }
    return _embossFilter;
}
/**
 *  传入一张图片和明暗度的到一张调节了对比度的图片
 *
 *  @param image      传入的图片
 *  @param birghtness 出入的明暗度
 *
 *  @return 返回新的图片
 */
- (UIImage *)brightnessImage:(UIImage *)image brightness:(CGFloat) birghtness {
    [self.brightnessFilter forceProcessingAtSize:image.size];
    self.brightnessFilter.brightness = birghtness;
    [self.brightnessFilter useNextFrameForImageCapture];
    self.stillImageSource = [[GPUImagePicture alloc] initWithImage:image];
    [self.stillImageSource addTarget:self.brightnessFilter];
    [self.stillImageSource processImageWithCompletionHandler:^{
        [self.stillImageSource removeAllTargets];
    }];
    UIImage *newImage = [self.brightnessFilter imageFromCurrentFramebuffer];
    return newImage;
}
/**
 *  传入一张图片和对比度的到一张调节了对比度的图片
 *
 *  @param image         传入图片
 *  @param contrastValue 对比度
 *
 *  @return 新图片
 */
- (UIImage *)contrastImage:(UIImage *)image contrast:(CGFloat)contrastValue {
    [self.contrastFilter forceProcessingAtSize:image.size];
    self.contrastFilter.contrast = contrastValue;
    [self.contrastFilter useNextFrameForImageCapture];
    self.stillImageSource = [[GPUImagePicture alloc] initWithImage:image];
    [self.stillImageSource addTarget:self.contrastFilter];
    [self.stillImageSource processImageWithCompletionHandler:^{
        [self.stillImageSource removeAllTargets];
    }];
    UIImage *newImage = [self.contrastFilter imageFromCurrentFramebuffer];
    return newImage;
}
/**
 *  传入一张图片和饱和度得到一张调节了饱和度的图片
 *
 *  @param image           传入的图片
 *  @param saturationValue 传入的饱和度
 *
 *  @return 返回的新图片
 */
- (UIImage *)saturationImage:(UIImage *)image saturationValue:(CGFloat)saturationValue {
    [self.saturationFilter forceProcessingAtSize:image.size];
    self.saturationFilter.saturation = saturationValue;
    [self.saturationFilter useNextFrameForImageCapture];
    self.stillImageSource = [[GPUImagePicture alloc] initWithImage:image];
    [self.stillImageSource addTarget:self.saturationFilter];
    [self.stillImageSource processImageWithCompletionHandler:^{
        [self.stillImageSource removeAllTargets];
    }];
    UIImage *newImage = [self.saturationFilter imageFromCurrentFramebuffer];
    return newImage;
}
/**
 *  传入一张图片和锐化度的到一张调节了锐化度的图片
 *
 *  @param image           传入图片
 *  @param saturationValue 传入的锐化度
 *
 *  @return 返回的新图片
 */
- (UIImage *)sharpenImage:(UIImage *)image sharpenValue:(CGFloat)sharpenValue {
    [self.sharpenFilter forceProcessingAtSize:image.size];
    self.sharpenFilter.sharpness = sharpenValue;
    [self.sharpenFilter useNextFrameForImageCapture];
    self.stillImageSource = [[GPUImagePicture alloc] initWithImage:image];
    [self.stillImageSource addTarget:self.sharpenFilter];
    [self.stillImageSource processImageWithCompletionHandler:^{
        [self.stillImageSource removeAllTargets];
    }];
    UIImage *newImage = [self.sharpenFilter imageFromCurrentFramebuffer];
    return newImage;
}
/**
 *  黑白特效
 *
 *  @param image
 *  @param thresholdMultiplier
 *
 *  @return
 */
- (UIImage *)averageLuminanceThresholdFilterImage:(UIImage *)image thresholdMultiplierValue:(CGFloat)thresholdMultiplier {
    self.averageLuminanceThresholdFilter.thresholdMultiplier = thresholdMultiplier;
    [self.averageLuminanceThresholdFilter useNextFrameForImageCapture];
    self.stillImageSource = [[GPUImagePicture alloc] initWithImage:image];
    [self.stillImageSource addTarget:self.averageLuminanceThresholdFilter];
    [self.stillImageSource processImageWithCompletionHandler:^{
        [self.stillImageSource removeAllTargets];
    }];
    UIImage *newImage = [self.averageLuminanceThresholdFilter imageFromCurrentFramebuffer];
    return newImage;
}

/**
 *  素描特效
 */
- (UIImage *)sketchFilterImage:(UIImage *)image {
    [self.sketchFilter useNextFrameForImageCapture];
    self.stillImageSource = [[GPUImagePicture alloc] initWithImage:image];
    [self.stillImageSource addTarget:self.sketchFilter];
    [self.stillImageSource processImageWithCompletionHandler:^{
        [self.stillImageSource removeAllTargets];
    }];
    UIImage *newImage = [self.sketchFilter imageFromCurrentFramebuffer];
    return newImage;
}

- (UIImage *)embossFilter:(UIImage *)image {
    [self.embossFilter useNextFrameForImageCapture];
    self.stillImageSource = [[GPUImagePicture alloc] initWithImage:image];
    [self.stillImageSource addTarget:self.embossFilter];
    [self.stillImageSource processImageWithCompletionHandler:^{
        [self.stillImageSource removeAllTargets];
    }];
    UIImage *newImage = [self.embossFilter imageFromCurrentFramebuffer];
    return newImage;
}
@end
