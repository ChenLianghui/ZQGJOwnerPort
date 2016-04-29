//
//  MyHelper.m
//  ZQGJOwnerPort
//
//  Created by 陈良辉 on 16/4/25.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "MyHelper.h"
#import "NSString+Hashing.h"


@implementation MyHelper
+ (NSString *)dateStringFromNumberTimer:(NSString *)timerStr {
    //转化为Double
    double t = [timerStr doubleValue];
    //计算出距离1970的NSDate
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:t];
    //转化为 时间格式化字符串
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //转化为 时间字符串
    return [df stringFromDate:date];
}
+ (NSString *)dateStringFromNumberTimer2:(NSString *)timerStr {
    //转化为Double
    double t = [timerStr doubleValue];
    //计算出距离1970的NSDate
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:t];
    //转化为 时间格式化字符串
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    df.dateFormat = @"MM月dd日 HH:mm:ss";
    //转化为 时间字符串
    return [df stringFromDate:date];
}

+(NSString *)dateIntervalStringFromDate:(NSDate *)date
{
    //创建日期 NSCalendar对象
    NSCalendar *cal = [NSCalendar currentCalendar];
    //得到当前时间
    NSDate *today = [NSDate date];
    unsigned int unitFlags = 0;
    //用来得到具体的时差,位运算
    if ([self getCurrentIOS] >= 8.0) {
        unitFlags  = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ;
    }
    if (cal && today) {//不为nil进行转化
        NSDateComponents *com = [cal components:unitFlags fromDate:date toDate:today options:0];
        if (com.year > 0) {
            return [NSString stringWithFormat:@"%ld年前",com.year];
        }
        
        if (com.month > 0) {
            return [NSString stringWithFormat:@"%ld个月前",com.month];
        }
        
        if (com.day > 0) {
            return [NSString stringWithFormat:@"%ld天前",com.day];
        }
        
        if (com.hour > 0) {
            return [NSString stringWithFormat:@"%ld小时前",com.hour];
        }
        
        if (com.minute > 0) {
            return [NSString stringWithFormat:@"%ld分钟前",com.minute];
        }
        
        if (com.second > 0) {
            return [NSString stringWithFormat:@"%ld秒前",com.second];
        }
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

//动态 计算行高
//根据字符串的实际内容的多少 在固定的宽度和字体的大小，动态的计算出实际的高度
+ (CGFloat)textHeightFromTextString:(NSString *)text width:(CGFloat)textWidth fontSize:(CGFloat)size{
    if ([MyHelper getCurrentIOS] >= 7.0) {
        //iOS7之后
        NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:size]};
        CGRect rect = [text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        //返回计算出的行高
        return rect.size.height;
        
    }
    //    else {
    //
    //        CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:size] constrainedToSize:CGSizeMake(textWidth, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    //        return textSize.height;//返回 计算出得行高
    //    }
    return 0;
}

//获取iOS版本号
+ (double)getCurrentIOS {
    return [[[UIDevice currentDevice] systemVersion] doubleValue];
}
+ (CGSize)getScreenSize {
    return [[UIScreen mainScreen] bounds].size;
}
//获得当前系统时间到指定时间的时间差字符串,传入目标时间字符串和格式
+(NSString*)stringNowToDate:(NSString*)toDate formater:(NSString*)formatStr
{
    
    NSDateFormatter *formater=[[NSDateFormatter alloc] init];
    if (formatStr) {
        [formater setDateFormat:formatStr];
    }
    else{
        [formater setDateFormat:[NSString stringWithFormat:@"yyyy-MM-dd HH:mm:ss"]];
    }
    
    NSDate *date=[formater dateFromString:toDate];
    return [self stringNowToDate:date];
    
}


//获得到指定时间的时间差字符串,格式在此方法内返回前自己根据需要格式化
+(NSString*)stringNowToDate:(NSDate*)toDate
{
    //创建日期 NSCalendar对象
    NSCalendar *cal = [NSCalendar currentCalendar];
    //得到当前时间
    NSDate *today = [NSDate date];
    unsigned int unitFlags;
    //用来得到具体的时差,位运算
    if ([self getCurrentIOS] >= 8.0) {
        unitFlags  = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ;
    }else{
        unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ;
    }
    if (toDate && today) {//不为nil进行转化
        NSDateComponents *d = [cal components:unitFlags fromDate:today toDate:toDate options:0 ];
        
        //NSString *dateStr=[NSString stringWithFormat:@"%d年%d月%d日%d时%d分%d秒",[d year],[d month], [d day], [d hour], [d minute], [d second]];
        NSString *dateStr=[NSString stringWithFormat:@"%02ld:%02ld:%02ld",[d hour], [d minute], [d second]];
        return dateStr;
    }
    return @"";
}




//获取 一个文件 在沙盒Library/Caches/ 目录下的路径
+ (NSString *)getFullCachesPathWithFile:(NSString *)urlName {
    
    //先获取 沙盒中的Library/Caches/路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *myCacheDirectory = [docPath stringByAppendingPathComponent:@"MyCaches"];
    //检测MyCaches 文件夹是否存在
    if (![[NSFileManager defaultManager] fileExistsAtPath:myCacheDirectory]) {
        //不存在 那么创建
        [[NSFileManager defaultManager] createDirectoryAtPath:myCacheDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    //用md5进行 加密 转化为 一串十六进制数字 (md5加密可以把一个字符串转化为一串唯一的用十六进制表示的串)
    NSString * newName = [urlName MD5Hash];
    
    //拼接路径
    return [myCacheDirectory stringByAppendingPathComponent:newName];
}
//获取 一个文件 在沙盒沙盒Document 目录下的路径
+ (NSString *)getFullDocumentPathWithFile:(NSString *)urlName{
    
    //先获取 沙盒中的Document路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *MyDocumentDirectory = [docPath stringByAppendingPathComponent:@"MyDocument"];
    //检测MyDocument 文件夹是否存在
    if (![[NSFileManager defaultManager] fileExistsAtPath:MyDocumentDirectory]) {
        //不存在 那么创建
        [[NSFileManager defaultManager] createDirectoryAtPath:MyDocumentDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    //用md5进行 加密 转化为 一串十六进制数字 (md5加密可以把一个字符串转化为一串唯一的用十六进制表示的串)
    NSString * newName = [urlName MD5Hash];
    
    //拼接路径
    return [MyDocumentDirectory stringByAppendingPathComponent:newName];
    
}
//检测 缓存文件 是否超时
+ (BOOL)isTimeOutWithFile:(NSString *)filePath timeOut:(double)timeOut {
    //获取文件的属性
    NSDictionary *fileDict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
    //获取文件的上次的修改时间
    NSDate *lastModfyDate = fileDict.fileModificationDate;
    //算出时间差 获取当前系统时间 和 lastModfyDate时间差
    NSTimeInterval sub = [[NSDate date] timeIntervalSinceDate:lastModfyDate];
    if (sub < 0) {
        sub = -sub;
    }
    //比较是否超时
    if (sub > timeOut) {
        //如果时间差 大于 设置的超时时间 那么就表示超时
        return YES;
    }
    return NO;
}


+(CGRect)textRectFromString:(NSString *)text width:(CGFloat)textWidth fontSize:(CGFloat)size{
    NSMutableAttributedString * attstr = [[NSMutableAttributedString alloc]initWithString:text];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.lineSpacing = 8.0;
    style.paragraphSpacing = 10.0;
    style.firstLineHeadIndent = 28;
    style.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:style,NSParagraphStyleAttributeName,[UIFont systemFontOfSize:size],NSFontAttributeName, nil];
    [attstr addAttributes:dict range:NSMakeRange(0, attstr.length)];
    
    CGRect rect = [attstr boundingRectWithSize:CGSizeMake(textWidth, 1000000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context: nil];
    return rect;
}
// 获取当前处于activity状态的view controller
- (UIViewController *)activityViewController
{
    UIViewController* activityViewController = nil;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if(window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows)
        {
            if(tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    NSArray *viewsArray = [window subviews];
    if([viewsArray count] > 0)
    {
        UIView *frontView = [viewsArray objectAtIndex:0];
        
        id nextResponder = [frontView nextResponder];
        
        if([nextResponder isKindOfClass:[UIViewController class]])
        {
            activityViewController = nextResponder;
        }
        else
        {
            activityViewController = window.rootViewController;
        }
    }
    
    return activityViewController;
}
- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}



@end
