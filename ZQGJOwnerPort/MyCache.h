//
//  MyCache.h
//  ZQGJOwnerPort
//
//  Created by 陈良辉 on 16/4/25.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCache : NSObject
//写入本地缓存
+ (void)createMyCache:(NSString *)path data:(NSData*)data;

//读取本地缓存
+ (NSData* )readMyCache:(NSString*)path;

//获取所有缓存大小
+ (double)getCachesSize;

//清除所有缓存
+ (void)clearAllCaches;
@end
