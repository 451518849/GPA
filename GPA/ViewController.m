//
//  ViewController.m
//  GPA
//
//  Created by apple on 16/1/23.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"
#import "GradeCell.h"
#import "myButton.h"
#import "FormulaController.h"
#import "Calculator.h"
#import "Validator.h"
#import "PopView.h"
#import "MBProgressHUD.h"
@interface ViewController ()
@property(nonatomic,strong)UIView *GPAView;
@property(nonatomic,strong)UIScrollView *backgroundScrollView;
@property(nonatomic,strong)UIButton *leftBarButton;
@property(nonatomic,strong)UIButton *rightBarButton;
@property(nonatomic,strong)myButton *calculateBtton;
@property(nonatomic,strong)UILabel *GPALabel;
@property(nonatomic,strong)UILabel *GPALevelLabel;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)GradeCell *cell;

@property(nonatomic,strong)UIView *popView;
@property(nonatomic,assign)BOOL isPopView;
@property(nonatomic,strong)UIPageControl *formulaControl;

@property(nonatomic,strong)NSMutableArray *gradesArray;
@property(nonatomic,strong)NSMutableArray *creditsArray;
@property(nonatomic,assign)int cellCount;
@property(nonatomic,assign)double GPA;

@property(nonatomic,strong)Calculator *calculateGPA;

@end

@implementation ViewController

static int const formulaControllerTag = 100;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    return self;
}

#pragma mark  handle all UI components

-(void)addTapGesture
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeKeyyBoard)];
    [_tableView addGestureRecognizer:tapGesture];
    [_backgroundScrollView addGestureRecognizer:tapGesture];
    
    
}

-(void)addBackgroundScrollView
{
    _backgroundScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view  addSubview:_backgroundScrollView];
    
    
}

-(void)addTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 130)];
    
    _tableView.delegate         = self;
    _tableView.dataSource       = self;
    _tableView.scrollEnabled    = NO;
    [self setExtraCellLineHidden:_tableView];
    [_backgroundScrollView  addSubview:_tableView];
    
}

-(void)addCalculateButton
{
    _calculateBtton = [[myButton alloc]initWithFrame:CGRectMake(0, 0, 175, 37)];
    _calculateBtton.layer.cornerRadius = 20;
    _calculateBtton.center = CGPointMake(self.view.center.x, 200);
    
    [_calculateBtton setTitle:@"平均绩点" forState:UIControlStateNormal];
    [_calculateBtton setBackgroundColor:[UIColor colorWithRed:56/255.0 green:151/255.0 blue:250/255.0 alpha:1]];
    [_calculateBtton addTarget:self
                        action:@selector(calculate)
              forControlEvents:UIControlEventTouchUpInside];
    [_backgroundScrollView  addSubview:_calculateBtton];
    
}

-(void)addBarButtonItem
{
    _leftBarButton  = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 42, 35)];
    _rightBarButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 42, 35)];
    _leftBarButton.tag = formulaControllerTag;
    
    [_leftBarButton setTitle:@"<" forState:UIControlStateNormal];
    _leftBarButton.titleLabel.font = [UIFont systemFontOfSize:30.0f];
    
    [_rightBarButton setTitle:@"+" forState:UIControlStateNormal];
    _rightBarButton.titleLabel.font = [UIFont systemFontOfSize:30.0f];
    
    [_leftBarButton addTarget:self
                       action:@selector(gotoChooseFormulaVC:)
             forControlEvents:UIControlEventTouchUpInside];
    [_rightBarButton addTarget:self
                        action:@selector(addGradeCell)
              forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarItem   = [[UIBarButtonItem alloc]initWithCustomView:_rightBarButton];
    UIBarButtonItem *leftBarItem    = [[UIBarButtonItem alloc]initWithCustomView:_leftBarButton];
    
    self.navigationItem.leftBarButtonItem   = leftBarItem;
    self.navigationItem.rightBarButtonItem  = rightBarItem;
    
}

-(void)addIntroducationButton
{
    UIButton *introducation = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-90, self.view.frame.size.height-105, 80, 30)];
    [introducation setTitleColor:[UIColor colorWithRed:56/255.0 green:151/255.0 blue:250/255.0 alpha:1] forState:UIControlStateNormal];
    [introducation addTarget:self action:@selector(gotoIntroductionVC) forControlEvents:UIControlEventTouchUpInside];
    [introducation setTitle:@"软件使用说明" forState:UIControlStateNormal];
    introducation.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [_backgroundScrollView  addSubview:introducation];
    
    
}

