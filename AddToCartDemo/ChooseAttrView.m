//
//  ChooseAttrView.m
//  AddToCartDemo
//
//  Created by a on 17/3/27.
//  Copyright © 2017年 a. All rights reserved.
//

#import "ChooseAttrView.h"
#import "UIView+Frame.h"
#define AttrBtnTag  100
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ChooseAttrView ()

@property(nonatomic, strong)UIButton *bt_sure;    //确定按钮
@property(nonatomic,strong)UIView* sureView;  //确定view
@property(nonatomic, strong)UIButton *bt_cancle;     //取消
@property(nonatomic, strong)UIView *alphaiView;   //背景图
@property(nonatomic, strong)UIView *whiteView;    //内容图

@property(nonatomic,strong)UIImageView* img;   //图片
@property(nonatomic,strong)UILabel* lb_price;  // 价格
@property(nonatomic,strong)UILabel* lb_detail; //详情

@property(nonatomic,strong)UIScrollView* mainScrollView;
@property(nonatomic,strong)NSMutableArray* attrViewArray; //规格view数组
@property(nonatomic,strong)UIView* countView;  //数量view
@property(nonatomic,strong)UITextField* tf_count;   //数量tf

@end

@implementation ChooseAttrView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame GoodsDetail:(GoodsDetail *)goodsDetail{
    self=[super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        //半透明视图
        self.alphaiView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.alphaiView.backgroundColor = [UIColor blackColor];
        self.alphaiView.alpha = 0.2;
        UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [self.alphaiView addGestureRecognizer:tap];
        [self addSubview:self.alphaiView];
        //装载商品信息的视图
        self.whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, self.frame.size.width, self.frame.size.height-200)];
        self.whiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.whiteView];
        //商品图片
        self.img = [[UIImageView alloc] initWithFrame:CGRectMake(10,10, 80, 80)];
        self.img.backgroundColor = [UIColor whiteColor];
        self.img.layer.cornerRadius = 4;
        self.img.layer.borderColor = [UIColor whiteColor].CGColor;
        self.img.layer.borderWidth = 2;
        [self.img.layer setMasksToBounds:YES];
        [self.whiteView addSubview:self.img];
        //取消按钮
        self.bt_cancle= [UIButton buttonWithType:UIButtonTypeCustom];
        self.bt_cancle.frame = CGRectMake(self.whiteView.frame.size.width-40,10,30, 30);
        [self.bt_cancle setBackgroundImage:[UIImage imageNamed:@"close"] forState:0];
        [self.bt_cancle addTarget:self action:@selector(clickCancleBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteView addSubview:self.bt_cancle];
        //商品价格
        self.lb_price = [[UILabel alloc] initWithFrame:CGRectMake(self.img.frame.origin.x+self.img.frame.size.width+20,10, self.whiteView.frame.size.width-(self.img.frame.origin.x+self.img.frame.size.width+40+40),20)];
        self.lb_price.textColor =[UIColor redColor];
        self.lb_price.font = [UIFont systemFontOfSize:14];
        [self.whiteView addSubview:self.lb_price];
        //用户所选择商品的规格
        self.lb_detail = [[UILabel alloc] initWithFrame:CGRectMake(self.img.frame.origin.x+self.img.frame.size.width+20, self.img.frame.origin.y+self.img.frame.size.height-40, self.whiteView.frame.size.width-(self.img.frame.origin.x+self.img.frame.size.width+40+40), 40)];
        self.lb_detail.numberOfLines = 2;
        self.lb_detail.textColor = [UIColor blackColor];
        self.lb_detail.font = [UIFont systemFontOfSize:14];
        [self.whiteView addSubview:self.lb_detail];
        //分界线
        UILabel* firstLine = [[UILabel alloc] initWithFrame:CGRectMake(0,self.img.frame.origin.y+self.img.frame.size.height+10, self.whiteView.frame.size.width, 0.5)];
        firstLine.backgroundColor = [UIColor lightGrayColor];
        [self.whiteView addSubview:firstLine];
        
        //确定按钮
        self.bt_sure= [UIButton buttonWithType:UIButtonTypeCustom];
        self.bt_sure.frame = CGRectMake(5, self.whiteView.frame.size.height-50,self.whiteView.frame.size.width-10, 48);
        [self.bt_sure setBackgroundColor:[UIColor redColor]];
        self.bt_sure.layer.cornerRadius=5;
        self.bt_sure.clipsToBounds=YES;
        [self.bt_sure setTitleColor:[UIColor whiteColor] forState:0];
        self.bt_sure.titleLabel.font = [UIFont systemFontOfSize:20];
        [self.bt_sure setTitle:@"确定" forState:0];
        [self.bt_sure addTarget:self action:@selector(clickSureBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteView addSubview:self.bt_sure];
        
        //确定view
        _sureView=[[UIView alloc]initWithFrame:CGRectMake(0,self.whiteView.frame.size.height-50,self.whiteView.frame.size.width,50)];
        UIButton* addToCartBtn= [[UIButton alloc]initWithFrame:CGRectMake(0,0,_sureView.bounds.size.width/2, _sureView.bounds.size.height)];
        addToCartBtn.backgroundColor=[UIColor orangeColor];
        [addToCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [addToCartBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        addToCartBtn.titleLabel.font=[UIFont systemFontOfSize:16];
        [addToCartBtn addTarget:self action:@selector(clickAddToCartBtn) forControlEvents:UIControlEventTouchUpInside];
        [_sureView addSubview:addToCartBtn];
        
        UIButton* buyBtn= [[UIButton alloc]initWithFrame:CGRectMake(_sureView.bounds.size.width/2,0,_sureView.bounds.size.width/2, _sureView.bounds.size.height)];
        buyBtn.backgroundColor=[UIColor redColor];
        [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buyBtn.titleLabel.font=[UIFont systemFontOfSize:16];
        [buyBtn addTarget:self action:@selector(clickbuyBtn) forControlEvents:UIControlEventTouchUpInside];
        [_sureView addSubview:buyBtn];
        _sureView.hidden=YES;
        [self.whiteView addSubview:_sureView];
        
        //有的商品尺码和颜色分类特别多 所以用UIScrollView 分类过多显示不全的时候可滑动查看
        UIScrollView* mainscrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0,firstLine.frame.origin.y+firstLine.frame.size.height, self.whiteView.frame.size.width, self.bt_sure.frame.origin.y-(firstLine.frame.origin.y+firstLine.frame.size.height))];
        mainscrollview.showsHorizontalScrollIndicator = NO;
        mainscrollview.showsVerticalScrollIndicator = NO;
        self.mainScrollView=mainscrollview;
        [self.whiteView addSubview:mainscrollview];
        
        //购买数量的视图
        UIView* buyCountView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
        _countView=buyCountView;
        UILabel*lb = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
        lb.text = @"购买数量";
        lb.textColor = [UIColor blackColor];
        lb.font = [UIFont systemFontOfSize:14];
        [buyCountView addSubview:lb];
        
        //加
        UIButton* bt_add= [UIButton buttonWithType:UIButtonTypeCustom];
        bt_add.frame = CGRectMake(self.frame.size.width-10-40, 10,40, 30);
        [bt_add setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
        
        [bt_add setTitleColor:[UIColor blackColor] forState:0];
        bt_add.titleLabel.font = [UIFont systemFontOfSize:20];
        [bt_add setTitle:@"+" forState:0];
        [bt_add addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
        [buyCountView addSubview:bt_add];
        
        //数量
        self.tf_count = [[UITextField alloc] initWithFrame:CGRectMake(bt_add.frame.origin.x -45, 10, 40, 30)];
        self.tf_count.text = @"1";
        self.tf_count.textAlignment = NSTextAlignmentCenter;
        self.tf_count.font = [UIFont systemFontOfSize:15];
        self.tf_count.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        [buyCountView addSubview:self.tf_count];
        //减
        UIButton* bt_reduce= [UIButton buttonWithType:UIButtonTypeCustom];
        bt_reduce.frame = CGRectMake(self.tf_count.frame.origin.x -45, 10, 40, 30);
        [bt_reduce setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
        [bt_reduce setTitleColor:[UIColor blackColor] forState:0];
        bt_reduce.titleLabel.font = [UIFont systemFontOfSize:20];
        [bt_reduce setTitle:@"-" forState:0];
        [bt_reduce addTarget:self action:@selector(reduce) forControlEvents:UIControlEventTouchUpInside];
        [buyCountView addSubview:bt_reduce];
        
        //线
        UILabel *secondLine = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
        secondLine.backgroundColor = [UIColor lightGrayColor];
        [buyCountView addSubview:secondLine];
        [mainscrollview addSubview:buyCountView];
        
        _goodsDetail=goodsDetail;
        _img.image=[UIImage imageNamed:goodsDetail.goods_thumb];
        _lb_price.text=[NSString stringWithFormat:@"￥%@",_goodsDetail.goods_price];
        if (_goodsDetail.goods_attr.count>0) {
            _lb_detail.text=@"请选择商品规格";
        }else{
            _lb_detail.text=@"";
            _selectedAttrPrice=[NSString stringWithFormat:@"￥%@",_goodsDetail.goods_price];
        }
        _tf_count.text=@"1";
        _count=1;
        
        _attrViewArray =[NSMutableArray array];
        float maxY=0.0;
        for (int i=0; i<_goodsDetail.goods_attr.count; i++) {
            GoodsAttr* goodsAttr=[_goodsDetail.goods_attr objectAtIndex:i];
            AttrView* attrView=[[AttrView alloc]initWithFrame:CGRectMake(0, maxY, self.frame.size.width,50) andGoodAttr:goodsAttr];
            attrView.delegate=self;
            [self.mainScrollView addSubview:attrView];
            [_attrViewArray addObject:attrView];
            maxY=attrView.y+attrView.height;
        }
        
        self.countView.frame = CGRectMake(0,maxY,self.width, 50);
        self.mainScrollView.contentSize = CGSizeMake(self.width, self.countView.height+self.countView.y);
    }
    return self;
}

-(void)clickAttrViewBtn{
    //价格
    double price=[_goodsDetail.goods_price floatValue];
    NSString* selectedAttibute=@"已选择";
    for (AttrView* attrView in self.attrViewArray) {
        if (attrView.selectedBtn) {
            Attr* attr=attrView.goodsAttr.attr[attrView.selectedBtn.tag-AttrBtnTag];
            price+=[attr.attr_price doubleValue];
            selectedAttibute=[selectedAttibute stringByAppendingString:[NSString stringWithFormat:@" \"%@\" ",attr.attr_name]];
        }
    }
    
    self.lb_price.text=[NSString stringWithFormat:@"￥%.2f",price];
    self.lb_detail.text=selectedAttibute;
    
    int i=0;
    for (AttrView* attrView in self.attrViewArray) {
        if (attrView.selectedBtn) {
            i++;
        }
    }
    
    if (i==0) {
        self.lb_detail.text=@"请选择商品规格";
        self.lb_price.text=[NSString stringWithFormat:@"￥%@",_goodsDetail.goods_price];
    }
    
    if (i==self.attrViewArray.count) {
        if (!_selectedAttrArray) {
            _selectedAttrArray=[NSMutableArray array];
        }
        for (AttrView* attrView in self.attrViewArray) {
            Attr* attr=attrView.goodsAttr.attr[attrView.selectedBtn.tag-AttrBtnTag];
            [_selectedAttrArray addObject: attr];
        }
        _selectedAttrPrice=[NSString stringWithFormat:@"%.2lf",price];
    }else{
        _selectedAttrArray=nil;
        _selectedAttrPrice=nil;
    }
}

#pragma mark-数量加减
-(void)add
{
    int count =[self.tf_count.text intValue];
    self.tf_count.text = [NSString stringWithFormat:@"%d",count+1];
    self.count=[self.tf_count.text intValue];
}
-(void)reduce
{
    int count =[self.tf_count.text intValue];
    if (count > 1) {
        self.tf_count.text = [NSString stringWithFormat:@"%d",count-1];
    }else{
        NSLog(@"商品数量为1，不能再减了");
    }
    self.count=[self.tf_count.text intValue];
}

#pragma mark-外部接口
-(void)show{
    
    if (_clickType==ClickTypeAddToCart||_clickType==ClickTypeBuyImmediately) {
        _sureView.hidden=YES;
        _bt_sure.hidden=NO;
    }else if(_clickType==ClickTypeClickChooseAttributeBtn){
        _sureView.hidden=NO;
        _bt_sure.hidden=YES;
    }
    
    [UIView animateWithDuration: 0.5 animations: ^{
        self.frame =CGRectMake(0, 0,kScreenWidth,kScreenHeight);
    } completion: nil];
}

-(void)dismiss{
    
    [UIView animateWithDuration: 0.5 animations: ^{
        self.frame =CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
    } completion: nil];
}

//点击背景
-(void)tapAction{
    [self dismiss];
}
//点击cancle
-(void)clickCancleBtn{
    [self dismiss];
}

//点击确定
-(void)clickSureBtn{
    
    if (_goodsDetail.goods_attr&&!_selectedAttrArray) {
        NSLog(@"请选择商品属性");
        return;
    }
    [self dismiss];
    [self.delegate clickType:_clickType andSelectedAttr:_selectedAttrArray andSelectedAttrPrice:_selectedAttrPrice andCount:_count];
}

//点击购物车
-(void)clickAddToCartBtn{
    if (_goodsDetail.goods_attr&&!_selectedAttrArray) {
        NSLog(@"请选择商品属性");
        return;
    }
    [self dismiss];
    _clickType=ClickTypeAddToCart;
    [self.delegate clickType:_clickType andSelectedAttr:_selectedAttrArray andSelectedAttrPrice:_selectedAttrPrice andCount:_count];
}
//点击立即购买
-(void)clickbuyBtn{
    if (_goodsDetail.goods_attr&&!_selectedAttrArray) {
        NSLog(@"请选择商品属性");
        return;
    }
    [self dismiss];
    _clickType=ClickTypeBuyImmediately;
    [self.delegate clickType:_clickType andSelectedAttr:_selectedAttrArray andSelectedAttrPrice:_selectedAttrPrice andCount:_count];
}

@end
