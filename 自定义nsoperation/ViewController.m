//
//  ViewController.m
//  自定义nsoperation
//
//  Created by panzhijun on 2017/10/31.
//  Copyright © 2017年 panzhijun. All rights reserved.
//

#import "ViewController.h"
#import "ZCCurrentOperation.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,currentOperationDelegate>
@property (nonatomic,strong)NSOperationQueue *myQueue;
@property (nonatomic, strong)UITableView *tableView;


@property (nonatomic, strong)NSMutableDictionary *images;
@property (nonatomic, strong)NSMutableDictionary *operations;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.myQueue = [[NSOperationQueue alloc]init];
    self.images = [NSMutableDictionary dictionary];
    self.operations = [NSMutableDictionary dictionary];
    
    ZCCurrentOperation *operation = [[ZCCurrentOperation alloc]init];
    
    [_myQueue addOperation:operation];
    
   
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    
    [self.view addSubview:self.tableView];
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }  
    
    UIImage *image = self.images[@"222"];
    if (image) {
        
    }
    else
    {
        
        ZCCurrentOperation *operation = self.operations[@"111"];
        if (operation) {
            
        }
        else
        {
            
            //当前没有下载，那就创建操作
            operation = [[ZCCurrentOperation alloc]init];
            operation.urlStr = @"";
            operation.indexPath = indexPath;
            operation.delegate = self;
            [self.myQueue addOperation:operation];//异步下载
            self.operations[@"111"] = operation;
            
        }
    }
    
}


#pragma currentOperationDelegate
-(void)downloadOperation:(ZCCurrentOperation *)operation didFinishedDownLoad:(UIImage *)image
{
    [self.operations removeObjectForKey:@""];
    
    self.images[@"222"] = image;
    [self.tableView reloadSections:@[operation.indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
}


@end