-(void)addToplabel
{
    UILabel *toplabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 15)];
    toplabel.text = @"期末了，赶紧来算算你的绩点吧";
    toplabel.textAlignment = NSTextAlignmentCenter;
    toplabel.textColor = [UIColor colorWithRed:56/255.0 green:151/255.0 blue:250/255.0 alpha:1];
    toplabel.font = [UIFont systemFontOfSize:13.0f];
    toplabel.center = CGPointMake(self.view.center.x, 10);
    [_backgroundScrollView  addSubview:toplabel];
    
}

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

#pragma mark viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cellCount = 1;
    _GPA = 0;
    self.title = @"GPA";
    self.view.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    
    _calculateGPA = [[Calculator alloc]init];
    _gradesArray    = [[NSMutableArray alloc]init];
    _creditsArray   = [[NSMutableArray alloc]init];
    
    [_gradesArray addObject:@""];
    [_creditsArray addObject:@""];

    [self addBackgroundScrollView];
    [self addTableView];
    [self addToplabel];
    [self addCalculateButton];
    [self addBarButtonItem];
    [self addIntroducationButton];
    
    [self addTapGesture];

}

#pragma mark handle main logic

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _cellCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellIdentifier = @"gradeCell";
     _cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!_cell)
    {
        _cell = [[[NSBundle mainBundle]loadNibNamed:@"GradeCell" owner:nil options:nil]firstObject];
    }
    
    _cell.grade.delegate = self;
    _cell.credit.delegate = self;
    
    _cell.grade.tag = [self setGradeCellTagBy:indexPath];
    _cell.credit.tag = [self setCreditCellTagBy:indexPath];
    
    _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return _cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [self closeKeyyBoard];
}

//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return NO;
    }
    return YES;
}


//进入编辑模式，按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete)
    {
        
        [self removeSelectedTableViewCell];
        
        // 删除单元格的某一行时，在用动画效果实现删除过程
        [self deleteSelectedTableViewCell:tableView indexPath:indexPath];

    }
}

#pragma mark return or done key
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        _backgroundScrollView.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    _backgroundScrollView.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

//失去焦点后，获取更改后的值
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;
{

    if ([self isNumber:textField])
    {
            [self alertTextIsNotNumber];
            return NO;
    }
    
    [self saveTextFieldNumberToArray:textField];
    
    return YES;
}


//计算平局绩点
-(void)calculate
{

    [self closeKeyyBoard];
    
    _calculateGPA = [[Calculator alloc]init];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if([self isFiveFormula:userDefaults]) //五分制
    {
        [self calculateByfiveFormula];
    }
    else //四分制
    {
        [self calculateByFourFormula];
    }
    
    if (_GPA == 0)
    {
        [self alertGradeOrCreditIsNull];
        return;
    }
    
    NSString *level = [_calculateGPA calculateForGPALevel:_GPA];
    
    [self showGPA:_GPA andLevel:level];
    
}

#pragma mark all refactor method

-(void)showGPA:(double)gpa andLevel:(NSString*)level;
{
    [_GPAView removeFromSuperview];

    UILabel *GPALabel       = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-70, 10, 150, 20)];
    UILabel *GPALevelLabel  = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-70, 40, 150, 20)];
    _GPAView = [[UIView alloc]initWithFrame:CGRectMake(0, _tableView.frame.size.height-70, self.view.frame.size.width,70)];
    
    GPALabel.text = [NSString stringWithFormat:@"平均绩点：%.2f",_GPA] ;
    GPALevelLabel.text      = [NSString stringWithFormat: @"绩点等级：%@",level];
    
    GPALabel.textColor      = [UIColor colorWithRed:56/255.0 green:151/255.0 blue:250/255.0 alpha:1];
    GPALevelLabel.textColor = [UIColor colorWithRed:56/255.0 green:151/255.0 blue:250/255.0 alpha:1];
    
    
    [_GPAView addSubview:GPALabel];
    [_GPAView addSubview:GPALevelLabel];
    [_tableView addSubview:_GPAView];
}

-(void)addGradeCell
{
    [_GPAView removeFromSuperview];
    [self closeKeyyBoard];

    //将新增加的cell上的值，添加到数组中，失去焦点的时候替换
    [_gradesArray addObject:@""];
    [_creditsArray addObject:@""];

    _cellCount++;
    _tableView.frame =CGRectMake(0, 20, self.view.frame.size.width, 100+_cellCount*45);
    _calculateBtton.center = CGPointMake(self.view.center.x,  200+_cellCount*45);
    _backgroundScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 200+_cellCount*70);
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:_cellCount-1 inSection:0];
    [_tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];

}

-(void)removeSelectedTableViewCell
{
    _cellCount--;
    [_GPAView removeFromSuperview];
    _tableView.frame =CGRectMake(0, 20, self.view.frame.size.width, 100+_cellCount*45);
    _calculateBtton.center = CGPointMake(self.view.center.x,  200+_cellCount*45);
    
}

