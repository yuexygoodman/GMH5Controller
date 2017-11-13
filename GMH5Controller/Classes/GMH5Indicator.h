//
//  GMH5Indicator.h
//  GIM
//
//  Created by 岳潇洋 on 2017/10/12.
//  Copyright © 2017年 Gome. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol GMH5Indicator <NSObject>

- (void)startAnimating;

- (void)stopAnimating;

@end

//UIActivityIndicatorView
@interface UIActivityIndicatorView (GMH5Indicator)<GMH5Indicator>

@end

@interface GMH5LoadingIndicator : UIView<GMH5Indicator>

@property(strong,nonatomic) UIImage * image;

@property(assign,nonatomic) NSTimeInterval rate;

- (void)startAnimating;

- (void)stopAnimating;

- (id)initWithImage:(UIImage *)image rate:(NSTimeInterval)rate;

@end



