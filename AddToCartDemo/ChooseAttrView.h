//
//  ChooseAttrView.h
//  AddToCartDemo
//
//  Created by a on 17/3/27.
//  Copyright © 2017年 a. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDetail.h"
#import "AttrView.h"

typedef enum{
    ClickTypeAddToCart,    //加入购物车
    ClickTypeBuyImmediately,   //立即购买
    ClickTypeClickChooseAttributeBtn,   //点击选择属性按钮
}ClickType;

@protocol ChooseViewSelectedDelegate <NSObject>
-(void)clickType:(ClickType) clickType andSelectedAttr:(NSMutableArray*)selectedAttrArray andSelectedAttrPrice:(NSString*)price andCount:(NSInteger)count;

@end

@interface ChooseAttrView : UIView<AttrViewClickBtnDelegate>

@property(nonatomic,strong)GoodsDetail* goodsDetail;

@property(nonatomic,strong)NSMutableArray* selectedAttrArray;  //选中的属性
@property(nonatomic,copy)NSString* selectedAttrPrice;  //选好的价格
@property(nonatomic,assign)NSInteger count;  //选好的数量

@property(nonatomic,assign)ClickType clickType;
@property(nonatomic,weak)id<ChooseViewSelectedDelegate>delegate;

-(instancetype)initWithFrame:(CGRect)frame GoodsDetail:(GoodsDetail*)goodsDetail;

-(void)show;
-(void)dismiss;

@end
