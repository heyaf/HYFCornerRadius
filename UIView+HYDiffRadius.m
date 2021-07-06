//
//  UIView+HYDiffRadius.m
//  FindMe
//
//  Created by mac on 2021/6/2.
//

#import "UIView+HYDiffRadius.h"
#import "CYAnyCornerRadiusUtil.h"

#import <objc/runtime.h>
static char *topleftValueKey = "topleftValueRadiusKey";
static char *toprightValueKey = "toprightValueRadiusKey";
static char *bottomleftValueKey = "bottomleftValueRadiusKey";
static char *bottomrightValueKey = "bottomrightValueRadiusKey";

static char *borderColorStrKey = "borderColorStrKey";
static char *borderWidthStrKey = "borderWidthStrKey";

@implementation UIView (HYDiffRadius)

- (void)setBorderWidthValue:(CGFloat)borderWidthValue{
    objc_setAssociatedObject(self, borderWidthStrKey, @(borderWidthValue), OBJC_ASSOCIATION_COPY_NONATOMIC);

}
-(CGFloat)borderWidthValue{
    return [objc_getAssociatedObject(self, borderWidthStrKey) floatValue];;
}
- (void)setBorderWidthStr:(CGFloat)borderWidthStr{
    objc_setAssociatedObject(self, borderWidthStrKey, @(borderWidthStr), OBJC_ASSOCIATION_COPY_NONATOMIC);

}
-(CGFloat)borderWidthStr{
    return [objc_getAssociatedObject(self, borderWidthStrKey) floatValue];

}
-(void)setTopleftValue:(CGFloat)topleftValue{
    objc_setAssociatedObject(self, topleftValueKey, @(topleftValue), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (CGFloat)topleftValue{
    return [objc_getAssociatedObject(self, topleftValueKey) floatValue];

}
-(void)setToprightValue:(CGFloat)toprightValue{
    objc_setAssociatedObject(self, toprightValueKey, @(toprightValue), OBJC_ASSOCIATION_COPY_NONATOMIC);

}
-(CGFloat)toprightValue{
    return [objc_getAssociatedObject(self, toprightValueKey) floatValue];

}
-(void)setBottomleftValue:(CGFloat)bottomleftValue{
    objc_setAssociatedObject(self, bottomleftValueKey, @(bottomleftValue), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(CGFloat)bottomleftValue{
    return [objc_getAssociatedObject(self, bottomleftValueKey) floatValue];

}
-(void)setBottomrightValue:(CGFloat)bottomrightValue{
    objc_setAssociatedObject(self, bottomrightValueKey, @(bottomrightValue), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(CGFloat)bottomrightValue{
    return [objc_getAssociatedObject(self, bottomrightValueKey) floatValue];

}

- (void)setBorderColorStr:(NSString *)borderColorStr{
    objc_setAssociatedObject(self, borderColorStrKey, borderColorStr, OBJC_ASSOCIATION_COPY_NONATOMIC);

}
- (NSString *)borderColorStr{
    return objc_getAssociatedObject(self, borderColorStrKey);
}
-(void)drawMyRect{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
   CornerRadii cornerRadii = CornerRadiiMake(self.topleftValue, self.toprightValue, self.bottomleftValue, self.bottomrightValue);
    CGPathRef path = CYPathCreateWithRoundedRect(self.bounds,cornerRadii);
    shapeLayer.path = path;
    CGPathRelease(path);
    self.layer.mask = shapeLayer;
    
    //An opaque type that represents a Quartz 2D drawing environment.
    //一个不透明类型的Quartz 2D绘画环境,相当于一个画布,你可以在上面任意绘画
    CGContextRef context = UIGraphicsGetCurrentContext();
    //画线
//    [self drawLineWithContent:context];
    [self drawGradientLineWithContent:context];
}

-(UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}
-(void)drawLineWithContent:(CGContextRef)context{
     //画线
     const CGFloat minX = CGRectGetMinX(self.bounds);
     const CGFloat minY = CGRectGetMinY(self.bounds);
     const CGFloat maxX = CGRectGetMaxX(self.bounds);
     const CGFloat maxY = CGRectGetMaxY(self.bounds);
     
     
     
     const CGFloat topLeftCenterX = minX +  self.borderWidthValue;
     const CGFloat topLeftCenterY = minY + self.borderWidthValue;
     
     const CGFloat topRightCenterX = maxX - self.borderWidthValue;
     const CGFloat topRightCenterY = minY + self.borderWidthValue;
     
     const CGFloat bottomLeftCenterX = minX +  self.borderWidthValue;
     const CGFloat bottomLeftCenterY = maxY - self.borderWidthValue;
     
     const CGFloat bottomRightCenterX = maxX -  self.borderWidthValue;
     const CGFloat bottomRightCenterY = maxY - self.borderWidthValue;
     
     CGFloat lineW = self.borderWidthValue;
     CGFloat topSpaceY = (self.borderWidthValue + lineW)/2;
     CGFloat rightSpaceX = (self.borderWidthValue + lineW)/2;
     CGFloat bottomSpaceY = (self.borderWidthValue + lineW)/2;
     CGFloat leftSpaceX = (self.borderWidthValue + lineW)/2;
     
     self.topleftValue -=  topSpaceY;
     self.toprightValue -=  rightSpaceX;
     self.bottomleftValue -=  bottomSpaceY;
     self.bottomrightValue -=  leftSpaceX;
     

    UIColor *borderColor = [UIColor redColor];
     //黄色
     //1.0 顶左 画圆弧
     drawLineArc(context, borderColor.CGColor, lineW, CGPointMake(topLeftCenterX, topLeftCenterY), self.topleftValue, M_PI, 3 * M_PI_2, NO);
     //2.0 顶部划线
     drawLine(context, borderColor.CGColor, lineW, CGPointMake(topLeftCenterX, topSpaceY), CGPointMake(topRightCenterX, topSpaceY));
     //3.0 顶右 画圆弧
     drawLineArc(context, borderColor.CGColor, lineW, CGPointMake(topRightCenterX, topRightCenterY), self.toprightValue, 3 * M_PI_2, 0, NO);
     //4.0 右部划线
     drawLine(context, borderColor.CGColor, lineW, CGPointMake(maxX - rightSpaceX, topRightCenterY), CGPointMake(maxX - rightSpaceX, bottomRightCenterY));
     //5.0 底右 画圆弧
     drawLineArc(context, borderColor.CGColor, lineW, CGPointMake(bottomRightCenterX, bottomRightCenterY), self.bottomrightValue, 0, M_PI_2, NO);
     //6.0 底部划线
     drawLine(context, borderColor.CGColor, lineW, CGPointMake(bottomRightCenterX, maxY - bottomSpaceY), CGPointMake(bottomLeftCenterX, maxY - bottomSpaceY));

     //7.0 底左 画圆弧
     drawLineArc(context, borderColor.CGColor, lineW, CGPointMake(bottomLeftCenterX, bottomLeftCenterY), self.bottomleftValue, M_PI_2, M_PI, NO);

     //8.0 左边划线
     drawLine(context, borderColor.CGColor, lineW, CGPointMake(minX + leftSpaceX, bottomLeftCenterY), CGPointMake(minX + leftSpaceX, topLeftCenterY));
     
}

//画渐变线
-(void)drawGradientLineWithContent:(CGContextRef)context{


     //画线
     const CGFloat minX = CGRectGetMinX(self.bounds);
     const CGFloat minY = CGRectGetMinY(self.bounds);
     const CGFloat maxX = CGRectGetMaxX(self.bounds);
     const CGFloat maxY = CGRectGetMaxY(self.bounds);
    //20
    const CGFloat topLeftCenterX = minX +  self.topleftValue;
    const CGFloat topLeftCenterY = minY + self.topleftValue;
    
    //40 10
    const CGFloat topRightCenterX = maxX - self.toprightValue;
    const CGFloat topRightCenterY = minY + self.toprightValue;
    //5 45
    const CGFloat bottomLeftCenterX = minX +  self.bottomleftValue;
    const CGFloat bottomLeftCenterY = maxY - self.bottomleftValue;
    //45 45
    const CGFloat bottomRightCenterX = maxX -  self.bottomrightValue;
    const CGFloat bottomRightCenterY = maxY - self.bottomrightValue;

     //渐变色数组
     CGFloat colors[] =
     {
          245/255.0,213/255.0,79/255.0, 1.00,
          231/255.0,108/255.0,0, 1.00,
     };
    NSLog(@"----%f",self.borderWidthValue);
     //黄色
    UIColor *  color = [UIColor colorWithRed:245/255.0 green:213/255.0 blue:79/255.0 alpha:1.0];     //1.0 顶左 画圆弧
     drawLineArc(context, color.CGColor, self.borderWidthValue, CGPointMake(topLeftCenterX, topLeftCenterY), self.topleftValue, M_PI, 3 * M_PI_2, NO);
     //2.0 顶部划线
     drawLine(context, color.CGColor, self.borderWidthValue, CGPointMake(topLeftCenterX, 0), CGPointMake(topRightCenterX, 0));
     //3.0 顶右 画圆弧
     drawLineArc(context, color.CGColor, self.borderWidthValue, CGPointMake(topRightCenterX, topRightCenterY), self.toprightValue, 3 * M_PI_2, 0, NO);
     //4.0 右部划线
     drawLinearGradient(context, colors,sizeof(colors)/(sizeof(colors[0])), self.borderWidthValue ,CGPointMake(maxX, topRightCenterY), CGPointMake(maxX, bottomRightCenterY),kCGGradientDrawsAfterEndLocation);

     color = [UIColor colorWithRed:231/255.0 green:108/255.0 blue:0 alpha:1.0];
     //5.0 底右 画圆弧
     drawLineArc(context, color.CGColor, self.borderWidthValue, CGPointMake(bottomRightCenterX, bottomRightCenterY), self.bottomrightValue, 0, M_PI_2, NO);
     //6.0 底部划线
     drawLine(context, color.CGColor, self.borderWidthValue, CGPointMake(bottomRightCenterX, maxY), CGPointMake(bottomLeftCenterX, maxY));

     //7.0 底左 画圆弧
     drawLineArc(context, color.CGColor, self.borderWidthValue, CGPointMake(bottomLeftCenterX, bottomLeftCenterY), self.bottomleftValue, M_PI_2, M_PI, NO);

     //8.0 左边划线
     CGFloat colors1[] = {
          231/255.0,108/255.0,0, 1.00,
          245/255.0,213/255.0,79/255.0, 1.00,
     };
     drawLinearGradient(context, colors1,sizeof(colors1)/(sizeof(colors1[0])),self.borderWidthValue,CGPointMake(minX, bottomLeftCenterY), CGPointMake(minX, topLeftCenterY),kCGGradientDrawsAfterEndLocation);

}
@end
