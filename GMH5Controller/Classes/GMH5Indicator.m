//
//  GMH5Indicator.m
//  GIM
//
//  Created by Good Man on 2017/10/12.
//  Copyright © 2017年 Gome. All rights reserved.
//

#import "GMH5Indicator.h"

@implementation UIActivityIndicatorView (GMH5Indicator)

@end

@implementation GMH5LoadingIndicator

- (id)init {
    self=[super init];
    if (self) {
        self.hidden=YES;
    }
    return self;
}

- (id)initWithImage:(UIImage *)image rate:(NSTimeInterval)rate {
    self=[self init];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.image=image;
        self.rate=rate;
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    _image=image;
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, _image.size.width, _image.size.height);
    [self setNeedsDisplay];
}

- (void)startAnimating {
    self.hidden=NO;
    CABasicAnimation * ani=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    ani.toValue=@(M_PI*2.0);
    ani.repeatCount=MAXFLOAT;
    ani.duration=self.rate;
    [self.layer addAnimation:ani forKey:nil];
}

- (void)stopAnimating {
    [self.layer removeAllAnimations];
    self.hidden=YES;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self.image drawInRect:rect];
}

@end
