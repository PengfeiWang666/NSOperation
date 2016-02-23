//
//  ViewController.m
//  01-NSInvocationOperation简单使用
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"touchBegin--->%@", [NSThread currentThread]);
    
    // 1. 实例化三个操作对象
    NSInvocationOperation *invOperation1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:nil];
    
    NSInvocationOperation *invOperation2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task2) object:nil];
    
    NSInvocationOperation *invOperation3 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task3) object:nil];
    

//    // 2. 创建非主队列---》情况一：三个操作都是耗时操作
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
//    // 2.2 创建主队列---》情况二：三个操作都是UI操作
    // 相当于 GCD 中的 异步函数 + 主队列!
//    NSOperationQueue *queue = [NSOperationQueue mainQueue];
//    
//    // 3. 将操作对象添加到队列中
//    [queue addOperation:invOperation1];
//    [queue addOperation:invOperation2];
//    [queue addOperation:invOperation3];
    
#warning 情况三：直接开始，在当前线程中执行(按顺序执行)
    [invOperation1 start];
    [invOperation2 start];
    [invOperation3 start];
    
    
    NSLog(@"touchEnd--->%@", [NSThread currentThread]);
    
    // NSOperation 对象的入口定义在内部的main 方法中，无论是直接 start 还是添加到队列中都要执行该方法
}


- (void)task1 {
    NSLog(@"1111111--->%@", [NSThread currentThread]);
}

- (void)task2 {
    NSLog(@"2222222--->%@", [NSThread currentThread]);
}

- (void)task3 {
    NSLog(@"3333333--->%@", [NSThread currentThread]);
}

@end
