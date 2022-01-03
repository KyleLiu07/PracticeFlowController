# PracticeFlowController

* 練習的例子為 TODO List

1. 未實作邏輯，只有UI 轉換，故操作都是Button
2. 有實作 Navigation、Present、Tab 的基本行為


* 基本原則：
1. 利用原生的 View Controller 處理 Router
2. Flow Controller 繼承自 ViewController，但不管理 View，只是個 Container View Controller
3. 不需要管理Flow Controller 的生命週期，交由原生的 View Controller 階層去處理

* 實作：
1. AppFlowController 由 AppDelegate 生成並握住
2. AppFlowController 可管理 Splash, Login, Launch 流程, RootTabBar 等 FlowController，並藉由add 與 remove ChildController 的方式切換；並經由 Delegate 的方式，與 AppFlowController 進行聯絡
3. RootTabBarFlowController 生成各個Tab 的 FlowController
4. FlowController 可以控制多個 ViewController 的切換
5. 在同個 Tab 下，利用 NavigationController 將下個 FlowController加入 ViewControllers
6. FlowController 都需要將對應的 ViewController 用 add 的方式放上 FlowController
7. Present & dismiss 由上一個flow controller 執行

* 實作上遇到的問題：
1. 因為 TabBarController 需要把 NavigationController 放到它的 ViewControllers 中，我們在設定 viewController 的 hidesBottomBarWhenPushed 才會有作用

=> 可在 flowController 的 init 中或生成他時加上 flowController.hidesBottomBarWhenPushed = true

2. 如果是第二層以上的 FlowController ，如需客製 navigation bar 則必須要把 navigationItem 塞進 view controller 中
