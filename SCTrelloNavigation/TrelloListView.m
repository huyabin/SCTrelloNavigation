//
//  TrelloListView.m
//  SCTrelloNavigation
//
//  Created by Yh c on 15/11/5.
//  Copyright © 2015年 Yh c. All rights reserved.
//

#import "TrelloListView.h"

@implementation TrelloListView

- (id)initWithFrame:(CGRect)frame index:(NSInteger)index listArray:(NSArray *)listItems
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;

        self.contentSize = CGSizeMake(listItems.count * (ScreenWidth - 45.0f), self.height);
        self.contentOffset = CGPointMake(0.0f, 0.0f);
        
        self.pagingEnabled = YES;
        self.originTop = self.top;
        self.isFoldMode = NO;
        self.bouncesZoom = NO;
        self.bounces = YES;
        self.alwaysBounceVertical = NO;
        self.alwaysBounceHorizontal = NO;
        
        self.reusableTableViewArray = [NSMutableArray array];
        self.visibleTableViewArray = [NSMutableArray array];
        self.currentIndex = index;
        
        self.listItems = [listItems mutableCopy];
        
        self.tableView = [[TrelloListTableView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, ScreenWidth - 60.0f, self.height) style:UITableViewStylePlain listItem:[listItems objectAtIndex:0]];
        
        //注：这里高度加30是随便加的，高度会在往上滑动的过程中修复
        
        //注：换成grouped效果也不错 = =
        
        _tableView.tag = 10001;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.layer.cornerRadius = 5.0f;
        _tableView.layer.masksToBounds = YES;
        
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        [self addSubview:_tableView];
        
        [self.visibleTableViewArray addObject:_tableView];
        
        CGFloat nextX = self.tableView.right + 15.0f;
        for(NSInteger i=1;i<5;i++)
        {
            TrelloListTableView *t_tableView = [[TrelloListTableView alloc]initWithFrame:CGRectMake(nextX, 0.0f, ScreenWidth - 60.0f, self.height) style:UITableViewStylePlain listItem:[listItems objectAtIndex:i]];
            t_tableView.tag = 10001 + i;
            t_tableView.delegate = self;
            t_tableView.dataSource = self;
            t_tableView.backgroundColor = [UIColor clearColor];
            t_tableView.layer.cornerRadius = 5.0f;
            t_tableView.layer.masksToBounds = YES;
            t_tableView.showsHorizontalScrollIndicator = NO;
            t_tableView.showsVerticalScrollIndicator = NO;
            [self addSubview:t_tableView];
            nextX = t_tableView.right + 15.0f;
            
            [self.visibleTableViewArray addObject:t_tableView];
        }
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (tableView.tag) {
        case 10001:
        {
            return [(TrelloListTableView *)tableView listItem].rowNumber;
        }
            break;
        default:
        {
            return [(TrelloListTableView *)tableView listItem].rowNumber;
        }
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    switch (tableView.tag) {
        case 10001:
        {
            return 1;
        }
            break;
        default:
        {
            return 1;
        }
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (tableView.tag) {
        case 10001:
        {
            return 60.0f;
        }
            break;
        default:
        {
            return 60.0f;
        }
            break;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TrelloListTableView *t_tableView = (TrelloListTableView *)tableView;
    if(!t_tableView.trelloListHeaderView)
    {
        UIView *t_view = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, t_tableView.width, 60.0f)];
        t_view.backgroundColor = Global_trelloGray;
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:t_view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = t_view.bounds;
        maskLayer.path = maskPath.CGPath;
        t_view.layer.mask = maskLayer;
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(30.0f, 20.0f, t_tableView.width - 60.0f, 20.0f)];
        titleLabel.textColor = [UIColor darkTextColor];
        titleLabel.font = [UIFont systemFontOfSize:16.0f];
        titleLabel.text = t_tableView.listItem.title;
        [t_view addSubview:titleLabel];
        
        t_tableView.trelloListHeaderView = t_view;
    }
    return t_tableView.trelloListHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (tableView.tag) {
        case 10001:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_1"];
            if(!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_1"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.textLabel.text = @"fuck";
            return cell;
        }
            break;
        default:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_default"];
            if(!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_default"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.textLabel.text = @"fuck";
            return cell;
        }
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (tableView.tag) {
        case 10001:
        {
            return 80.0f;
        }
            break;
        default:
        {
            return 80.0f;
        }
            break;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"size height: %f and offest y :%f",scrollView.contentInset.top,scrollView.contentOffset.y);
    if(scrollView.contentOffset.y > 0.0f)
    {
        if(!_isFoldMode)
        {
            if(self.HeaderDidFoldedCallBack)
            {
                self.HeaderDidFoldedCallBack();
            }
        }
    }
    else if(scrollView.contentOffset.y < 0.0f)
    {
        if(_isFoldMode)
        {
            if(self.HeaderDidFoldedCallBack)
            {
                self.HeaderDidFoldedCallBack();
            }
        }
    }
}
@end
