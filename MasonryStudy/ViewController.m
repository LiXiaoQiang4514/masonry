//
//  ViewController.m
//  MasonryStudy
//
//  Created by Jerry on 2017/8/22.
//  Copyright © 2017年 Jerry. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self masonryArrayWithButton];
    
    [self masonryLabelHeightLayout];
    
    [self masonryPriorityLayout];
    
    [self masonryScrollViewLayout];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置一组button的约束
- (void)masonryArrayWithButton
{
    NSArray *titleArray = @[@"按钮1", @"按钮2", @"按钮3", @"按钮4"];
    NSMutableArray *mArray = [NSMutableArray array];
    for (NSInteger i = 0; i < titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.layer.borderColor = [UIColor blackColor].CGColor;
        button.layer.borderWidth = 2;
        [self.view addSubview:button];
        [mArray addObject:button];
    }
    [mArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:20 tailSpacing:20];
    [mArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@100);
        make.height.equalTo(@40);
    }];
}

//不设置UILabel宽跟高的值
-(void)masonryLabelHeightLayout
{
    //文本控件UILabel、按钮UIButton、图片视图UIImageView等，它们具有自身内容尺寸（Intrinsic Content Size），此类用户控件会根据自身内容尺寸添加布局约束。也就是说，如果开发者没有显式给出其宽度或者高度约束，则其自动添加的自身内容约束将会起作用。因此看似“缺失”约束，实际上并非如此
    
    UILabel *myLabel=[[UILabel alloc]init];
    myLabel.backgroundColor=[UIColor redColor];
    myLabel.text=@"A测试Label不设高度时它的默认值测试Label不设高度时它的默认值";
    myLabel.numberOfLines = 0;
    [self.view addSubview:myLabel];
    [myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(150);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-60);
        
    }];
    
    UILabel *mySecondLabel=[[UILabel alloc]init];
    mySecondLabel.backgroundColor=[UIColor blueColor];
    mySecondLabel.text=@"确认";
    [self.view addSubview:mySecondLabel];
    [mySecondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(myLabel.mas_right).offset(10);
        make.centerY.mas_equalTo(myLabel);
    }];
    
}

//优先级 及至少的情况
-(void)masonryPriorityLayout
{
    UILabel *myLabel=[[UILabel alloc]init];
    myLabel.backgroundColor=[UIColor redColor];
    myLabel.text=@"B1测试Label不设高度时它的默认值,再增加文字长度时的情况";
    myLabel.numberOfLines = 0;
    [self.view addSubview:myLabel];
    [myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(200);
        make.left.mas_equalTo(20);
        
        //至少至右边有80的空间，优先级设高，如果文字不够长 它会以文字本来的宽度
        make.right.mas_lessThanOrEqualTo(-80).with.priorityHigh();
        
    }];
    
    UILabel *mySecondLabel=[[UILabel alloc]init];
    mySecondLabel.backgroundColor=[UIColor blueColor];
    mySecondLabel.text=@"确认";
    [self.view addSubview:mySecondLabel];
    [mySecondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(myLabel);
        make.left.mas_equalTo(myLabel.mas_right).offset(10);
    }];
    
}

//滚动视图添加约束
-(void)masonryScrollViewLayout
{
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(280);
        make.size.mas_equalTo(CGSizeMake(350,200));
        make.centerX.mas_equalTo(self.view);
    }];
    UIView *container = [UIView new];
    [scrollView addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    int count = 15;
    UIView *lastView = nil;
    for ( int i = 1 ; i <= count ; ++i )
    {
        UIView *subv = [UIView new];
        [container addSubview:subv];
        subv.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                          saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                          brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                               alpha:1];
        
        [subv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(container);
            make.height.mas_equalTo(@(30));
            
            if ( lastView )
            {
                make.top.mas_equalTo(lastView.mas_bottom);
            }
            else
            {
                make.top.mas_equalTo(container.mas_top);
            }
        }];
        
        lastView = subv;
    }
    //container这个view起到了一个中间层的作用 能够自动的计算uiscrollView的contentSize 下面这句很关键
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.mas_bottom);
    }];
}











@end
