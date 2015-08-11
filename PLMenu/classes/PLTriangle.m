//
//  PLTriangle.m
//  PLMenu
//
//  Created by Philip Lee on 15/8/10.
//  Copyright (c) 2015年 Philip Lee. All rights reserved.
//

#import "PLTriangle.h"

@implementation PLTriangle

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)init
{
    if (self = [super init]) {
        [self initializer];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initializer];
    }
    
    return self;
}

-(void) initializer
{
    _triangleColor = [UIColor whiteColor];
    _angleToTop = 0; // 默认向上
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [[UIColor clearColor] set];
    UIRectFill([self bounds]);
    
    //拿到当前视图准备好的画板
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //利用path进行绘制三角形
    CGContextBeginPath(context);//标记
    CGContextMoveToPoint(context, rect.size.width/2, rect.size.height/8);//设置起点
    CGContextAddLineToPoint(context, 0, rect.size.height);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    
    [_triangleColor setFill]; //设置填充色
    [_triangleColor setStroke]; //设置边框颜色
    CGContextDrawPath(context, kCGPathFillStroke);//绘制路径path
}

@end
