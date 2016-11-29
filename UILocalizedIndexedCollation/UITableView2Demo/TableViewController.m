//
//  TableViewController.m
//  UITableView2Demo
//
//  Created by uuzuche on 15/8/4.
//  Copyright (c) 2015年 uuzuche. All rights reserved.
//

#import "TableViewController.h"
#import "Character.h"

@interface TableViewController ()
{
    // tableView数据源
    NSMutableArray *dataSource;
    // 索引数组
    NSArray *titleArray;
}

@end

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSMutableSet *set = [[NSMutableSet alloc] init];
    NSMutableArray *dataSourceTemp = [NSMutableArray array];
    for (int i = 0; i < 50; i++)
    {
        Character *dummy = [[Character alloc] init];
        if ((i % 2))
        {
            dummy.name = (i % 3) ? @"Dummy" : @"测试";
        }
        else
        {
            dummy.name = (i % 4) ? [NSString stringWithFormat:@"andy%d", 50 - i]
                                 : [NSString stringWithFormat:@"sala%d", 40 - i];
        }

        dummy.job = @"自由职业";
        [dataSourceTemp addObject:dummy];
    }
    Character *character1 = [[Character alloc] init];
    character1.name = @"王五";
    character1.job = @"教师";
    [dataSourceTemp addObject:character1];

    Character *character2 = [[Character alloc] init];
    character2.name = @"李六";
    character2.job = @"导游";
    [dataSourceTemp addObject:character2];

    Character *character3 = [[Character alloc] init];
    character3.name = @"李七";
    character3.job = @"医生";
    [dataSourceTemp addObject:character3];
    // 获得UILocalizedIndexedCollation的单例
    UILocalizedIndexedCollation *theCollation = [UILocalizedIndexedCollation currentCollation];


    // 遍历得到需要索引需要显示的字母，不需要的就不显示
    for (Character *character in dataSourceTemp)
    {
        // 查询段的索引对应的字母在[theCollation sectionTitles]中的下标
        NSInteger sect =
            [theCollation sectionForObject:character collationStringSelector:@selector(name)];

        // 根据下表得到索引字母，为了防止重复存储，存放到set里
        [set addObject:[[theCollation sectionTitles] objectAtIndex:sect]];
    }

    // set转array
    titleArray = [set allObjects];

    // array排序
    titleArray = [titleArray sortedArrayUsingSelector:@selector(compare:)];

    // 创建与Section数目相同的空数组，类型为NSMutableArray
    NSMutableArray *sectonArrays = [NSMutableArray arrayWithCapacity:titleArray.count];
    for (int i = 0; i <= titleArray.count; i++)
    {
        [sectonArrays addObject:[NSMutableArray array]];
    }
    // 判断数据对应的索引字母，然后存储到对应的分段数组下
    for (Character *character in dataSourceTemp)
    {
        // 查询段的索引对应的字母在[theCollation sectionTitles]中的下标
        NSInteger sect =
            [theCollation sectionForObject:character collationStringSelector:@selector(name)];
        // 根据下标找到对应的索引字母
        NSString *string = [[theCollation sectionTitles] objectAtIndex:sect];
        // 根据索引字母，找到该索引字母在实际显示索引的数组中的下标，将character存储到对应的分段的数组中
        [[sectonArrays objectAtIndex:[titleArray indexOfObject:string]] addObject:character];
    }

    // 将Section中数据追加到表格用数组中
    dataSource = [NSMutableArray arrayWithCapacity:titleArray.count];
    for (NSMutableArray *sectionArray in sectonArrays)
    {
        // 对一个section下所有rows根据name排序，用本方法数据展示将是“andy4 andy8
        // andy12...”,不用的话数据是乱序的
        NSArray *sortedSection = [theCollation sortedArrayFromArray:sectionArray
                                            collationStringSelector:@selector(name)];
        [dataSource addObject:sortedSection];
    }
}


#pragma mark - Table view data source
// 返回索引数组
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *mutableTitleArray = [NSMutableArray arrayWithArray:titleArray];
    [mutableTitleArray insertObject:UITableViewIndexSearch atIndex:0];
    [mutableTitleArray addObject:@"#"];
    return mutableTitleArray;
}
// 返回每个分段头的内容
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([[dataSource objectAtIndex:section] count] < 1)
    {
        return nil;
    }
    return [titleArray objectAtIndex:section];
}
- (NSInteger)tableView:(UITableView *)tableView
    sectionForSectionIndexTitle:(NSString *)title
                        atIndex:(NSInteger)index
{
    if (!index)
    {
        //如果点击的是放大镜，就把偏移量设为0
        self.tableView.contentOffset = CGPointZero;
    }
    return index - 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[dataSource objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"basis-cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
    }
    Character *character = [[dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = character.name;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath
*)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath]
withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new
row to the table view
    }
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath
toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before
navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
