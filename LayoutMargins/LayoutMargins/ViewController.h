//
//  ViewController.h
//  LayoutMargins
//
//  Created by 赵清 on 2016/11/24.
//  Copyright © 2016年 赵清. All rights reserved.
//

/*
 layoutMargins文档翻译：使用这个属性用于指定视图和它的子视图之间的边距（单位使用点）,自动布局系统使用你的margins作为限制条件布局内容。例如，如果你通过格式化语句“|-[subview]-|”设置水平约束，则子视图的左右边缘距离父视图左右内边缘相应的layout margins。当你的视图边缘接近父视图的边缘并且你视图的 preservesSuperviewLayoutMargins属性为YES的时候，实际的layout margins可能会增加以防止内容与superview的边距重叠。
 
 默认的margins 在每个边缘都是8 points
 
 如果视图是一个控制器的root view，系统设置管理视图的margins，顶部和底部的marigns被设置为0。侧面的margins依赖于当前size class而变化，但可以使16或者20points。你不可以更改这些margins
 */

/*
 preservesSuperviewLayoutMargins文档翻译：当这个属性的值为YES的时候，一个视图布局内容时其父视图的margins也会被考虑在内。这个margins对于一个视图与其父视图边缘距离的影响小于视图相应的margin。例如，你有一个内容视图的frame恰好和父视图的bounds一样，当父视图的任何margins在内容视图和它的margins的表示范围的内部时（有重合？？？），UIKit自动调整内容视图的的布局以满足父视图的margins。调整的数量是保证内容视图恰好在父视图的margins范围内的最小数量。
 
 属性默认值为NO。
 */


/*
 layoutMargins 理解：设置一个视图的边距（视图边缘与其子视图边缘的距离），防止子视图和父视图边缘重合。在iOS 8中，可以使用layoutMargins去定义view之间的间距,该属性只对AutoLayout布局生效。
 
 因此AutoLayout中NSLayoutAttribute的枚举值有了相应的更新：
 NSLayoutAttributeLeftMargin NS_ENUM_AVAILABLE_IOS(8_0),
 NSLayoutAttributeRightMargin NS_ENUM_AVAILABLE_IOS(8_0),
 NSLayoutAttributeTopMargin NS_ENUM_AVAILABLE_IOS(8_0),
 NSLayoutAttributeBottomMargin NS_ENUM_AVAILABLE_IOS(8_0),
 NSLayoutAttributeLeadingMargin NS_ENUM_AVAILABLE_IOS(8_0),
 NSLayoutAttributeTrailingMargin NS_ENUM_AVAILABLE_IOS(8_0),
 NSLayoutAttributeCenterXWithinMargins NS_ENUM_AVAILABLE_IOS(8_0),
 NSLayoutAttributeCenterYWithinMargins NS_ENUM_AVAILABLE_IOS(8_0),
 
 代码只有通过这些枚举值定义约束时，父视图定义的layoutMargins才会生效。见[self example1];消息
 
 preservesSuperviewLayoutMargins 理解：当为YES时，保证满足父视图通过layoutMargins设置的边距，如果一个视图A本身无法满足父视图B的layoutMargins并且视图的preservesSuperviewLayoutMargins属性为YES时，UIKit自动调整视图A内容视图的的布局以满足父视图的margins。见[self example2];
 
 */

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end

