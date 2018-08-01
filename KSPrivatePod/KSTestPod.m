//
//  KSTestPod.m
//  KSPrivatePod
//
//  Created by aDu on 2018/7/18.
//  Copyright © 2018年 aDu. All rights reserved.
//

#import "KSTestPod.h"

@implementation KSTestPod

+ (void)printLog {
    NSLog(@"我是私有Pod");
}

+ (void)publicMethod {
    NSLog(@"公共的方法");
}

@end
