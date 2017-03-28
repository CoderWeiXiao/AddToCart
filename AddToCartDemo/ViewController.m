//
//  ViewController.m
//  AddToCartDemo
//
//  Created by a on 17/3/27.
//  Copyright © 2017年 a. All rights reserved.
//

#import "ViewController.h"
#import "GoodsDetail.h"
#import "GoodsAttr.h"
#import "Attr.h"
#import "ChooseAttrView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<ChooseViewSelectedDelegate>
@property(nonatomic,strong)GoodsDetail* goodsDetail;
@property(nonatomic,strong)ChooseAttrView* chooseView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //京东，淘宝， 苏宁易购的 选择商品属性的逻辑不一样。
    
    
    [self creatFakeData];
    
    [self initChooseView];
    
}

-(void)creatFakeData{
    _goodsDetail=[GoodsDetail new];
    _goodsDetail.goods_name=@"商品名称";
    _goodsDetail.goods_price=@"100";
    _goodsDetail.goods_thumb=@"图片地址";
    
    GoodsAttr* goodsArrt1=[GoodsAttr new];
    goodsArrt1.title=@"颜色";
    
    Attr* attr1=[Attr new];
    attr1.attr_name=@"白色";
    attr1.attr_price=@"0";
    attr1.attr_id=@"1";
    
    Attr* attr2=[Attr new];
    attr2.attr_name=@"黑色";
    attr2.attr_price=@"10";
    attr2.attr_id=@"2";
    
    Attr* attr3=[Attr new];
    attr3.attr_name=@"银色";
    attr3.attr_price=@"20";
    attr3.attr_id=@"3";
    
    Attr* attr4=[Attr new];
    attr4.attr_name=@"红色";
    attr4.attr_price=@"30";
    attr4.attr_id=@"4";
    
    Attr* attr5=[Attr new];
    attr5.attr_name=@"蓝色";
    attr5.attr_price=@"50";
    attr5.attr_id=@"5";
    
    goodsArrt1.attr=@[attr1,attr2,attr3,attr4,attr5];
    
    GoodsAttr* goodsArrt2=[GoodsAttr new];
    goodsArrt2.title=@"配置";
    
    Attr* attr6=[Attr new];
    attr6.attr_name=@"14寸4G内存，128G固态硬盘，intel i5";
    attr6.attr_price=@"0";
    attr6.attr_id=@"6";
    
    Attr* attr7=[Attr new];
    attr7.attr_name=@"14寸4G内存，256G固态硬盘，intel i7";
    attr7.attr_price=@"100";
    attr7.attr_id=@"7";
    
    Attr* attr8=[Attr new];
    attr8.attr_name=@"15寸8G内存，128G固态硬盘，intel i5";
    attr8.attr_price=@"200";
    attr8.attr_id=@"8";
    
    Attr* attr9=[Attr new];
    attr9.attr_name=@"15寸8G内存，256G固态硬盘，intel i7";
    attr9.attr_price=@"300";
    attr9.attr_id=@"9";
    
    goodsArrt2.attr=@[attr6,attr7,attr8,attr9];
  
    _goodsDetail.goods_attr=@[goodsArrt1,goodsArrt2];
}

-(void)initChooseView{
    ChooseAttrView* chooseView=[[ChooseAttrView alloc]initWithFrame:CGRectMake(0,kScreenHeight,kScreenWidth, kScreenHeight) GoodsDetail:_goodsDetail];
    chooseView.delegate=self;
    _chooseView=chooseView;
    [self.view addSubview:chooseView];
}


-(void)clickType:(ClickType)clickType andSelectedAttr:(NSMutableArray *)selectedAttrArray andSelectedAttrPrice:(NSString *)price andCount:(NSInteger)count{

    for (Attr* attr in selectedAttrArray) {
        NSLog(@"attr:%@",attr.attr_name);
    }
    
    NSLog(@"type:%u",clickType);
    
    NSLog(@"price:%@",price);
    
    NSLog(@"count:%ld",count);
}

- (IBAction)clickChooseAttrBtn:(id)sender {
    _chooseView.clickType=ClickTypeClickChooseAttributeBtn;
    [_chooseView show];
}

- (IBAction)clickAddToCartBtn:(id)sender {
    _chooseView.clickType=ClickTypeAddToCart;
    [_chooseView show];
}

- (IBAction)clickBuyImmiditelyBtn:(id)sender {
    _chooseView.clickType=ClickTypeBuyImmediately;
    [_chooseView show];
}

@end
