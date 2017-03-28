//
//  GoodsDetail.h
//  AddToCartDemo
//
//  Created by a on 17/3/27.
//  Copyright © 2017年 a. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsAttr.h"

@interface GoodsDetail : NSObject
@property(nonatomic,copy)NSString* goods_name;
@property(nonatomic,copy)NSString* goods_thumb;
@property(nonatomic,copy)NSString* goods_price;
@property(nonatomic,strong)NSArray* goods_attr;


@end
