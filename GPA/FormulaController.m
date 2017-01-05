//
//  FormulaController.m
//  GPA
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "FormulaController.h"

@interface FormulaController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)UITableView *formulaTableView;
@property(nonatomic,retain)UIButton *closeBtn;
@end

@implementation FormulaController

static int const fourFormulaTag = 104;
static int const fiveFormulaTag = 105;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    return self;
}

-(void)addFormulaTableView
{
    _formulaTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height-80) style:UITableViewStylePlain];
    _formulaTableView.delegate = self;
    _formulaTableView.dataSource = self;
    [self ExtraTableViewHidden:_formulaTableView];
    [self.view addSubview:_formulaTableView];

}

-(void)addCloseBtn
{
    _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _closeBtn.frame = CGRectMake(self.view.frame.size.width-60, 40, 40, 30);
    [_closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [_closeBtn setTitleColor:[UIColor colorWithRed:56/255.0 green:151/255.0 blue:250/255.0 alpha:1] forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(closeVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_closeBtn];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addFormulaTableView];
    [self addCloseBtn];
    
}

-(void)ExtraTableViewHidden:(UITableView*)tableview
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    tableview.tableFooterView = view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self jumpToAppstoreForUserFeedback:indexPath];
}

-(void)jumpToAppstoreForUserFeedback:(NSIndexPath*)indexPath
{
    if (indexPath.row == 2) {
        
        NSString *str2 = [NSString stringWithFormat:
                          @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@",
                          @"1082184078"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str2]];

    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *formula = [userDefaults objectForKey:@"Formula"];
    
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    if (indexPath.row == 0)
    {
        UISwitch *fourFormulaSwitch = [[UISwitch alloc]init];
        if ([formula isEqualToString:@"fourFormula"])
        {
            fourFormulaSwitch.on = YES;
        }
        else
        {
            fourFormulaSwitch.on = NO;
        }
        fourFormulaSwitch.tag = fourFormulaTag;
        [fourFormulaSwitch addTarget:self action:@selector(fourFormula:) forControlEvents:UIControlEventValueChanged];
        cell.textLabel.text = @"四分制计算";
        cell.accessoryView = fourFormulaSwitch;
    }
    else if (indexPath.row == 1)
    {
        UISwitch *fiveFormulaSwitch = [[UISwitch alloc]init];
        if ([formula isEqualToString:@"fiveFormula"])
        {
            fiveFormulaSwitch.on = YES;
        }
        else
        {
            fiveFormulaSwitch.on = NO;
        }
        fiveFormulaSwitch.tag = fiveFormulaTag;
        [fiveFormulaSwitch addTarget:self action:@selector(fiveFormula:) forControlEvents:UIControlEventValueChanged];
        cell.textLabel.text = @"五分制计算";
        cell.accessoryView = fiveFormulaSwitch;
    }
    else
    {
        cell.textLabel.text = @"用户反馈";
    }
    return cell;
}

- (void)fiveFormula:(id)sender {
    
    UISwitch *fiveSwitch = (UISwitch*)sender;
    BOOL isOn = [fiveSwitch isOn];
    
    if (isOn)
    {
        [self openFiveFormula];
        
        UISwitch *fourSwitch = [self fourUISwitch];
        fourSwitch.on = NO;

    }
    else
    {
        [self openFourFormula];
        
        UISwitch *fourSwitch = [self fourUISwitch];
        fourSwitch.on = YES;
    }
}

- (void)fourFormula:(id)sender {
    
    UISwitch *fourSwitch = (UISwitch*)sender;
    BOOL isOn = [fourSwitch isOn];
    
    if (isOn)
    {
        [self openFourFormula];
        
        UISwitch *fiveSwitch = [self fiveUISwitch];
        fiveSwitch.on = NO;

    }
    else
    {
        [self openFiveFormula];
        
        UISwitch *fiveSwitch = [self fiveUISwitch];
        fiveSwitch.on = YES;
    }
}

-(void)openFourFormula
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"fiveFormula" forKey:@"Formula"];
}

-(void)openFiveFormula
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"fourFormula" forKey:@"Formula"];

}

-(UISwitch*)fiveUISwitch
{
    return (UISwitch*)[self.view viewWithTag:fiveFormulaTag];
}

-(UISwitch*)fourUISwitch
{
    return (UISwitch*)[self.view viewWithTag:fourFormulaTag];
}



-(void)closeVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
