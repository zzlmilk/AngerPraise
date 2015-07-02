//
//  ScanViewController.m
//  XMBarcodeScannerView
//
//  Created by chi on 15-3-31.
//  Copyright (c) 2015年 chi. All rights reserved.
//

#import "ScanViewController.h"

#import "XMBarcodeScannerView.h"
#import "ApIClient.h"
#import "Sweep.h"
#import "SMS_MBProgressHUD.h"


@interface ScanViewController () <UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, weak) XMBarcodeScannerView *scanView;


@property (nonatomic, weak) UITableView *tableView;


@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"k1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    // 创建子视图
    [self setup];

}

-(void)doBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)setup
{
    UITableView *tableView = [[UITableView alloc]init];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.automaticallyAdjustsScrollViewInsets = NO;
}


//扫描二维码 修改简历
-(void)sweepEditResume:(NSString *)sweepResultString{
    
    NSUserDefaults *token = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:[token objectForKey:@"token"] forKey:@"token"];
    [dic setObject:sweepResultString forKey:@"qcode_string"];
    
    [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Sweep sweepEditResume:dic WithBlock:^(Sweep *sweep, Error *e) {
        
        [SMS_MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (sweep.res !=nil) {
            
         [APIClient showSuccess:@"扫描成功" title:@"成功"];
            
        }
        if (e.info != nil){
        
            [APIClient showInfo:e.info title:@"提示"];
        }
        
    }];
    
}



- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
//    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat scanViewWidth, scanViewHeight;
    CGFloat consoleViewWidth, consoleViewHeight;
    if (width > 700.0) {
        
        scanViewWidth = scanViewHeight = 400.0f;
        // 设置扫描区域大小
        self.scanView.scanAreaSize = CGSizeMake(300.0f, 300.0f);
        consoleViewWidth = consoleViewHeight = 400.0f;
        
    }
    else {
        scanViewWidth = scanViewHeight = 300.0f;
        // 设置扫描区域大小
        self.scanView.scanAreaSize = CGSizeMake(250.0f, 250.0f);
        
        consoleViewWidth = 300.0f;
        consoleViewHeight = 150.0f;
    }
    
    self.scanView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
//    
    self.tableView.frame = CGRectMake((width - consoleViewWidth) * 0.5f, CGRectGetMaxY(self.scanView.frame) + 20.0f, consoleViewWidth, consoleViewHeight);

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.scanView startScanningWithResultBlock:^(NSArray *codes) {
        for (AVMetadataMachineReadableCodeObject *code in codes) {
            if (code.stringValue.length > 0) {
                
                BOOL isExist = NO;
                for (NSString *dataString in self.dataList) {
                    if ([dataString isEqualToString:code.stringValue]) {
                        isExist = YES;
                        break;
                    }
                }
                
                if (!isExist) {
                    [self.dataList addObject:code.stringValue];
                    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.dataList.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                    
                }
            }
        }
    }];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.scanView stopScanning];
}


- (XMBarcodeScannerView *)scanView
{
    if (_scanView == nil && [XMBarcodeScannerView cameraIsPresent] && ![XMBarcodeScannerView scanningIsProhibited]) {
        XMBarcodeScannerView *scanView = [XMBarcodeScannerView xmScannerViewWithScanAreaSize:CGSizeZero metadataObjectTypes:nil];
        [self.view addSubview:scanView];
        _scanView = scanView;
        
    }
    return _scanView;
}



#pragma mark - tableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

#pragma mark - tableView DataSource
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuserIdentifier = @"codeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIdentifier];
    }
    
    cell.textLabel.text = self.dataList[indexPath.row];
    
    [self sweepEditResume:cell.textLabel.text];
    
    //[APIClient showSuccess:cell.textLabel.text title:@"扫码成功"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - tableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSMutableArray *)dataList
{
    if (_dataList == nil) {
        
        _dataList = [NSMutableArray array];
    }
    
    
    return _dataList;
}


@end
