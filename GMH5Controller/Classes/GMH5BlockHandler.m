//
//  GMH5BlockHandler.m
//  GMH5Controller
//
//  Created by Good Man on 2017/7/14.
//  Copyright © 2017年 Good Man. All rights reserved.
//

#import "GMH5BlockHandler.h"

@implementation GMH5BlockHandler

+ (NSString *)name {
    return nil;
}

- (void)execWithParams:(NSArray *)params context:(id)context complete:(GMH5HandlerCompleteBlock)complete {
    self.block(params,context, complete);
}

@end
