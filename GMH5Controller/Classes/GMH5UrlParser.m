//
//  GMH5UrlParser.m
//  GMH5Controller
//
//  Created by Good Man on 2017/6/29.
//  Copyright © 2017年 Good Man. All rights reserved.
//

#import "GMH5UrlParser.h"

#define GMH5UrlParserErrDomain @"GMH5UrlParserErrDomain"

@interface GMH5DefaultUrlParser ()

@property(strong,nonatomic) NSNumber * timeStamp;

@end

static NSMutableDictionary * ST_DefaultParserKeys;
static NSMutableDictionary * ST_DefaultParserMethods;

@implementation GMH5DefaultUrlParser

+ (void)initialize {
    if (!ST_DefaultParserKeys) {
        ST_DefaultParserKeys=[NSMutableDictionary new];
    }
    if (!ST_DefaultParserMethods) {
        ST_DefaultParserMethods=[NSMutableDictionary new];
    }
}

+ (instancetype)urlParserWithAppSetting:(GMH5AppSetting *) appSetting {
    GMH5DefaultUrlParser * parser=[[GMH5DefaultUrlParser alloc] init];
    parser.appSetting=appSetting;
    return parser;
}

+ (void)registerDefaultKeys:(NSArray *)keys valuesBlock:(GMH5DefaultUrlParserValueForKeyBlock)block {
    GMH5DefaultUrlParserValueForKeyBlock copyBlock=[block copy];
    for (NSString * key in keys) {
        if (key.length>0) {
            [ST_DefaultParserKeys setObject:copyBlock forKey:key];
        }
    }
}

+ (void)registerDefaultMethods:(NSArray *)methods valuesBlock:(GMH5DefaultUrlParserValueForMethodBlock)block {
    GMH5DefaultUrlParserValueForMethodBlock copyBlock=[block copy];
    for (NSString * method in methods) {
        if (method.length>0) {
            [ST_DefaultParserMethods setObject:copyBlock forKey:method];
        }
    }
}

- (NSMutableDictionary *)keys {
    return ST_DefaultParserKeys;
}

- (NSMutableDictionary *)methods {
    return ST_DefaultParserMethods;
}

- (void)registerKey:(NSString *) key valueblock:(GMH5DefaultUrlParserValueForKeyBlock) block {
    if (key.length>0) {
        [ST_DefaultParserKeys setObject:[block copy] forKey:key];
    }
}

- (void)registerMethod:(NSString *) method valueblock:(GMH5DefaultUrlParserValueForMethodBlock) block {
    if (method.length>0) {
        [ST_DefaultParserMethods setObject:[block copy] forKey:method];
    }
}

- (NSNumber *)timeStamp {
    return @(ceil([[NSDate date] timeIntervalSince1970]*1000));
}

#pragma -mark an archive for `GMH5UrlParser` protocal
- (NSString *)parseUrlFromFormatString:(NSString *) url error:(NSError **) err {
    if (url.length==0) {
        *err=[NSError errorWithDomain:GMH5UrlParserErrDomain code:GMH5UrlParserErrUrlNull userInfo:nil];
        return nil;
    }
    return [self parseBraces:[self parseSquareBrackets:url error:err] error:err];
}

- (NSString *)parseSquareBrackets:(NSString *)url error:(NSError **)err {
    if (*err!=nil) {
        return nil;
    }
    NSError * error=nil;
    NSRegularExpression * regular=[NSRegularExpression regularExpressionWithPattern:@"\\[[^\\[]+\\]" options:0 error:&error];
    if (error) {
        *err=[NSError errorWithDomain:GMH5UrlParserErrDomain code:GMH5UrlParserErrBadSyntax userInfo:nil];
        return nil;
    }
    NSArray * arr=[regular matchesInString:url options:0 range:NSMakeRange(0, url.length)];
    NSString * newUrl=url;
    for (NSTextCheckingResult * result in arr) {
        NSString * match=[url substringWithRange:result.range];
        NSString * key=[match stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"[]"]];
        
        if ([[self keys].allKeys containsObject:key]) {
            id val=[[self keys] objectForKey:key];
            if ([val isKindOfClass:[NSString class]]) {
                newUrl=[newUrl stringByReplacingOccurrencesOfString:match withString:[self valueForKeyPath:val]];
            }
            else{
                newUrl=[newUrl stringByReplacingOccurrencesOfString:match withString:((GMH5DefaultUrlParserValueForKeyBlock)val)(key)];
            }
        }
        else{
            *err=[NSError errorWithDomain:GMH5UrlParserErrDomain code:GMH5UrlParserErrUndefinedKey userInfo:nil];
            return nil;
        }
    }
    return newUrl;
}

- (NSString *)parseBraces:(NSString *)url error:(NSError **)err {
    if (*err!=nil) {
        return nil;
    }
    NSError * error=nil;
    NSRegularExpression * regular=[NSRegularExpression regularExpressionWithPattern:@"\\{[^\\{]+\\}" options:0 error:&error];
    if (error) {
        *err=[NSError errorWithDomain:GMH5UrlParserErrDomain code:GMH5UrlParserErrBadSyntax userInfo:nil];
        return nil;
    }
    NSArray * arr=[regular matchesInString:url options:0 range:NSMakeRange(0, url.length)];
    NSString * newUrl=url;
    for (NSTextCheckingResult * result in arr) {
        NSString * match=[url substringWithRange:result.range];
        NSArray * partens=[[match stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"{}"]] componentsSeparatedByString:@":"];
        if (partens.count==2) {
            if ([[self methods].allKeys containsObject:partens[0]]) {
                id val=[[self methods] objectForKey:partens[0]];
                newUrl=[newUrl stringByReplacingOccurrencesOfString:match withString:((GMH5DefaultUrlParserValueForMethodBlock)val)(partens[0],partens[1])];
            }
            else{
                *err=[NSError errorWithDomain:GMH5UrlParserErrDomain code:GMH5UrlParserErrUndefinedMethod userInfo:nil];
                return nil;
            }
        }
        else {
            *err=[NSError errorWithDomain:GMH5UrlParserErrDomain code:GMH5UrlParserErrBadSyntax userInfo:nil];
            return nil;
        }
    }
    return newUrl;
}

@end

