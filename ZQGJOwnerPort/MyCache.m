//
//  MyCache.m
//  ZQGJOwnerPort
//
//  Created by 陈良辉 on 16/4/25.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "MyCache.h"
#import "SDImageCache.h"

@implementation MyCache
#pragma mark - 创建缓存
+ (void)createMyCache:(NSString *)path data:(NSData*)data{
    //写入本地缓存
    [[NSFileManager defaultManager] createFileAtPath:[MyHelper getFullCachesPathWithFile:path] contents:data attributes:nil];
    
}

#pragma mark - 读取缓存
+ (NSData* )readMyCache:(NSString*)path{
    //读取本地缓存
    if ([[NSFileManager defaultManager] fileExistsAtPath:[MyHelper getFullCachesPathWithFile:path]]) {
        NSData *data = [NSData dataWithContentsOfFile:[MyHelper getFullCachesPathWithFile:path]];
        return data;
    }
    
    return nil;
}

#pragma mark - 获取所有缓存大小
+ (double)getCachesSize {
    //1.自定义的缓存 2.sd 的缓存
    NSUInteger sdFileSize = [[SDImageCache sharedImageCache] getSize];
    
    //先获取 系统 Library/Caches 路径
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] ;
    NSString *myCachesPath = [caches stringByAppendingPathComponent:@"MyCaches"];
    
    NSDirectoryEnumerator *enumrator = [[NSFileManager defaultManager] enumeratorAtPath:myCachesPath];
    
    NSUInteger mySize = 0;
    //遍历枚举器
    for (NSString *fileName in enumrator) {
        //文件路径
        NSString *filePath = [myCachesPath stringByAppendingPathComponent:fileName];
        NSDictionary *fileDict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        //获取大小
        mySize += fileDict.fileSize;//字节大小
    }
    //1M == 1024KB == 1024*1024bytes
    return (mySize+sdFileSize)/1024.0/1024.0;
}

#pragma mark - 清除所有缓存
+ (void)clearAllCaches{
    
    //1.删除sd
    [[SDImageCache sharedImageCache] clearMemory];//清除内存缓存
    //2.清除 磁盘缓存
    [[SDImageCache sharedImageCache] clearDisk];
    
    //清除自己的缓存
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] ;
    NSString *myCachesPath = [caches stringByAppendingPathComponent:@"TYRootView"];
    //删除
    [[NSFileManager defaultManager] removeItemAtPath:myCachesPath error:nil];
}

@end
