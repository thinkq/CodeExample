//
//  ViewController.m
//  NSPredicateDemo
//
//  Created by 赵清 on 2016/11/13.
//  Copyright © 2016年 赵清. All rights reserved.
//

/* 
 博客：http://www.jianshu.com/p/b2694972863e
      http://nshipster.cn/nspredicate/
 iOS Predicate 即谓词逻辑。和数据库的SQL语句具有相似性，都是从数据堆中根据条件进行筛选。
 
        （1）NSPredicate给我留下最深印象的是两个数组求交集的一个需求，如果按照一般写法，需要2个遍历，但NSArray提供了一个filterUsingPredicate的方法，用了NSPredicate，就可以不用遍历！
 
        （2）在存储自定义对象的数组中，可以根据条件查询数组中满足条件的对象。
 */
#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self meetPredict];
    [self predictComparation];
    [self predicateRange];
    [self predicateComparationToSelf];
    [self predicateRelateToNSString];
    [self predicateWildcard];
    [self personPredicate];
    [self pathAndStringPredicate];
    [self variableNamePredicate];
    [self compoundPredicate];
    [self comparisonPredicate];
    [self blockPredicate];
}

- (void)meetPredict {
    NSArray *array1 = [NSArray arrayWithObjects:@1,@2,@3,@5,@5,@6,@7, nil];
    NSArray *array2 = [NSArray arrayWithObjects:@4,@5, nil];
    // 表示筛选array1在array2中的元素,其中SELF指向filteredArrayUsingPredicate的调用者。
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF in %@",array2];
    // temp1 表示array1在array2中元素
    NSArray *temp1 = [array1 filteredArrayUsingPredicate:predicate1];
    NSLog(@"meetPredict = %@",temp1);
}

/*
 用于 数值 及 字符串 的比较
 比较运算符：>,<,==,>=,<=,!=
 例：@"number > 100"
 */
- (void)predictComparation {
    NSArray *array = @[@1,@2,@3,@4,@5,@2,@6];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF > 4"];
    NSArray *filterArray = [array filteredArrayUsingPredicate:predicate];
    [filterArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"predictComparation = %@",obj);
    }];
}
/*
    范围运算符：IN BETWEEN
    例：@"number BETWEEN {1,5}"
        @"address IN {'shanghai','beijing'}"
 */
- (void)predicateRange {
    NSArray *array = @[@1,@2,@3,@4,@5,@2,@6];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF BETWEEN {2,5}"];
    NSArray *filterArray = [array filteredArrayUsingPredicate:predicate];
    [filterArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"predicateRange = %@",obj);
    }];
}

/*
    字符串本身：SELF
    例：@"SELF == 'APPLE'"
 */
- (void)predicateComparationToSelf {
    NSArray *placeArray = @[@"shanghai",@"hangzhou",@"beijing",@"macao",@"taishan"];
    // 这里识别区分大小写
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF == 'beijing'"];
    NSArray *tempArray = [placeArray filteredArrayUsingPredicate:predicate];
    [tempArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"predicateComparationToSelf = %@",obj);
    }];
}

/*
    字符串相关：BEGINSWITH,ENDSWITH,CONTAINS
    例： @"name CONTAIN [cd] 'ang'"      // 包含该某个字符串
        @"name BEGINSWITH [c] 'sh'"     // 以某个字符串开头
        @"name ENDSWITH [d] 'ang'"      // 以某个字符串结束
    注：[c]不区分大小写 [d]不区分发音符号，即没有重音符号 [cd]既不区分大小写，也不区分发音符号
 */
- (void)predicateRelateToNSString {
    NSArray *placeArray = @[@"shanghai",@"hangzhou",@"beijing",@"macao",@"taishan"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains [cd] 'an'"];
    NSArray *tempArray = [placeArray filteredArrayUsingPredicate:predicate];
    [tempArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"predicateRelateToNSString = %@",obj);
    }];
}

/*
    通配符：LIKE
    例： @"name LIKE [cd] '*er*'"    // *代表通配符，LIKE也接受[cd]
        @"name LIKE [cd] '???er*'"
 */
- (void)predicateWildcard {
    NSArray *placeArray = @[@"shanghai",@"hangzhou",@"beijing",@"macao",@"taishan"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF like [cd] '*ai*'"];
    NSArray *tempArray = [placeArray filteredArrayUsingPredicate:predicate];
    [tempArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"predicateWildcard = %@",obj);
    }];
}

- (NSArray *)peopleArray {
    NSArray *firstNames = @[ @"Alice", @"Bob", @"Charlie", @"Quentin" ];
    NSArray *lastNames = @[ @"Smith", @"Jones", @"Smith", @"Alberts" ];
    NSArray *ages = @[ @24, @27, @33, @31 ];
    NSMutableArray *people = [NSMutableArray array];
    [firstNames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Person *person = [[Person alloc] init];
        person.firstName = firstNames[idx];
        person.lastName = lastNames[idx];
        person.age = ages[idx];
        [people addObject:person];
    }];
    return people;
}

