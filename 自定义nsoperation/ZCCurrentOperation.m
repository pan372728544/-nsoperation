//
//  ZCCurrentOperation.m
//  自定义nsoperation
//
//  Created by panzhijun on 2017/10/31.
//  Copyright © 2017年 panzhijun. All rights reserved.
//

#import "ZCCurrentOperation.h"

@implementation ZCCurrentOperation

-(id)init
{
    if (self = [super init])
    {
        execting = NO;
        finished = NO;
    }
    return self;
}


-(BOOL)isConcurrent
{
    return YES;
    
}

-(BOOL)isExecuting
{
    return execting;
    
}

-(BOOL)isFinished
{
    return finished;
}


-(void)start
{
        //第一步就要检测是否被取消了，如果取消了，要实现相应的KVO
    if ([self isCancelled])
    {
        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        
        return;
    }
    //如果没被取消，开始执行任务
    [self willChangeValueForKey:@"isExecuting"];
    
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    execting = YES;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)main {
    @try {
        
        @autoreleasepool {
            //在这里定义自己的并发任务
            NSLog(@"自定义并发操作NSOperation");
            
            NSURL *url=[NSURL URLWithString:self.urlStr];
            NSData *data=[NSData dataWithContentsOfURL:url];
            UIImage *imgae=[UIImage imageWithData:data];
            
            if ([self.delegate respondsToSelector:@selector(downloadOperation:didFinishedDownLoad:)]) {
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.delegate downloadOperation:self didFinishedDownLoad:imgae];
                }) ;
                
            }
            
            
            NSThread *thread = [NSThread currentThread];
            NSLog(@"%@",thread);
            
            //任务执行完成后要实现相应的KVO
            [self willChangeValueForKey:@"isFinished"];
            [self willChangeValueForKey:@"isExecuting"];
            
            execting = NO;
            finished = YES;
            
            [self didChangeValueForKey:@"isExecuting"];
            [self didChangeValueForKey:@"isFinished"];
        }
    }
    @catch (NSException *exception) {
        
    }
    
}



@end
