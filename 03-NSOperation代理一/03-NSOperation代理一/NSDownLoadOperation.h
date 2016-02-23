//
//  NSDownLoadOperation.h
//  NSOperation代码集合
//
//  Created by 王鹏飞 on 16/1/25.
//  Copyright © 2016年 王鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 书写协议
@protocol WPFDloadOperationDelegate <NSObject>

/** 就是将下载好的图片传过去 */
- (void)transformImage:(UIImage *)image;

@end

@interface NSDownLoadOperation : NSOperation

/** 承载图片的容器 */
@property (nonatomic, strong) UIImageView *imgView;

/** 绑定代理对象 */
@property (nonatomic, weak) id<WPFDloadOperationDelegate> delegate;
@end
