//
//  HMViewController.m
//  07-Block循环引用
//
//  Created by HM on 16/1/25.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "HMViewController.h"

// 定义 block 类型

typedef void(^testBlock)();

@interface HMViewController ()

// 定义一个 block 属性
@property(nonatomic ,copy)testBlock blk;


@end

@implementation HMViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    //
    NSLog(@"控制器创建成功!");

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
    
    // 自定义 block .
    
    // block 对self 强引用!
    __weak typeof(self)wself = self;
    
    // 去了公司,有可能看到以下代码:
    // 下面的代码是没有 __weak 之前的 弱引用写法!
    __unsafe_unretained typeof(self)weakself = self;
    
    testBlock block = ^(){
      
        [weakself test];
    };
    

    
    
    
    // 将 block 定义成一个属性之后,self 对 block 就强引用了.
    // block 中出现 self ,block对 self 也是强引用,所以会造成循环引用!
    self.blk = block;
    
    // 执行 block
    block();
}


- (void)test1
{
    // 面试: GCD 的 block 中出现self,会造成循环引用的问题吗?
    // 1. 因为 self 对 GCD 中的 block 没有强引用,所以没有循环引用!
    // 2. 如果将队列变成一个属性之后,就有强引用!没有用过!在 SDWebImage 中见过!
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self test];
        
    });
}


-(void)test
{
    NSLog(@"------%@",[NSThread currentThread]);
}

-(void)dealloc
{
    NSLog(@"控制器销毁了!");
}



@end
