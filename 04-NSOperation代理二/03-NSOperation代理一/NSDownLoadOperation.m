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
        
        NSString *filePath = @"http://ww4.sinaimg.cn/bmiddle/c260f7abjw1eyebnv7nj7j20dc0hsgnk.jpg";
        
        UIImage *image = [self downLoadImageWithStr:filePath];
        
        NSLog(@"image ---> %@", image);
        
        self.imgView.image = image;
        
        // 通知/代理/block :为了保证在不同对象之间传值的准确性!采用的是同步传值的方法!
        
        // 回到主线程设置UI
        dispatch_sync(dispatch_get_main_queue(), ^{
            if ([self.delegate respondsToSelector:@selector(dloadImgWithOperation:)]) {
                
                NSLog(@"setupUI ---> %@", [NSThread currentThread]);
                
                [self.delegate dloadImgWithOperation:self];
            }
        });
    }
    
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

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
    }
    return _imgView;
}

@end
