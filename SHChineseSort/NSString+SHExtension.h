//
//  NSString+SHExtension.h
//  SHExtension
//
//  Created by CSH on 2018/9/19.
//  Copyright © 2018年 CSH. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *sh_fomat_1 = @"YYYY-MM-dd HH:mm:ss";
static NSString *sh_fomat_2 = @"YYYY.MM.dd";
static NSString *sh_fomat_3 = @"YYYY.MM.dd HH:mm";
static NSString *sh_fomat_4 = @"YYYY/MM/dd";
static NSString *sh_fomat_5 = @"YYYY-MM-dd HH:mm";
static NSString *sh_fomat_6 = @"YYYY-MM-dd";
static NSString *sh_fomat_7 = @"YYYY-MM-dd HH:mm:ss:SSS";
static NSString *sh_fomat_8 = @"YYYY-MM-dd-HH-mm-ss-SSS";

NS_ASSUME_NONNULL_BEGIN

@interface NSString (SHExtension)

//获取拼音
@property (nonatomic, copy) NSString *pinyin;
//获取文件名字
@property (nonatomic, copy) NSString *fileName;
//获取字符串长度(中文：2 其他：1）
@property (nonatomic, assign) NSInteger textLength;

//是否为邮箱
@property (nonatomic, assign) BOOL isEmail;
//是否首字母开头
@property (nonatomic, assign) BOOL isFirstLetter;

//获取MD5加密
@property (nonatomic, copy) NSString *md5;
//64编码
@property (nonatomic, copy) NSString *base64;
//64解码
@property (nonatomic, copy) NSString *decoded64;

#pragma mark - Time方法
#pragma mark 获取毫秒值
+ (NSString *)getTimeMs;

#pragma mark 获取指定格式时间(time -> time)
- (NSString *)getTimeWithCurrentFormat:(NSString *)currentFormat format:(NSString *)format;

#pragma mark 获取毫秒值(time -> ms)
#pragma mark 获取当前
- (NSString *)getMsTimeWithFormat:(NSString *)format;
#pragma mark 获取指定时区(8*60*60)
- (NSString *)getMsTimeWithFormat:(NSString *)format GMT:(NSInteger)GMT;

#pragma mark 获取时间(ms -> time)
#pragma mark 获取当前
- (NSString *)getTimeMsWithFormat:(NSString *)format;
#pragma mark 获取指定(8*60*60)
- (NSString *)getTimeMsWithFormat:(NSString *)format GMT:(NSInteger)GMT;

@end

NS_ASSUME_NONNULL_END
