博客：http://useyourloaf.com/blog/state-preservation-and-restoration/

demo：https://github.com/kharrison/CodeExamples/tree/master/Restorer

文档：https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/PreservingandRestoringState.html#//apple_ref/doc/uid/TP40007457-CH28-SW1

总结（补漏）：

iOS的状态保存与恢复，当项目使用storyboard或者XIB比较简单，

* Application Delegate里实现：

```
- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder
{
  return YES;
}

- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder
{
  return YES;
}
```

* 为控制器设置Restoration ID

纯代码实现：

* Application Delegate里实现：

````
- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder
{
  return YES;
}

- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder
{
  return YES;
}
// 保存window的rootViewController
- (void)application:(UIApplication *)application willEncodeRestorableStateWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.window.rootViewController forKey:@"NavigationViewController1"];
}

// 恢复rootViewController，如果恢复成功则创建window
- (void)application:(UIApplication *)application didDecodeRestorableStateWithCoder:(NSCoder *)coder {
    NavigationViewController * ctl = [coder decodeObjectForKey:@"NavigationViewController1"];
    if (ctl) {
        UIWindow * window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        window.rootViewController = ctl;
        self.window = window;
    }
}

// 最后会执行到didFinishLaunchingWithOptions，先判断如果恢复成功(已经创建了window)则直接跳过，初次启动的时候会在这里创建window
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (!_window) {
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.restorationIdentifier = @"window";
        ViewController *vc = [[ViewController alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        NavigationViewController *navi = [[NavigationViewController alloc] initWithRootViewController:vc];
        self.window.rootViewController = navi;
    }
    [self.window makeKeyAndVisible];
    return YES;
}

````

* 在控制器里

````
@interface ViewController ()<UIViewControllerRestoration>
@property (nonatomic, copy) NSString *string;
@property (nonatomic) BOOL restoringState;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.restorationIdentifier = @"ViewController";
    self.restorationClass = [self class];
 }
 
 // UIViewControllerRestoration协议方法
 + (UIViewController *)viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder
{
    ViewController *vc = [[ViewController alloc] init];
    vc.restorationIdentifier = @"ViewController";
    vc.restorationClass = [ViewController class];
    return vc;
}

// 下面两个方法保存和恢复控制器内部数据
- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.string forKey:@"bgColor"];
    [coder encodeObject:self.view.backgroundColor forKey:@"backgroundcolor"];
    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    self.restoringState = YES;
    self.string = [coder decodeObjectForKey:@"bgColor"];
    self.view.backgroundColor = [coder decodeObjectForKey:@"backgroundcolor"];
    [super decodeRestorableStateWithCoder:coder];
}
````



