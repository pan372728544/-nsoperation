//
//  ZCCurrentOperation.h
//  自定义nsoperation
//
//  Created by panzhijun on 2017/10/31.
//  Copyright © 2017年 panzhijun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class ZCCurrentOperation;
@protocol currentOperationDelegate <NSObject>

-(void)downloadOperation:(ZCCurrentOperation *)operation didFinishedDownLoad:(UIImage *)image;
@end


@interface ZCCurrentOperation : NSOperation
{
    BOOL execting;
    BOOL finished;
    
}

@property (nonatomic, copy)NSString *urlStr;
@property (nonatomic, strong)NSIndexPath *indexPath;
@property (nonatomic, weak)id<currentOperationDelegate>delegate;



@end

