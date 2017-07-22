//
//  ViewController.m
//  GPUImageDemo
//
//  Created by 乐家 on 2017/7/22.
//  Copyright © 2017年 lejiakeji. All rights reserved.
//

#import "ViewController.h"
#import "LJImageFilterTool.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** 图片工具 */
@property (nonatomic, strong) LJImageFilterTool *imageTool;
@property (weak, nonatomic) IBOutlet UISlider *brightnessProgress;
@property (weak, nonatomic) IBOutlet UISlider *contrastProgress;
@property (weak, nonatomic) IBOutlet UISlider *saturationProgress;
@property (weak, nonatomic) IBOutlet UISlider *sharpenProgress;
@end

@implementation ViewController
// 黑白
- (IBAction)blackAndWhiteBtn:(id)sender {
    self.brightnessProgress.value = 0.5;
    self.contrastProgress.value = 0.5;
    self.saturationProgress.value = 0.5;
    self.sharpenProgress.value = 0.5;
    UIImage *image = [UIImage imageNamed:@"W020170411297099143877"];
    image = [self.imageTool averageLuminanceThresholdFilterImage:image thresholdMultiplierValue:1.0];
    self.imageView.image = image;
}
// 素描
- (IBAction)SketchBtn:(id)sender {
    self.brightnessProgress.value = 0.5;
    self.contrastProgress.value = 0.5;
    self.saturationProgress.value = 0.5;
    self.sharpenProgress.value = 0.5;
    UIImage *image = [UIImage imageNamed:@"W020170411297099143877"];
    image = [self.imageTool sketchFilterImage:image];
    self.imageView.image = image;
}
// 浮雕
- (IBAction)ReliefBtn:(id)sender {
    self.brightnessProgress.value = 0.5;
    self.contrastProgress.value = 0.5;
    self.saturationProgress.value = 0.5;
    self.sharpenProgress.value = 0.5;
    UIImage *image = [UIImage imageNamed:@"W020170411297099143877"];
    image = [self.imageTool embossFilter:image];
    self.imageView.image = image;
}
- (IBAction)originBtn:(id)sender {
    self.brightnessProgress.value = 0.5;
    self.contrastProgress.value = 0.5;
    self.saturationProgress.value = 0.5;
    self.sharpenProgress.value = 0.5;
    self.imageView.image = [UIImage imageNamed:@"W020170411297099143877"];
}
- (IBAction)brightnessSlider:(UISlider *)sender {
    self.contrastProgress.value = 0.5;
    self.saturationProgress.value = 0.5;
    self.sharpenProgress.value = 0.5;
    UIImage *image = [UIImage imageNamed:@"W020170411297099143877"];
    image = [self.imageTool brightnessImage:image brightness:(2*sender.value - 1)];
    self.imageView.image = image;
}
- (IBAction)contrastSlider:(UISlider *)sender {
    self.brightnessProgress.value = 0.5;
    self.saturationProgress.value = 0.5;
    self.sharpenProgress.value = 0.5;
    UIImage *image = [UIImage imageNamed:@"W020170411297099143877"];
    image = [self.imageTool contrastImage:image contrast:4 * sender.value * sender.value];
    self.imageView.image = image;
}
- (IBAction)saturationSlider:(UISlider *)sender {
    self.brightnessProgress.value = 0.5;
    self.contrastProgress.value = 0.5;
    self.sharpenProgress.value = 0.5;
    UIImage *image = [UIImage imageNamed:@"W020170411297099143877"];
    image = [self.imageTool saturationImage:image saturationValue:2 * sender.value];
    self.imageView.image = image;
}
- (IBAction)sharpenSlider:(UISlider *)sender {
    self.brightnessProgress.value = 0.5;
    self.contrastProgress.value = 0.5;
    self.saturationProgress.value = 0.5;
    UIImage *image = [UIImage imageNamed:@"W020170411297099143877"];
    image = [self.imageTool sharpenImage:image sharpenValue:4 * (2 * sender.value - 1)];
    self.imageView.image = image;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageTool = [LJImageFilterTool shareInstance];
    self.brightnessProgress.maximumValue = 1.0;
    self.brightnessProgress.minimumValue = 0.0;
    self.contrastProgress.maximumValue = 1.0;
    self.contrastProgress.minimumValue = 0.0;
    self.saturationProgress.maximumValue = 1.0;
    self.saturationProgress.minimumValue = 0.0;
    self.sharpenProgress.maximumValue = 1.0;
    self.sharpenProgress.minimumValue = 0.0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
