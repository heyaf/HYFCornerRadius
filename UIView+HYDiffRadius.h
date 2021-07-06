//
//  UIView+HYDiffRadius.h
//  FindMe
//
//  Created by mac on 2021/6/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (HYDiffRadius)
//圆角
@property (nonatomic,assign) CGFloat topleftValue;
@property (nonatomic,assign) CGFloat toprightValue;
@property (nonatomic,assign) CGFloat bottomleftValue;
@property (nonatomic,assign) CGFloat bottomrightValue;
/*border*/

/// 16进制颜色
@property (nonatomic,strong) NSString *borderColorStr;
@property (nonatomic,assign) CGFloat borderWidthValue;

-(void)drawMyRect;

                
        


@end

NS_ASSUME_NONNULL_END