- (void)personPredicate {
    NSArray *people = [self peopleArray];
    NSPredicate *bobPredicate = [NSPredicate predicateWithFormat:@"firstName = 'Bob'"];
    NSPredicate *smithPredicate = [NSPredicate predicateWithFormat:@"lastName = %@", @"Smith"];
    NSPredicate *thirtiesPredicate = [NSPredicate predicateWithFormat:@"age >= 30"];
    
    // ["Bob Jones"]
    NSLog(@"Bobs: %@", [people filteredArrayUsingPredicate:bobPredicate]);
    
    // ["Alice Smith", "Charlie Smith"]
    NSLog(@"Smiths: %@", [people filteredArrayUsingPredicate:smithPredicate]);
    
    // ["Charlie Smith", "Quentin Alberts"]
    NSLog(@"30's: %@", [people filteredArrayUsingPredicate:thirtiesPredicate]);
}

/*
    %@是对值为字符串，数字或者日期的对象的替换值。
    %K是key path的替换值。
 */
- (void)pathAndStringPredicate {
    NSArray *people = [self peopleArray];
    NSPredicate *ageIs33Predicate = [NSPredicate predicateWithFormat:@"%K = %@",@"age",@33];
    NSLog(@"Age 33: %@",[people filteredArrayUsingPredicate:ageIs33Predicate]);
}

/*
    $VARIABLE_NAME是可以被NSPredicate -predicateWithSubstitutionVariables:替换的值。
 */
- (void)variableNamePredicate {
    NSArray *people = [self peopleArray];
    NSPredicate *namesBeginningWithLetterPredicate = [NSPredicate predicateWithFormat:@"(firstName BEGINSWITH[cd] $letter) OR (lastName BEGINSWITH[cd] $letter)"];
    NSLog(@"'A' Names: %@",[people filteredArrayUsingPredicate:[namesBeginningWithLetterPredicate predicateWithSubstitutionVariables:@{@"letter":@"A"}]]);
    
}

/*
    我们见过与&或被用在谓词格式字符串中以创建复合谓词。然而，我们也可以用NSCompoundPredicate来完成同样的工作。
 */
- (void)compoundPredicate {
    NSArray *people = [self peopleArray];
    NSCompoundPredicate *compoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[[NSPredicate predicateWithFormat:@"age > 25"], [NSPredicate predicateWithFormat:@"firstName = %@", @"Quentin"]]];
    NSLog(@"%@",[people filteredArrayUsingPredicate:compoundPredicate]);
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(age > 25) AND (firstName = %@)", @"Quentin"];
    NSLog(@"compoundPredicate = %@",[people filteredArrayUsingPredicate:predicate]);
}

/*
    NSPredicate其实是由更小的部分而组成：两个NSExpression（一个左手值和一个右手值），和一个运算符相比较（比如<，IN，LIKE等等）。
    NSExpression主要目的是减少表达,在函数，统计，基本运算，高级运算，自定义函数等方面十分有用，
 
    例：
    NSExpression 函数以给定数目的子表达式作为参数,得到集合的标准差:
    NSArray *numbers = @[@1, @2, @3, @4, @4, @5, @9, @11];
    NSExpression *expression = [NSExpression expressionForFunction:@"stddev:" arguments:@[[NSExpression expressionForConstantValue:numbers]]];
    id value = [expression expressionValueWithObject:nil context:nil]; // => 3.21859...
    
    博客：http://nshipster.cn/nsexpression/
 */
- (void)comparisonPredicate {
    NSArray *people = [self peopleArray];
    NSMutableArray *searchItemsPredicate = [NSMutableArray array];
    NSExpression *lhs = [NSExpression expressionForKeyPath:@"firstName"];
    NSExpression *rhs = [NSExpression expressionForConstantValue:@"Bob"];
    
    // NSCaseInsensitivePredicateOption 不区分大小写  相当于 [c],
    //  NSDiacriticInsensitivePredicateOption忽略发音符号 相对于 [d]
    //  NSNormalizedPredicateOption 表示待比较的字符串已经被预处理了.
    NSPredicate *predicate = [NSComparisonPredicate
                                   predicateWithLeftExpression:lhs
                                   rightExpression:rhs
                                   modifier:NSDirectPredicateModifier
                                   type:NSContainsPredicateOperatorType
                                   options:NSCaseInsensitivePredicateOption];
    
    [searchItemsPredicate addObject:predicate];
    NSCompoundPredicate *resultCompoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:searchItemsPredicate];
    NSLog(@"comparisonPredicate = %@",[people filteredArrayUsingPredicate:resultCompoundPredicate]);
}

// Block谓词
- (void)blockPredicate {
    NSArray *people = [self peopleArray];
    NSPredicate *shortNamePredicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [[evaluatedObject firstName] length] <= 5;
    }];
    NSLog(@"Short Names: %@",[people filteredArrayUsingPredicate:shortNamePredicate]);
}
@end
