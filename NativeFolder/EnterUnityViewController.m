//
//  EnterUnityViewController.m
//  Unity-iPhone
//
//  Created by Forever.H on 15/12/23.
//
//

#import "EnterUnityViewController.h"
#import "MyDataManager.h"

@interface EnterUnityViewController ()

@end

@implementation EnterUnityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)startUnity:(id)sender {
    [MyDataManager sharedManager].isInMyHomeView = true;
    
    if([MyDataManager sharedManager].isRestartInUnity)
    {
        //判断是否是第一次启动unity

        [MyDataManager sharedManager].myWindow.rootViewController = [MyDataManager sharedManager].unityViewController; //将存放在单例中的unityViewController变成当前的rootVC
        [[MyDataManager sharedManager].myWindow bringSubviewToFront: [MyDataManager sharedManager].unityViewController.view];//将unityVC放到window的最上面
        [[[UnityGetMainWindow() rootViewController] view]setHidden:NO]; //让unity的界面显示出来
        [UnityGetMainWindow() makeKeyAndVisible];
        UnityPause(false);
    }
    else
    {
        //如果是第一次启动unity，需要添加返回键
        
        [MyDataManager sharedManager].isRestartInUnity = true;
        [[MyDataManager sharedManager].myAppDelegate startUnity:UIApplication.sharedApplication];//启动unity
        
        //生成返回键
        UIView *pauseUnityView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 30, 30)];
        [backBtn addTarget:self action:@selector(doExitSelector) forControlEvents:UIControlEventTouchDown];
        [backBtn setBackgroundColor:[UIColor whiteColor]];
        [pauseUnityView addSubview:backBtn];
        
        [[MyDataManager sharedManager].myWindow.rootViewController.view addSubview:pauseUnityView];
        
    }

}

/**
 *  返回键函数
 */
- (void)doExitSelector{
    UnityPause(true); //跳转回iOS部分时需要暂停unity
    
    [MyDataManager sharedManager].unityViewController = [MyDataManager sharedManager].myWindow.rootViewController; //将unity的rootVC存在单例中防止被释放掉
    
    [[[UnityGetMainWindow() rootViewController] view] setHidden:YES]; //隐藏Unity的rootVC
    [MyDataManager sharedManager].myWindow.rootViewController = self; //将当前界面B作为当前window的rootVC
    [UnityGetMainWindow() makeKeyAndVisible];
}

@end
