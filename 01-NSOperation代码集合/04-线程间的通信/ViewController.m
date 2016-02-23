//
//  ViewController.m
//  04-线程间的通信
//
//  Created by 王鹏飞 on 16/1/25.
//  Copyright © 2016年 王鹏飞. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (nonatomic, strong) NSOperationQueue *queue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    
    // 实例化操作对象
    NSBlockOperation *blockOper = [NSBlockOperation blockOperationWithBlock:^{
        
        // 1. 获取网络图片网址：http：// 开头，若地址中含有 “&” 符号，那么需要换一张照片
        //NSString *filePath = @"http://www.lc123.net/d/file/xw/yl/2015-01-07/218ba0725430a6339a5afb500e80ce27.jpg";
        
        // 加载本地图片地址：file://开头
        NSString *filePath = @"file:///Users/wangpengfei/Desktop/photo/IMG_5551.jpg";
        // 也可以直接加载本地图片地址
        // NSData *data = [NSData dataWithContentsOfFile:(nonnull NSString *)]
        
        
        // 地址中不能出现特殊字符，感叹号，斜杠，汉字等等
        // 如果本地图片地址含有中文，需要进行“百分号转义”,ios9.0以后没法用。。。
        // urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        UIImage *image = [self downLoadImageWithStr:filePath];
        
        // 回到主线程中设置图片，更新UI
        [[NSOperationQueue mainQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
            
            NSLog(@"setupUI ---> %@", [NSThread currentThread]);
            
            self.imgView.image = image;
        }]];
    }];
    
    // 将操作对象添加到操作队列中
    [self.queue addOperation:blockOper];
    
    
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

#pragma mark - 懒加载操作队列
- (NSOperationQueue *)queue {
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

@end
