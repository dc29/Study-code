//
//  HMViewController.m
//  03-单例模式-Singleton（掌握）
//
//  Created by apple on 14-9-16.
//  Copyright (c) 2014年 heima. All rights reserved.
//

// 可以保证在程序运行过程，一个类只有一个实例(一个对象)

#import "HMViewController.h"
#import "HMMusicTool.h"
#import "HMSoundTool.h"
#import "HMStudent.h"
#import "HMGoodStudent.h"
#import "HMPerson.h"
#import "HMDataTool.h"

@interface HMViewController ()

@end

@implementation HMViewController

/**
 static : 修饰变量
 1> 修饰全局变量
 * 全局变量的作用域仅限于当前文件内部； 不加static的话， 其他文件都能访问.
 
 2> 修饰局部变量 : 
 * 局部变量的生命周期 跟 全局变量 类似
 *　但是不能改变作用域
 * 能保证局部变量永远只初始化1次，在程序运行过程中，永远只有1分内存
 */

//- (void)test {
//    static int a = 1;
//    a++;
//    NSLog(@"%d", a);
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // HMPerson、HMStudent、HMGoodStudent
    
    [[HMGoodStudent alloc] init];
    
//    HMDataTool *tool1 = [HMDataTool sharedDataTool];
//    HMDataTool *tool2 = [HMDataTool sharedDataTool];
//    HMDataTool *tool3 = [[HMDataTool alloc] init];
//    HMDataTool *tool4 = [[HMDataTool alloc] init];
//    
//    NSLog(@"%@ %@ %@ %@", tool1, tool2, tool3, tool4);
}

- (void)test
{
    //    HMSoundTool *tool1 = [HMSoundTool sharedSoundTool];
    //    HMSoundTool *tool2 = [HMSoundTool sharedSoundTool];
    //    HMSoundTool *tool3 = [HMSoundTool sharedSoundTool];
    //    HMSoundTool *tool4 = [[HMSoundTool alloc] init];
    //    NSLog(@"%@ %@ %@ %@", tool1, tool2, tool3, tool4);
    
    //    NSLog(@"begin-%@", [HMMusicTool sharedMusicTool]);
    //    NSLog(@"begin-%@", [HMMusicTool sharedMusicTool]);
    
#warning  extern引用某个全局变量（并非定义）； 写extern后就会整个项目中去找.
    //    extern id _musicTool;
#warning 单例不加static， 别人一nil就完蛋了。
    //    _musicTool = nil;
    
    
    // 清空之后再调就又创建新的了。 
    //    NSLog(@"end-%@", [HMMusicTool sharedMusicTool]);
    //    NSLog(@"end-%@", [HMMusicTool sharedMusicTool]);
    
 
    
    
//--------------
    
    //    for (int i = 0; i<5; i++) {
    //        [self test];
    //   加static会打印23456
    //    }
    
    
//--------------
    
    //    HMMusicTool *tool = [[HMMusicTool alloc] init];
    //    HMMusicTool *tool2 = [[HMMusicTool alloc] init];
    //    HMMusicTool *tool3 = [HMMusicTool sharedMusicTool];
    //    HMMusicTool *tool4 = [HMMusicTool sharedMusicTool];
    //
    //    // copy 有可能会产生新的对象
    //    // copy方法内部会调用- copyWithZone:
    //    HMMusicTool *tool5 = [tool4 copy];
    //
    //    NSLog(@"%@ %@ %@ %@ %@", tool, tool2, tool3, tool4, tool5);
    
}

@end
