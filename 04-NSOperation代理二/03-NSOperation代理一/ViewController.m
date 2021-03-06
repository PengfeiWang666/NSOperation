//
//  ViewController.m
//  05-自定义Operation
//
//  Created by 王鹏飞 on 16/1/25.
//  Copyright © 2016年 王鹏飞. All rights reserved.
//

#import "ViewController.h"
#import "NSDownLoadOperation.h"

@interface ViewController () <WPFDloadOperationDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (nonatomic, strong) NSOperationQueue *queue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    NSLog(@"touchBegin--->%@", [NSThread currentThread]);
    
    // 1. 实例化自定义操作对象
    NSDownLoadOperation *operation = [[NSDownLoadOperation alloc] init];
    
    // 2. 设置操作对象的代理对象为self
    operation.delegate = self;
    
    // 3.1 将操作对象添加到队列中
    [self.queue addOperation:operation];
    
    // 3.2 直接开始
    // 这样的话，全部操作都在当前线程（主线程）中进行操作
    //[operation start];
    
    NSLog(@"touchEnd--->%@", [NSThread currentThread]);
}

// 实现代理方法
- (void)dloadImgWithOperation:(NSDownLoadOperation *)operation {
    
    // 只能这样赋值，不能直接将图片框赋值
    self.imgView.image = operation.imgView.image;
}




#pragma mark - 懒加载操作队列
- (NSOperationQueue *)queue {
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
        
        // 设置最多开6条子线程
        _queue.maxConcurrentOperationCount = 6;
    }
    return _queue;
}

@end
