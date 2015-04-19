//
//  CircleClickView.h
//  CircleClickView
//
//  Created by guodong on 15/4/18.
//  Copyright (c) 2015年 guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleClickView : UIView

@property (nonatomic,strong) NSMutableArray *contentArray;

@property (nonatomic,strong) NSMutableArray *pathArray;

@property (nonatomic,assign) int clickWhich;

@property (nonatomic,assign) BOOL isClickCenter;

-(CGMutablePathRef)createPath:(CGMutablePathRef)path withAngle:(float)angle1 andAngle:(float)angle2 andCenter:(CGPoint)center andRadius:(float)radius;
@end
