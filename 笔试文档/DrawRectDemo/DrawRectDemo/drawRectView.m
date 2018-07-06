

//
//  drawRectView.m
//  DrawRectDemo
//
//  Created by 叮咚钱包富银 on 2018/7/6.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "drawRectView.h"

@implementation drawRectView

// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self drawLine];

    [self drawText];

    [self drawRectangle:rect];
    
    [self drawImage];
}

- (void)drawLine {
    CGContextRef context = UIGraphicsGetCurrentContext(); //获取上下文
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);//线条颜色
    CGContextSetShouldAntialias(context, NO); //设置线条是否为抗锯齿 NO为平滑
    CGContextSetLineWidth(context, 5); //设置线条宽度
    CGContextMoveToPoint(context, 100, 100); //设置线条的起点
    CGContextAddLineToPoint(context, 200, 100); //设置线条的终点，画直线到该点
    CGContextStrokePath(context); //开始绘制
}

- (void)drawText {
    UIColor *color = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    [color set];
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
    NSString *name = @"哈哈哈哈";
    [name drawAtPoint:CGPointMake(100, 150) withFont:font];
}

- (void)drawRectangle:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext(); //获取上下文
    
    CGRect size = CGRectMake(100, 200, 100, 100);
    //设置矩形填充颜色：红色 必须在填充矩形前执行
    CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);
    //填充矩形
    CGContextFillRect(context, size);
    //设置画笔颜色：蓝色
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    //设置画笔线条粗细
    CGContextSetLineWidth(context, 3.0);
    //画矩形边框
    CGContextAddRect(context,size);
    //执行绘画
    CGContextStrokePath(context);
}

- (void)drawImage {
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 保存初始状态
    CGContextSaveGState(context);
    // 图形上下文移动{x,y}
    CGContextTranslateCTM(context, 50.0, 30.0);
    // 图形上下文缩放{x,y}
    CGContextScaleCTM(context, 0.8, 0.8);
    
    UIImage *image = [UIImage imageNamed:@"bg_card2"];

    [image drawInRect:CGRectMake(100, 350, 200, 100)];
    
    //恢复到初始状态
    CGContextRestoreGState(context);
}
@end
