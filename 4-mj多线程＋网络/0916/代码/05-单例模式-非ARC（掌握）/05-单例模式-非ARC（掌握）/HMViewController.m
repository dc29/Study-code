//
//  HMViewController.m
//  05-单例模式-非ARC（掌握）
//
//  Created by apple on 14-9-16.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMViewController.h"
#import "HMDataTool.h"

@interface HMViewController ()

@end

@implementation HMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    HMDataTool *tool1 = [[HMDataTool alloc] init];
    HMDataTool *tool2 = [[HMDataTool alloc] init];
    HMDataTool *tool3 = [HMDataTool sharedDataTool];
    HMDataTool *tool4 = [HMDataTool sharedDataTool];
    
    
    // 非arc， 别人这么一做， 对象就挂了。
    [tool4 autorelease];
    
    NSLog(@"%@ %@ %@ %@", tool1, tool2, tool3, tool4);
}

@end
