//
//  ViewController.m
//  NSSort​DescriptorDemo
//
//  Created by 赵清 on 2016/11/13.
//  Copyright © 2016年 赵清. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sortDescriptor];
}

- (void)sortDescriptor {
    NSArray *people = [self peopleArray];
    NSSortDescriptor *firstNameSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES selector:@selector(localizedStandardCompare:)];
    NSSortDescriptor *lastNameSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES selector:@selector(localizedStandardCompare:)];
    NSSortDescriptor *ageSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:NO];
    
    NSLog(@"By age: %@", [people sortedArrayUsingDescriptors:@[ageSortDescriptor]]);
    // "Charlie Smith", "Quentin Alberts", "Bob Jones", "Alice Smith"
    
    
    NSLog(@"By first name: %@", [people sortedArrayUsingDescriptors:@[firstNameSortDescriptor]]);
    // "Alice Smith", "Bob Jones", "Charlie Smith", "Quentin Alberts"
    
    
    NSLog(@"By last name, first name: %@", [people sortedArrayUsingDescriptors:@[lastNameSortDescriptor, firstNameSortDescriptor]]);
    // "Quentin Alberts", "Bob Jones", "Alice Smith", "Charlie Smith"
    
    /* The first descriptor specifies the primary key path to be used in sorting the receiving array’s contents.
        
        有两个时，第一个生效
     */
    
}



@end
