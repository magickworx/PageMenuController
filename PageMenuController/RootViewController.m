/*****************************************************************************
 *
 * FILE:	RootViewController.m
 * DESCRIPTION:	PageMenuControllerDemo: Application Root View Controller
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
 * $Id: RootViewController.m,v 1.1 2016/01/28 12:40:37 kouichi Exp $
 *
 *****************************************************************************/

#import "PMKPageMenuController.h"
#import "RootViewController.h"
#import "DataViewController.h"

@interface RootViewController () <PMKPageMenuControllerDelegate>
@property (nonatomic,strong) PMKPageMenuController *	pageMenuController;
@end

@implementation RootViewController

-(id)init
{
  self = [super init];
  if (self) {
    self.title = NSLocalizedString(@"PageMenuKitDemo", @"");
  }
  return self;
}

-(void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(void)loadView
{
  [super loadView];

  NSMutableArray *    controllers = [NSMutableArray new];
  NSDateFormatter * dateFormatter = [NSDateFormatter new];
  NSArray *	     monthSymbols = [dateFormatter monthSymbols];
  for (NSString * month in monthSymbols) {
    DataViewController * vc = [DataViewController new];
    vc.title = month;
    [controllers addObject:vc];
  }

  CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
#if	MENU_STYLE_PLAIN
  PMKPageMenuControllerStyle menuStyle = PMKPageMenuControllerStylePlain;
#elif	MENU_STYLE_TAB
  PMKPageMenuControllerStyle menuStyle = PMKPageMenuControllerStyleTab;
#elif	MENU_STYLE_SMART
  PMKPageMenuControllerStyle menuStyle = PMKPageMenuControllerStyleSmartTab;
#elif	MENU_STYLE_HACKA
  PMKPageMenuControllerStyle menuStyle = PMKPageMenuControllerStyleHackaTab;
#else
  PMKPageMenuControllerStyle menuStyle = PMKPageMenuControllerStylePlain;
#endif
  PMKPageMenuController * pageMenuController;
  pageMenuController = [[PMKPageMenuController alloc]
			initWithControllers:controllers
			menuStyle:menuStyle
			topBarHeight:statusBarHeight];
  pageMenuController.delegate = self;
  [self addChildViewController:pageMenuController];
  [self.view addSubview:pageMenuController.view];
  [pageMenuController didMoveToParentViewController:self];
  self.pageMenuController = pageMenuController;

  NSUInteger numberOfControllers = controllers.count;
  for (NSInteger i = 0; i < numberOfControllers; i++) {
    DataViewController * vc = controllers[i];
#if	0
    vc.view.backgroundColor = [UIColor whiteColor];
#else
    vc.view.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.0f];
#endif
    vc.textLabel.text = [NSString stringWithFormat:@"%zd", i+1];
  }
}

/*****************************************************************************/

#pragma mark - PMKPageMenuControllerDelegate (optional)
-(void)pageMenuController:(PMKPageMenuController *)pageMenuController
 willMoveToViewController:(UIViewController *)viewController
	      atMenuIndex:(NSUInteger)index
{
  // ページが切り替わる前に呼び出される
  // 必要なコードを記述せよ
}

#pragma mark - PMKPageMenuControllerDelegate (optional)
-(void)pageMenuController:(PMKPageMenuController *)pageMenuController
  didMoveToViewController:(UIViewController *)viewController
	      atMenuIndex:(NSUInteger)index
{
  // ページが切り替わった直後に呼び出される
  // 必要なコードを記述せよ
}


#pragma mark - PMKPageMenuControllerDelegate (optional)
-(void)pageMenuController:(PMKPageMenuController *)pageMenuController
      didPrepareMenuItems:(NSArray<PMKMenuItem *> *)menuItems
{
  NSUInteger i = 1;
  for (PMKMenuItem * item in menuItems) {
    item.badgeValue = [NSString stringWithFormat:@"%zd", i++];
  }
}

#pragma mark - PMKPageMenuControllerDelegate (optional)
-(void)pageMenuController:(PMKPageMenuController *)pageMenuController
	didSelectMenuItem:(PMKMenuItem *)menuItem
	      atMenuIndex:(NSUInteger)index
{
  menuItem.badgeValue = nil;
}

@end
