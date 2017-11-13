//
//  GMH5BlockCommand.m
//  GMH5Controller
//
//  Created by 岳潇洋 on 2017/7/14.
//  Copyright © 2017年 岳潇洋. All rights reserved.
//

#import "GMH5BlockCommand.h"

@implementation GMH5BlockCommand

+ (NSString *)name {
    return nil;
}

- (void)execWithParams:(NSArray *)params context:(id)context complete:(GMH5CommandCompleteBlock)complete {
    self.block(params,context, complete);
}

@end
