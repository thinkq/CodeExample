# UILocalizedIndexedCollation
使用UILocalizedIndexedCollation

### 通过实现下列 UITableViewDataSource 中的方法来显示区域索引标题

-sectionIndexTitlesForTableView: —— 返回一个区域索引标题的数组，用于在列表右边显示，例如字母序列 A...Z 和 #。区域索引标题很短，通常不能多于两个 Unicode 字符。

-tableView:sectionForSectionIndexTitle:atIndex: —— 返回当用户触摸到某个索引标题时列表应该跳至的区域的索引。

### UILocalizedIndexedCollation 来拯救我们了
UILocalizedIndexedCollation 是一个帮助我们组织列表数据的类，它能够根据地区来生成与之对应区域索引标题。不需要直接创建它的对象，我们可以通过 UILocalizedIndexedCollation +currentCollation 获得一个对应当前地区的单例对象。

UILocalizedIndexedCollation 的首要任务就是决定对于当前地区区域索引标题应该是什么，我们可以通过 sectionIndexTitles 属性来获得它们。

#### 有了你面前的这些区域标题，下一步就是判断每个模型对象分别对应哪个区域了。这可以通过实现 -sectionForObject:collationStringSelector: 做到。这个方法返回 NSInteger 类型的索引，它对应了模型对象的指定方法的返回值。方法名称可以为 localizedName、title 甚至 description 等。

显而易见，列表数据源中会有一个数组，它对应了列表中有多少区域，数组元素表示区域中的每一行。由于整理工作是由 UILocalizedIndexedCollation 来做的，因此理所当然地，也应该由它来为每个区域中的行进行排序。和 -sectionForObject:collationStringSelector: 的实现方式类似，– sortedArrayFromArray:collationStringSelector: 可以为我们基于模型对象的本地化标题来排列模型对象。

最后，数据源应该实现 -tableView:sectionForSectionIndexTitle:atIndex: 方法，这样当我们触摸到区域索引标题时，能够让列表调至对应的区域。UILocalizedIndexedCollation -sectionForSectionIndexTitleAtIndex: 可以轻松帮我们做到。

### UITableViewIndexSearch
有一个特殊的区域索引标题需要提一下：UITableViewIndexSearch。列表中一般同时会有搜索框和区域索引。为了方便同时也保持视觉上的一致性，通常第一个区域索引处会放个搜索图标，当你触摸这个图标时，列表会滑至顶部的搜索框区域。

为了在列表右边可以看到搜索图标，你需要把 UITableViewIndexSearch 这个 NSString 常量插入到 -sectionIndexTitlesForTableView: 返回值的前边，并且调整 -tableView:sectionForSectionIndexTitle:atIndex: 使得它返回正确的区域索引。



