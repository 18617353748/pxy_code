//
//  ViewController.m
//  test_xuan_ka
//
//  Created by 广州秀品 on 15/9/14.
//  Copyright (c) 2015年 广州秀品. All rights reserved.
//
#import "SCNavTabBarController.h"
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
[super viewDidLoad];
// Do any additional setup after loading the view, typically from a nib.

UIViewController *oneViewController = [[UIViewController alloc] init];
oneViewController.title = @"新闻";
oneViewController.view.backgroundColor = [UIColor brownColor];

UIViewController *twoViewController = [[UIViewController alloc] init];
twoViewController.title = @"体育";
twoViewController.view.backgroundColor = [UIColor purpleColor];

UIViewController *threeViewController = [[UIViewController alloc] init];
threeViewController.title = @"娱乐";
threeViewController.view.backgroundColor = [UIColor orangeColor];

UIViewController *fourViewController = [[UIViewController alloc] init];
fourViewController.title = @"天府";
fourViewController.view.backgroundColor = [UIColor magentaColor];

UIViewController *fiveViewController = [[UIViewController alloc] init];
fiveViewController.title = @"四川省";
fiveViewController.view.backgroundColor = [UIColor yellowColor];

UIViewController *sixViewController = [[UIViewController alloc] init];
sixViewController.title = @"政治";
sixViewController.view.backgroundColor = [UIColor cyanColor];

UIViewController *sevenViewController = [[UIViewController alloc] init];
sevenViewController.title = @"国际新闻";
sevenViewController.view.backgroundColor = [UIColor blueColor];

UIViewController *eightViewController = [[UIViewController alloc] init];
eightViewController.title = @"自媒体";
eightViewController.view.backgroundColor = [UIColor greenColor];

UIViewController *ninghtViewController = [[UIViewController alloc] init];
ninghtViewController.title = @"科技";
ninghtViewController.view.backgroundColor = [UIColor redColor];

SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] init];
//测试修改位置
navTabBarController.barFrame = CGRectMake(0, 64, self.view.frame.size.width, 44);
//底部有工具栏，选项卡
navTabBarController.isHaveBarFlag = NO;
navTabBarController.subViewControllers = @[oneViewController, twoViewController, threeViewController, fourViewController, fiveViewController, sixViewController, sevenViewController, eightViewController/*, ninghtViewController*/];
navTabBarController.showArrowButton = NO;//不要弹
[navTabBarController addParentController:self];


navTabBarController.navTabBar.backgroundColor = [UIColor clearColor];//修改背景


//拿出按钮－－－根据需要，不一定需要下面的代码 拿出按钮可以添加图片，可以添加组建，修改按钮的样式
NSMutableArray *btn = [[NSMutableArray alloc] initWithArray:@[]];

for (int i=0; i<navTabBarController.view.subviews.count; i++) {
NSString *str = [NSString stringWithFormat:@"%@",[navTabBarController.view.subviews[i] class]];
NSLog(@" 1; %@",[navTabBarController.view.subviews[i] class]);
if ([str isEqualToString:@"SCNavTabBar"]) {
UIView *v = navTabBarController.view.subviews[i];
for (int k = 0; k<v.subviews.count; k++) {
NSLog(@" 2: %@",[v.subviews[k] class]);
NSString *s =[NSString stringWithFormat:@"%@", [v.subviews[k] class]];
if ([s isEqualToString:@"UIScrollView"]) {
UIView *sc = v.subviews[k];
sc.backgroundColor = [UIColor clearColor];
for (int m = 0; m<sc.subviews.count; m++) {
NSLog(@"3: %@",[sc.subviews[m] class]);
NSString *classname = [NSString stringWithFormat:@"%@",[sc.subviews[m] class]];
if ([classname isEqualToString:@"UIButton"]) {
[btn addObject:sc.subviews[m]];
}

}
}
}
}
}
//加红点 设置第一个按钮颜色
NSLog(@"%ld",btn.count);
for (int i=0; i<btn.count; i++) {
UIButton *tempbtn = (UIButton *)(btn[i]);
tempbtn.backgroundColor = [UIColor clearColor];
NSLog(@"\n%@",tempbtn.titleLabel.text);
UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(tempbtn.frame.size.width - 16 , 2, 16, 16)];
l.backgroundColor = [UIColor redColor];
l.text = @"35";
l.layer.cornerRadius = 12/2;
l.clipsToBounds = YES;
[l setAdjustsFontSizeToFitWidth:YES];
//[tempbtn addSubview:l];

//        if (i == 0) {
//            [tempbtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        }
}


NSLog(@"%f",self.view.frame.size.width);


}

- (void)didReceiveMemoryWarning {
[super didReceiveMemoryWarning];
// Dispose of any resources that can be recreated.
}

@end