-(void)deleteSelectedTableViewCell:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath
{
    
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    if (_gradesArray.count > indexPath.row)
    {
        [_gradesArray removeObjectAtIndex:indexPath.row];
        [_creditsArray removeObjectAtIndex:indexPath.row];
        
    }
    
}


-(NSInteger)setGradeCellTagBy:(NSIndexPath*)indexPath
{
    return indexPath.row*2+1;
}

-(NSInteger)setCreditCellTagBy:(NSIndexPath*)indexPath
{
    return indexPath.row*2+2;
}



-(BOOL)isNumber:(UITextField*)textField
{
    return ![Validator validateNumber:textField.text] && ![textField.text isEqualToString:@""];
}

-(BOOL)isCreditText:(UITextField*)textField
{
    return textField.tag%2 == 0;
}

-(BOOL)isInvalidGradeNumber:(UITextField*)textField
{
    return [textField.text doubleValue] >= 0 && [textField.text doubleValue] < 60;
}

-(BOOL)isLegalGradeNumber:(UITextField*)textField
{
    return [textField.text doubleValue] < 0 || [textField.text doubleValue] > 100;
}

-(void)addCreditToArray:(UITextField*)textField
{
    [_creditsArray replaceObjectAtIndex:(textField.tag-2)/2 withObject:textField.text];
}

-(void)addInvalidGradeToArray:(UITextField*)textField
{
    [_gradesArray replaceObjectAtIndex:(textField.tag-1)/2 withObject:@"50"];
}

-(void)addGradeToArray:(UITextField*)textField
{
    [_gradesArray replaceObjectAtIndex:(textField.tag-1)/2 withObject:textField.text];
}

-(void)changeCellBackgroundByGrade:(UITextField*)textField
{
    //改变textfeild的背景颜色
    UITableViewCell *cell = (UITableViewCell*)textField.superview;
    [_calculateGPA changeColorForTextFeild:textField andGrade:textField.text andCell:cell];
}

-(void)saveTextFieldNumberToArray:(UITextField*)textField
{
    if([self isCreditText:textField])  //绩点
    {
        [self addCreditToArray:textField];
    }
    else
    {
        if ([self isInvalidGradeNumber:textField])  //成绩小于60，不加入计算
        {
            
            [self addInvalidGradeToArray:textField];
        }
        else if ([self isLegalGradeNumber:textField])
        {
            [self alertIsnNotLegalGradeNumber];
        }
        else  //成绩
        {
            [self addGradeToArray:textField];
        }
    }
    
}

//关闭所有键盘
- (void)closeKeyyBoard
{
    for (int i = 1; i <= 2*_creditsArray.count+2; i++)
    {
        UITextField *textfeild = (UITextField*)[self.view viewWithTag:i];
        [textfeild resignFirstResponder];
    }
}

-(BOOL)isFiveFormula:(NSUserDefaults*)userDefaults
{
    return [[userDefaults objectForKey:@"Formula"] isEqualToString:@"fiveFormula"];
}

-(void)calculateByfiveFormula
{
    _GPA = [_calculateGPA calculateWithFivePointSystem:_gradesArray credit:_creditsArray];
}

-(void)calculateByFourFormula
{
    _GPA = [_calculateGPA calculateWithFourPointSystem:_gradesArray credit:_creditsArray];
}


-(void)alertTextIsNotNumber
{

    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.labelText = @"提示";
    hub.detailsLabelText = @"数字格式不正确";
    hub.mode = MBProgressHUDModeText;
    hub.animationType = MBProgressHUDAnimationZoom;
    [hub show:YES];
    [hub hide:YES afterDelay:2];
}

-(void)alertIsnNotLegalGradeNumber
{
    
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.labelText = @"提示";
    hub.detailsLabelText = @"成绩应该在0～100之间哦";
    hub.mode = MBProgressHUDModeText;
    hub.animationType = MBProgressHUDAnimationZoom;
    [hub show:YES];
    [hub hide:YES afterDelay:2];
}

-(void)alertGradeOrCreditIsNull
{
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.labelText = @"提示";
    hub.detailsLabelText = @"请填写完成绩和学分";
    hub.mode = MBProgressHUDModeText;
    hub.animationType = MBProgressHUDAnimationZoom;
    [hub show:YES];
    [hub hide:YES afterDelay:2];
    
}

-(void)gotoChooseFormulaVC:(UIButton*)button
{
     FormulaController *controller = [[FormulaController alloc]init];
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark---------弹出动画部分
-(void)gotoIntroductionVC
{
    PopView *popView = [[PopView alloc]init];
    popView.popView = _popView;
    popView.isPopView = _isPopView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
