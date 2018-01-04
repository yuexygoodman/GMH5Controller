//
//  GMH5Tools.m
//  GMH5Controller
//
//  Created by Good Man on 2017/10/30.
//  Copyright © 2017年 Good Man. All rights reserved.
//

#import "GMH5Tools.h"

@implementation GMH5Tools

+(UIColor *)colorWithHexString:(NSString *)hex {
    if (hex.length==0)
        return nil;
    UIColor *color=[UIColor clearColor];
    @try {
        NSString* hexColor=hex;
        if([hex rangeOfString:@"#"].length>0){
            hexColor=[[hex componentsSeparatedByString:@"#"] lastObject];
        }
        if (hexColor.length<6)
        {
            hexColor=[NSString stringWithFormat:@"%@%@",[@"000000" substringToIndex:6-hexColor.length],hexColor];
        }
        unsigned int red,green,blue,alpna;
        NSRange range;
        if (hexColor.length==8) {
            range.length = 2;
            
            range.location = 0;
            [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&alpna];
            
            range.location = 2;
            [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
            
            range.location = 4;
            [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
            
            range.location = 6;
            [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
            color=[UIColor colorWithRed:(float)(red/255.0f)green:(float)(green / 255.0f) blue:(float)(blue / 255.0f)alpha:(float)(alpna / 255.0f)];
        }
        
        if (hexColor.length==6) {
            range.length = 2;
            
            range.location = 0;
            [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
            
            range.location = 2;
            [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
            
            range.location = 4;
            [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
            color=[UIColor colorWithRed:(float)(red/255.0f)green:(float)(green / 255.0f) blue:(float)(blue / 255.0f)alpha:1.0f];
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception.description);
    }
    
    return color;
}

@end
