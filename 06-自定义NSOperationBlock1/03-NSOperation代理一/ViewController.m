//
//  ViewController.m
//  05-自定义Operation
//
//  Created by 王鹏飞 on 16/1/25.
//  Copyright © 2016年 王鹏飞. All rights reserved.
//

#import "ViewController.h"
#import "NSDownLoadOperation.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (nonatomic, strong) NSOperationQueue *queue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
     block: 指向结构体的指针！块代码！闭包！！
     
     闭包: javascript/js最先使用 :可以从函数外部访问函数内部的变量! --- 灵活性!
     
     1. 定义 block 类型 （返回值、接受的参数类型...）
     2. 执行 block 中执行的内容（block 中封装的代码）
     3. 执行或调用 block （相当于调用函数）
     
     以上三个步骤，必须按顺序进行！
     可以在不同的对象中，分别设置三个步骤，只要保证顺序就OK
     
     */
    
    
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    NSLog(@"touchBegin--->%@", [NSThread currentThread]);
    
    // 1. 实例化自定义操作对象
    NSDownLoadOperation *operation = [[NSDownLoadOperation alloc] init];
    
    operation.urlString = @"http://ww4.sinaimg.cn/bmiddle/c260f7abjw1eyebnv7nj7j20dc0hsgnk.jpg";
    
    operation.block = ^(UIImage *image){
        NSLog(@"最后执行我!--->%@", [NSThread currentThread]);
        self.imgView.image = image;
    };
    
    
    // 操作完成之后的回调（意义不大）
    operation.completionBlock = ^(){
        
        NSLog(@"操作完成!");
    };
    
    // 3.1 将操作对象添加到队列中
    [self.queue addOperation:operation];
    
    
    
    
    
    // 3.2 直接开始
    // 这样的话，全部操作都在当前线程（主线程）中进行操作
    //[operation start];
    
    NSLog(@"touchEnd--->%@", [NSThread currentThread]);
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
