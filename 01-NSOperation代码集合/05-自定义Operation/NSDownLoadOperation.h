//
//  NSDownLoadOperation.h
//  NSOperation代码集合
//
//  Created by 王鹏飞 on 16/1/25.
//  Copyright © 2016年 王鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDownLoadOperation : NSOperation

/** 承载图片的容器 */
@property (nonatomic, strong) UIImageView *imgView;
@end
