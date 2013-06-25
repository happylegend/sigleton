//
//  MySingleton.m
//  Singleton
//
//  Created by 紫冬 on 13-6-24.
//  Copyright (c) 2013年 qsji. All rights reserved.
//

#import "MySingleton.h"

static MySingleton *singleton = nil;

@implementation MySingleton


+(MySingleton *)getSingleton
{
    @synchronized(self)            //为了确保多线程情况下，仍然保证实体的唯一
    {
        if (!singleton) {
            [[self alloc] init];   //该方法会调用allocWithZone
        }
    }
    return singleton;
}


+(id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (!singleton) {
            singleton = [super allocWithZone:zone];   //确保使用同一块内存空间
            return singleton;
        }
    }
    return nil;
}


-(id)copyWithZone:(NSZone *)zone
{
    return self;                 //确保copy对象也唯一
}


-(id)retain
{
    return  self;                //确保计数唯一
}


-(unsigned)retainCount
{
    return UINT_MAX;             //装逼用的，这样打印出来的计数永远为-1
}


-(id)autorelease
{
    return self;                 //返回单例本身，确保计数唯一
}


//不做任何处理
-(oneway void)release
{
    
}


-(void)dealloc
{
    //做一些收尾工作......
    [super dealloc];
}

@end
