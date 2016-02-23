//
//  ViewController.m
//  03-循环依赖
//
//  Created by 王鹏飞 on 16/1/25.
//  Copyright © 2016年 王鹏飞. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

/*
 遇到并发编程，什么时候选择GCD，什么时候选择 NSOperation?
 1. 遇到简单的开启线程、回到主线程，选择GCD：效率更高，简单
 2. 需要管理操作（考虑到用户交互！！）， 使用 NSOperation
 
 */

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
#warning 四个操作都是耗时操作! 并且要求按顺序执行! 操作2是UI操作!
    
    // 1. 实例化操作对象
    NSInvocationOperation *invocationOperation1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:nil];
    
    
    
    
    NSBlockOperation *blockOperation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"22222--->%@", [NSThread currentThread]);
    }];
    
    
    NSBlockOperation *blockOperation3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"33333--->%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *blockOperation4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"44444--->%@", [NSThread currentThread]);
    }];
    
//    // 添加操作依赖
    [blockOperation2 addDependency:invocationOperation1];
    [blockOperation3 addDependency:blockOperation2];
    [blockOperation4 addDependency:blockOperation3];
    
    
#warning 不要添加循环操作依赖，一定要在添加进操作队列之前设置操作依赖
    
    // 优点：对于不同操作队列中的操作，操作依然有效
    
    // 将操作添加到队列中
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [queue addOperation:blockOperation2];
    [queue addOperation:blockOperation3];
    [queue addOperation:blockOperation4];
    
    // 暂停操作，开始滚动的时候
    [queue setSuspended:YES];
    
    // 恢复操作，滚动结束的时候
    [queue setSuspended:NO];
    
    // 取消所有操作 ---> 内存警告的时候
    [queue cancelAllOperations];
    
    // 单个取消---> 是操作的方法
    [blockOperation2 cancel];
    
    // 设置最大子线程数
    [queue setMaxConcurrentOperationCount:6];
    
    // 将操作二添加到主队列中
    [[NSOperationQueue mainQueue] addOperation:invocationOperation1];
    
    
    /*
     打印结果：
     
     11111---><NSThread: 0x7fa3b9e008a0>{number = 1, name = main}
     22222---><NSThread: 0x7fa3b9e00ec0>{number = 2, name = (null)}
     33333---><NSThread: 0x7fa3b9e00ec0>{number = 2, name = (null)}
     44444---><NSThread: 0x7fa3b9e00ec0>{number = 2, name = (null)}
     */
}


- (void)task1 {
    NSLog(@"11111--->%@", [NSThread currentThread]);
}

@end
