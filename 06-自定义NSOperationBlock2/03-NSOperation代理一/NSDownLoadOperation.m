//
//  NSDownLoadOperation.m
//  NSOperation代码集合
//
//  Created by 王鹏飞 on 16/1/25.
//  Copyright © 2016年 王鹏飞. All rights reserved.
//

#import "NSDownLoadOperation.h"

@implementation NSDownLoadOperation

// 不管是Operation 通过哪种方法创建，都要经过这个方法
- (void)main {
    
    // 为了能够及时释放内存，一般建立一个自动释放池，但是苹果官方文档不要求写
    @autoreleasepool {
        
        NSLog(@"main ---> %@", [NSThread currentThread]);
        
        
        
        UIImage *image = [self downLoadImageWithStr:self.urlString];
        
        NSLog(@"image ---> %@", image);
        
        // 回到主线程设置UI
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            // 执行block
            if (self.block) {
                self.block(image);
            }
        });
    }
    
}

- (void)downLoadImageWithBlock:(downLoadBlock)block {

    self.block = block;
}

// 抽取出下载图片的方法
- (UIImage *)downLoadImageWithStr:(NSString *)filePath {
    
       
    // 2. 转化为地址
    NSURL *url = [NSURL URLWithString:filePath];
    
    // 3. 转化为NSData 二进制类型数据(下载方法，耗时方法)
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    // 4. 转化为图片类型
    UIImage *image = [UIImage imageWithData:data];
    
    NSLog(@"downLoadImage ---> %@", [NSThread currentThread]);
    
    return image;
}



@end
