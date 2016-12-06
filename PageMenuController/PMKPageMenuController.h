/*****************************************************************************
 *
 * FILE:	PMKPageMenuController.h
 * DESCRIPTION:	PageMenuKit: Paging Menu View Controller
 * DATE:	Tue, Nov 22 2016
 * UPDATED:	Tue, Dec  6 2016
 * AUTHOR:	Kouichi ABE (WALL) / 阿部康一
 * E-MAIL:	kouichi@MagickWorX.COM
 * URL:		http://www.MagickWorX.COM/
 * COPYRIGHT:	(c) 2016 阿部康一／Kouichi ABE (WALL), All rights reserved.
 * LICENSE:
 *
 *  Copyright (c) 2016 Kouichi ABE (WALL) <kouichi@MagickWorX.COM>,
 *  All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions
 *  are met:
 *
 *   1. Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *
 *   2. Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *
 *   THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
 *   ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 *   THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 *   PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
 *   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 *   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 *   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 *   INTERRUPTION)  HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 *   CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 *   ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
 *   THE POSSIBILITY OF SUCH DAMAGE.
 *
 * $Id: PMKPageMenuController.h,v 1.1 2016/07/05 05:40:27 kouichi Exp $
 *
 *****************************************************************************/

@import Foundation;
@import UIKit;

typedef NS_ENUM(NSInteger, PMKPageMenuControllerStyle) {
  PMKPageMenuControllerStylePlain,	// like NewsPass
  PMKPageMenuControllerStyleTab,	// like Gunosy
  PMKPageMenuControllerStyleSmartTab,	// like SmartNews
  PMKPageMenuControllerStyleHackaTab	// like Hackadoll
};

@protocol PMKPageMenuControllerDelegate;

@class PMKMenuItem;

@interface PMKPageMenuController : UIViewController

@property (nonatomic,weak) id <PMKPageMenuControllerDelegate>	delegate;

@property (nonatomic,readonly) PMKPageMenuControllerStyle	menuStyle;

@property (nonatomic,strong,readonly) NSArray *	titles;
@property (nonatomic,strong,readonly) NSArray *	childControllers;
@property (nonatomic,strong,readonly) NSArray *	menuColors;

-(instancetype)initWithControllers:(NSArray<UIViewController *> *)controllers
			 menuStyle:(PMKPageMenuControllerStyle)menuStyle
			menuColors:(NSArray<UIColor *> *)menuColors
		      topBarHeight:(CGFloat)topBarHeight;

-(instancetype)initWithControllers:(NSArray<UIViewController *> *)controllers
			 menuStyle:(PMKPageMenuControllerStyle)menuStyle
		      topBarHeight:(CGFloat)topBarHeight;

@end

@protocol PMKPageMenuControllerDelegate <NSObject>
@optional
-(void)pageMenuController:(PMKPageMenuController *)pageMenuController
 willMoveToViewController:(UIViewController *)viewController
	      atMenuIndex:(NSUInteger)index;
-(void)pageMenuController:(PMKPageMenuController *)pageMenuController
  didMoveToViewController:(UIViewController *)viewController
	      atMenuIndex:(NSUInteger)index;

-(void)pageMenuController:(PMKPageMenuController *)pageMenuController
      didPrepareMenuItems:(NSArray<PMKMenuItem *> *)menuItems;
-(void)pageMenuController:(PMKPageMenuController *)pageMenuController
	didSelectMenuItem:(PMKMenuItem *)menuItem
	      atMenuIndex:(NSUInteger)index;
@end


@interface PMKMenuItem : NSObject
@property (nonatomic,copy) NSString *	title;	// set automatically
@property (nonatomic,assign) NSInteger	tag;	// default: 0
@property (nonatomic,copy) NSString *	badgeValue; // default: nil
@property (nonatomic,strong) UIColor *	titleColor; // set automatically
@property (nonatomic,strong) UIColor *	backgroundColor; // set automatically
@property (nonatomic,getter=isEnabled) BOOL	enabled; // default: YES
@property (nonatomic,readonly,getter=isSelected) BOOL	selected; // default: NO
@property (nonatomic,readonly) PMKPageMenuControllerStyle	menuStyle;
@end
