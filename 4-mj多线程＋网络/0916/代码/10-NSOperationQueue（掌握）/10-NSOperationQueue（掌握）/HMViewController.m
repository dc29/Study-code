//
//  HMViewController.m
//  10-NSOperationQueue（掌握）
//
//  Created by apple on 14-9-16.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMViewController.h"

@interface HMViewController () <UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation HMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}


// 线程间的通信;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        // 1.异步下载图片
        NSURL *url = [NSURL URLWithString:@"http://d.hiphotos.baidu.com/image/pic/item/37d3d539b6003af3290eaf5d362ac65c1038b652.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        // 2.回到主线程，显示图片
//        [self performSelectorOnMainThread:<#(SEL)#> withObject:<#(id)#> waitUntilDone:<#(BOOL)#>];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//        });
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.imageView.image = image;
        }];
    }];
}


// 依赖
- (void)dependency
{
    /**
     假设有A、B、C三个操作，要求：
     1. 3个操作都异步执行
     2. 操作C依赖于操作B
     3. 操作B依赖于操作A
     
     // 依赖其实就是顺序， a完事之后才能b
     // 注意不能相互依赖;
     */
    
    // 1.创建一个队列（非主队列）
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 2.创建3个操作
    NSBlockOperation *operationA = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"A1---%@", [NSThread currentThread]);
    }];
    //    [operationA addExecutionBlock:^{
    //        NSLog(@"A2---%@", [NSThread currentThread]);
    //    }];
    //
    
    // 操作a完成之后做什么
    //    [operationA setCompletionBlock:^{
    //        NSLog(@"AAAAA---%@", [NSThread currentThread]);
    //    }];
    
    NSBlockOperation *operationB = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"B---%@", [NSThread currentThread]);
    }];
    NSBlockOperation *operationC = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"C---%@", [NSThread currentThread]);
    }];
    
    // 设置依赖
    [operationB addDependency:operationA];
    [operationC addDependency:operationB];
    
    // 3.添加操作到队列中（自动异步执行任务）
    [queue addOperation:operationC];
    [queue addOperation:operationA];
    [queue addOperation:operationB];
}

// 这个很有用;这个比gcd好控制; 可以很精确
- (void)maxCount
{
    // 1.创建一个队列（非主队列）
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 2.设置最大并发(最多同时并发执行3个任务)
    queue.maxConcurrentOperationCount = 3;
    
    // 3.添加操作到队列中（自动异步执行任务，并发）
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下载图片1---%@", [NSThread currentThread]);
    }];
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下载图片2---%@", [NSThread currentThread]);
    }];
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下载图片3---%@", [NSThread currentThread]);
    }];
    NSBlockOperation *operation4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下载图片4---%@", [NSThread currentThread]);
    }];
    // 下面这么写， operation5也会被放到子线程中执行;
    NSInvocationOperation *operation5 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(download) object:nil];
    
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    [queue addOperation:operation3];
    [queue addOperation:operation4];
    [queue addOperation:operation5];
    [queue addOperationWithBlock:^{
        NSLog(@"下载图片5---%@", [NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"下载图片6---%@", [NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"下载图片7---%@", [NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"下载图片8---%@", [NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"下载图片9---%@", [NSThread currentThread]);
    }];
    
    [queue cancelAllOperations];
}


#warning 取消的操作一般放这个方法; 
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
//    [queue cancelAllOperations]; // 取消队列中的所有任务（不可恢复）
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    [queue setSuspended:YES]; // 暂停队列中的所有任务
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    [queue setSuspended:NO]; // 恢复队列中的所有任务
}

- (void)download
{
    NSLog(@"download---%@", [NSThread currentThread]);
}

- (void)baseUse
{
    // 1.创建一个队列（非主队列）
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 2.添加操作到队列中（自动异步执行任务，并发）
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下载图片1---%@", [NSThread currentThread]);
    }];
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下载图片2---%@", [NSThread currentThread]);
    }];
    
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    // 下面是另一种更简单的添加方式， 和上面2个作用其实是一样的。
    [queue addOperationWithBlock:^{
        NSLog(@"下载图片3---%@", [NSThread currentThread]);
    }];
    
    // 3个操作并发执行
}

@end
