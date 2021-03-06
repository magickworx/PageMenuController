PageMenuController
===========

日本のニュース系アプリで使われている横スクロールのメニュー画面とそのコンテンツを表示するユーザインタフェースのクラスを実装。Xcode のプロジェクト一式を登録してあるので、実行すればシミュレータ上で動作確認が可能。

横スクロールするメニューは UIScrollView を利用し、タイトル表示用の UILabel を管理している。コンテンツ表示部は UIPageViewController を使って画面を切り替えている。とてもシンプルな実装なので、改良も簡単。

たとえば、メニューを画像にしたい場合は、UILabel を UIImageView に替えて、UIImage で指定する仕組みにする。現実装では UIViewController の title から自動的にメニューのタイトルを作成しているが、initializer で UIViewController の配列と一緒に UIImage の配列を渡すようにすれば良い。

Screenshot
============

**「ニュースパス」っぽい画面（PMKPageMenuControllerStylePlain）**

![Plain モード](screenshot_plain.png "NewsPass っぽい画面")

Xcode の Edit Scheme... の Build Configuration の "Debug (Plain)" を選択してビルド。

**「グノシー」っぽい画面（PMKPageMenuControllerStyleTab）**

![Tab モード](screenshot_tab.png "Gunosy っぽい画面")

Xcode の Edit Scheme... の Build Configuration の "Debug (Tab)" を選択してビルド。

**「スマートニュース」っぽい画面（PMKPageMenuControllerStyleSmartTab）**

![Smart モード](screenshot_smart.png "SmartNews っぽい画面")

Xcode の Edit Scheme... の Build Configuration の "Debug (Smart)" を選択してビルド。

**「ハッカドール」っぽい画面（PMKPageMenuControllerStyleHackaTab）**

![Hacka モード](screenshot_hacka.png "Hackadoll っぽい画面")

Xcode の Edit Scheme... の Build Configuration の "Debug (Hacka)" を選択してビルド。


How to use PageMenuController
============

**1) PageMenuController フォルダの PSKPageMenuController.h と PSKPageMenuController.m ファイルを Xcode のプロジェクトにコピーする。**

**2) ベースとなる View Controller に property を記述する。**

```objectivec
@property (nonatomic,strong) PMKPageMenuController * pageMenuController;
```

**3) 次のコードを loadView (or viewDidLoad) に記述する。**

```objectivec
// UIViewController のサブクラスを管理する配列
NSMutableArray * controllers = [NSMutableArray new];

// 以下のような感じで必要な UIViewController を追加する
UIViewController * vc = [UIViewController new];
vc.title = @"Page Title"; // このタイトルがメニューに表示されるよ
[controllers addObject:vc];

// ステータスバーの高さを求める
CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;

// SmartNews っぽい見た目にする
PMKPageMenuControllerStyle menuStyle = PMKPageMenuControllerStyleSmartTab;

// 必要な引数を渡して PageMenuController を初期化
PMKPageMenuController * pageMenuController;
pageMenuController = [[PMKPageMenuController alloc]
                       initWithControllers:controllers
                       menuStyle:menuStyle
                       topBarHeight:statusBarHeight];

// PageMenuController を親となる ViewController の ChildViewController とする
// 以下は PMKPageMenuController を利用するときには必須のコード
[self addChildViewController:pageMenuController];
[self.view addSubview:pageMenuController.view];
[pageMenuController didMoveToParentViewController:self];
self.pageMenuController = pageMenuController;
```
より詳細なコードは RootViewController.m 内の loadView を見てね。

**4) Delegate Methods (optional)**

ページの切り替え時に呼び出される Delegate を使うことも可能。

```objectivec
pageMenuController.delegate = self;
```

上記のような記述を追加して、必要に応じて以下のメソッドを実装してね。

```objectivec
// ページが切り替えられる前に呼び出される
-(void)pageMenuController:(PMKPageMenuController *)pageMenuController
 willMoveToViewController:(UIViewController *)viewController
	      atMenuIndex:(NSUInteger)index;
// ページが切り替え後に呼び出される
-(void)pageMenuController:(PMKPageMenuController *)pageMenuController
  didMoveToViewController:(UIViewController *)viewController
	      atMenuIndex:(NSUInteger)index;
```

Requirements
============

 - ARC
 - Objective-C
 - iOS 10.1 or later
 - Xcode 8.1 or later

License Agreement
============

Copyright (c) 2016, Kouichi ABE (WALL) All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

 1. Redistributions of source code must retain the above copyright notice,
    this list of conditions and the following disclaimer.

 2. Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
