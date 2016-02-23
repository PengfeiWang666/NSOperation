//
//  NSDownLoadOperation.h
//  NSOperation代码集合
//
//  Created by 王鹏飞 on 16/1/25.
//  Copyright © 2016年 王鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 声明block类型
typedef void(^downLoadBlock)(UIImage *image);

@interface NSDownLoadOperation : NSOperation

@property (nonatomic, copy) NSString *urlString;

/** 定义一个block 属性 */
@property (nonatomic, copy)downLoadBlock block;
@end
