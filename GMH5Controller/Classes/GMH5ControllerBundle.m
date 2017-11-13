//
//  GMH5ControllerBundle.m
//  GMH5Controller
//
//  Created by Good Man on 2017/10/24.
//  Copyright © 2017年 Good Man. All rights reserved.
//

#import "GMH5ControllerBundle.h"

@implementation GMH5ControllerBundle

+ (UIImage *)imageNamed:(NSString *)name {
    return [UIImage imageNamed:name inBundle:[self mainBundle] compatibleWithTraitCollection:nil];
}

+ (NSBundle *)mainBundle {
    static NSBundle * ST_GMH5ControllerBundle;
    if (!ST_GMH5ControllerBundle) {
        ST_GMH5ControllerBundle=[NSBundle bundleWithPath:[[NSBundle bundleForClass:self] pathForResource:@"GMH5Controller" ofType:@"bundle"]];
        [ST_GMH5ControllerBundle load];
    }
    return ST_GMH5ControllerBundle;
}

@end
