//
//  ViewController.m
//  02-NSBlockOperation简单使用
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
    
    /*
     打印结果：
     
      touchBegin---><NSThread: 0x7fbcf8d02380>{number = 1, name = main}
      touchEnd---><NSThread: 0x7fbcf8d02380>{number = 1, name = main}
      1111-main---><NSThread: 0x7fbcf8d02380>{number = 1, name = main}
      6666---><NSThread: 0x7fbcf8d1f420>{number = 4, name = (null)}
      4444---><NSThread: 0x7fbcf8f19340>{number = 2, name = (null)}
      2222-main---><NSThread: 0x7fbcf8d02380>{number = 1, name = main}
      5555---><NSThread: 0x7fbcf8e089f0>{number = 3, name = (null)}
      3333-main---><NSThread: 0x7fbcf8d02380>{number = 1, name = main}
     */
    
    
    NSLog(@"touchBegin--->%@", [NSThread currentThread]);
    
    // 直接通过操作队列添加任务
    [[NSOperationQueue mainQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1111-main--->%@", [NSThread currentThread]);
    }]];
    
    [[NSOperationQueue mainQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"2222-main--->%@", [NSThread currentThread]);
    }]];
    
    [[NSOperationQueue mainQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"3333-main--->%@", [NSThread currentThread]);
    }]];
    
    [[[NSOperationQueue alloc] init] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"4444--->%@", [NSThread currentThread]);
    }]];
    
    [[[NSOperationQueue alloc] init] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"5555--->%@", [NSThread currentThread]);
    }]];
    
    [[[NSOperationQueue alloc] init] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"6666--->%@", [NSThread currentThread]);
    }]];
    
    NSLog(@"touchEnd--->%@", [NSThread currentThread]);
}


- (void)test1 {

    /*
     当 NSBlockOperation 中的任务书 > 1 之后，无论是将操作添加到主线程，还是在主线程直接执行start， NSBlockOperation中的任务执行顺序都不确定，执行线程也不确定！
     
     一般在开发中，要避免向NSBlockOperation 中追加任务
     
     如果任务都是在主线程中执行，并且不需要保证执行顺序，可以直接追加任务
     
     */
    
    
    // 1. 实例化操作对象
    NSBlockOperation *blockOperation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"11111--->%@", [NSThread currentThread]);
    }];
    
    // 2. 往当前操作中追加操作一
    [blockOperation1 addExecutionBlock:^{
        NSLog(@"追加任务1--->%@", [NSThread currentThread]);
    }];
    
    // 2. 往当前操作中追加操作二
    [blockOperation1 addExecutionBlock:^{
        NSLog(@"追加任务2--->%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *blockOperation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"22222--->%@", [NSThread currentThread]);
    }];
    
    
    NSBlockOperation *blockOperation3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"33333--->%@", [NSThread currentThread]);
    }];
    
    // 将操作添加到主队列中
    //    [[NSOperationQueue mainQueue] addOperation:blockOperation1];
    //    [[NSOperationQueue mainQueue] addOperation:blockOperation2];
    //    [[NSOperationQueue mainQueue] addOperation:blockOperation3];
    /*
     输出结果：
     
     11111---><NSThread: 0x7fed62e065f0>{number = 1, name = main}
     追加任务2---><NSThread: 0x7fed62e065f0>{number = 1, name = main}
     追加任务1---><NSThread: 0x7fed62f07ba0>{number = 4, name = (null)}
     22222---><NSThread: 0x7fed62e065f0>{number = 1, name = main}
     33333---><NSThread: 0x7fed62e065f0>{number = 1, name = main}
     */
    
    
    
    
    
    
    // 将操作添加到非主队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [queue addOperation:blockOperation1];
    [queue addOperation:blockOperation2];
    [queue addOperation:blockOperation3];
    /*
     输出结果：
     
     22222---><NSThread: 0x7fba18f08a20>{number = 9, name = (null)}
     11111---><NSThread: 0x7fba18f03780>{number = 7, name = (null)}
     33333---><NSThread: 0x7fba18d99c20>{number = 10, name = (null)}
     追加任务1---><NSThread: 0x7fba18f08770>{number = 8, name = (null)}
     追加任务2---><NSThread: 0x7fba18c06220>{number = 11, name = (null)}
     */

    
}

@end
