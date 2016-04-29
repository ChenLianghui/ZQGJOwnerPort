//
//  MyHelper.h
//  ZQGJOwnerPort
//
//  Created by 陈良辉 on 16/4/25.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyHelper : NSObject
//把一个秒字符串 转化为真正的本地时间
//@"1419055200" -> 转化 日期字符串
+ (NSString *)dateStringFromNumberTimer:(NSString *)timerStr;
+ (NSString *)dateStringFromNumberTimer2:(NSString *)timerStr;
/**
 *  计算时间间隔
 *
 *  @param startDate 开始时间
 *  @param endDate   结束时间
 *
 *  @return 时间间隔字符串，类似刚刚/几分钟前/几小时前/几天前/几月前/几年前
 */
+ (NSString *)dateIntervalStringFromDate:(NSDate *)date;


//根据字符串内容的多少  在固定宽度 下计算出实际的行高
+ (CGFloat)textHeightFromTextString:(NSString *)text width:(CGFloat)textWidth fontSize:(CGFloat)size;

//获取 当前设备版本
+ (double)getCurrentIOS;
//获取当前设备屏幕的大小
+ (CGSize)getScreenSize;

//获得当前系统时间到指定时间的时间差字符串,传入目标时间字符串和格式
+(NSString*)stringNowToDate:(NSString*)toDate formater:(NSString*)formatStr;

//获取 一个文件 在沙盒沙盒Library/Caches/ 目录下的路径
+ (NSString *)getFullCachesPathWithFile:(NSString *)urlName;
//获取 一个文件 在沙盒沙盒Document 目录下的路径
+ (NSString *)getFullDocumentPathWithFile:(NSString *)urlName;
//检测 缓存文件 是否超时
+ (BOOL)isTimeOutWithFile:(NSString *)filePath timeOut:(double)timeOut;

+ (CGRect)textRectFromString:(NSString *)text width:(CGFloat)textWidth fontSize:(CGFloat)size;

- (UIViewController *)activityViewController;
- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController;
//+ (void)registerLocalNotification:(NSInteger)alertTime;
- (void)removeUILocalNotification;

@end
