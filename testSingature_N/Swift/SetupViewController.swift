//
//  Setting VC.swift
//  loca
//
//  Created by ext.zhaoxueli1 on 2022/6/27.
//

import Foundation
import UIKit
import CoreLocation

/*
 Swift类要给OC使用，需要继承自NSObject，并且使用@objc修饰需要暴露给OC使用的成员，或者使用@objcMembers修饰类将所有成员暴露给OC。Swift代码中可以使用@objc重命名暴露给OC的符号名（类名，属性名，函数名等）
 Swift类中用public修饰过的方法，才会出现在ProductName-Swift.h文件中；
 所有Swift类在ProductName-Swift.h文件都会被自动注册，也会自动@interface修饰，ProductName-Swift.h文件会自动更新。
 // Swift语言
 @objcMembers class Cat: NSObject {
 var name: String
 
 init(name: String) {
 self.name = name
 }
 
 @objc(oc_test) func test() {
 print("test")
 }
 */
@objcMembers class SetupViewController : UIViewController,DHBridgeDelegate{
    
    //    lazy var tableView : UITableView = UITableView()
    var sectionThree = NSArray()
    
    var sectionTwo = NSArray()
    
    var sectionOne = NSArray()
    var sectionOnes = NSArray()
    
    let locationManager = CLLocationManager()
    
    var currentLocation:CLLocation!
    
    var lock = NSLock()
    
    
    lazy var tableView: UITableView = {
        
        print("start init testLabel, isViewLoaded \(self.isViewLoaded)")
        //        let tableView = UITableView.init(frame: self.view.bounds)
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        print("created tableView \(tableView)")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 0.01;
        tableView.register(SetupOneTableViewCell.self, forCellReuseIdentifier: "SetupOneTableViewCell")
        tableView.register(SetupTwotableViewCell.self, forCellReuseIdentifier: "SetupTwotableViewCell")
        tableView.register(SetupJurisdictionTableViewCell.self, forCellReuseIdentifier: "SetupJurisdictionTableViewCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        //tableview
        super.viewDidLoad()
        view.backgroundColor = .red

        sectionThree = ["隐私设置","开机设置","当前版本","关于我们"]
        sectionTwo = ["实名认证","账号切换","账号安全"]
        sectionOne = ["用户名:","ID:","名称:"]
        sectionOnes = ["YYDS","324234—23412","拼音"]
        
        locationManager.delegate = self
        locationManager.desiredAccuracy =  kCLLocationAccuracyBest //定位精确度（最高）一般有电源接入，比较耗电
        //kCLLocationAccuracyNearestTenMeters;                    //精确到10米
        locationManager.distanceFilter =  50
        //设备移动后获得定位的最小距离（适合用来采集运动的定位）
        locationManager.requestWhenInUseAuthorization()           //弹出用户授权对话框，使用程序期间授权（ios8后)
        //requestAlwaysAuthorization;                             //始终授权
        locationManager.startUpdatingLocation()
        print("开始定位 。。。")
        setupUI()
        var str = {
            (arg1:String,arg2:String)->String in
            return arg1+"_"+arg2;
        }("侯","逸诚")
        
        print("OC的block吗？ \(str) 哈哈哈")
    }

   
    override func didReceiveMemoryWarning() {
        
    }
}

//扩展可以添加新的计算属性，但它们不能添加存储属性，或向现有属性添加属性观察者
//扩展可以向类添加新的便利构造器，但是它们不能向类添加新的指定构造器或析构器。指定构造器或析构器必须始终由原始类实现提供。
//如果使用扩展将构造器添加到值类型中，该值类型为其所有存储属性提供默认值，并且没有任何自定义构造器，则可以在扩展的构造器中调用该值类型的默认构造器和全能构造器。
//如果使用扩展将构造器添加到声明在另一个模块中的结构体中，则新的构造器只有从定义的模块中调用了构造器才能访问self。
//提供新构造器；
//定义下标；
//定义和使用新的嵌套类型；
//使现有类型符合协议；
//注意：扩展可以向类型添加新功能，但不能覆盖现有功能。

struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}

extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}
extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}
//扩展可以向已存在的类，结构体和枚举添加新的嵌套类型
extension Int {
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}


///MARK:  -设置UI界面相关
extension SetupViewController {
    /// 设置UI界面
    func setupUI() {
        let navview = UIView.init(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 64))
        _ = UIColor(hex: "#F4F6F6")
        navview.backgroundColor = .gray//gex
//        view.addSubview(navview)
        
        
        let color = UIColor.red
        let hex = color.hexStringToUIColor(hex: "#F4F6F6")
        self.view.backgroundColor = hex//UIColor(hex: "#F4F6F6")
        
        // 0.将tableView添加到控制器的View中
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        tableView.frame.origin = CGPoint(x: 0, y: 0)
        tableView.frame.size   = CGSize(width: view.bounds.size.width, height: view.frame.size.height)
        // 2.设置数据源
        tableView.dataSource = self
        // 3.设置代理
        tableView.delegate = self
        tableView.sectionHeaderHeight = 0.01;
        tableView.sectionFooterHeight = 0.01;
        tableView.reloadData()
    }
    func test() {
        
        ///TODO: 测试
        let oneInch = 25.4.mm
        print("One inch is \(oneInch) meters")
        // Prints "One inch is 0.0254 meters"
        let threeFeet = 3.ft
        print("Three feet is \(threeFeet) meters")
        let aMarathon = 42.km + 195.m
        print("A marathon is \(aMarathon) meters long")
        // Prints "A marathon is 42195.0 meters long"
        //Rect结构为其所有属性提供默认值，所以它会自动接收默认构造器和全能构造器。这些构造器可用于创建新的Rect实例:
        let defaultRect = Rect()
        print("defaultRect is \(defaultRect) value")
        let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
                                  size: Size(width: 5.0, height: 5.0))
        print("memberwiseRect is \(memberwiseRect) value")
        //可以扩展Rect结构体以提供额外的构造器，该构造器具有特定的中心点和大小:
        let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                              size: Size(width: 3.0, height: 3.0))
        print("centerRect 's origin is \(centerRect) and its size is ")
        // centerRect's origin is (2.5, 2.5) and its size is (3.0, 3.0)
        //3次打印
        3.repetitions {
            print("Hello!")
        }
        //遍历字符串
        for c in "Hello, Swift" {
            print(c)
        }
        //比如时间:03:04
        let min = 3
        let second = 4
        let time = String(format: "%02d:%02d", arguments: [min, second])
        print("centerRect 's origin is \(time) and its size is ")
        
        let myStr = "www.baidu.com"
        var subStr = (myStr as NSString).substring(from: 4)
        print("^^^^^^^111^^^^^^^^^^:\(subStr)")
        subStr = (myStr as NSString).substring(to: 3)
        print("^^^^^^^222^^^^^^^^^^:\(subStr)")
        subStr = (myStr as NSString).substring(with: NSRange(location: 4, length: 5))
        print("^^^^^^^333^^^^^^^^^^:\(subStr)")
        
        //初始化一个数组如下
        var array1 : [String] = [String]()
        //在声明一个Array类型的时候可以使用下列的语句之一
        var stuArray1:Array<String>
        var stuArray2: [String]
        //声明的数组需要进行初始化才能使用，数组类型往往是在声明的同时进行初始化的
        // 定义时直接初始化
        var array = ["why", "lnj", "lmj"]
        // 先定义,后初始化
        var array2 : Array<String>
        array2 = ["why", "lnj", "lmj"]
        
        print("^^^^^^^1111^^^^^^^^^^:\(746381295[0])")
        print("^^^^^^^2222^^^^^^^^^^:\(746381295[1])")
        print("^^^^^^^3333^^^^^^^^^^:\(746381295[2])")
        print("^^^^^^^4444^^^^^^^^^^:\(746381295[3])")
        //访问级别          定义
//        public        可以访问自己模块中源文件里的任何实体，别人也可以通过引入该模块来访问源文件里的所有实体。
//        internal      可以访问自己模块中源文件里的任何实体，但是别人不能访问该模块中源文件里的实体。
//        fileprivate    文件内私有，只能在当前源文件中使用。
//        private       只能在类中访问，离开了这个类或者结构体的作用域外面就无法访问。
//        public        为最高级访问级别，private 为最低级访问级别。
        //访问级别不能高于超类 public > internal
        //常量、变量、属性不能拥有比它们的类型更高的访问级别
    }
}
extension SetupViewController : CLLocationManagerDelegate {
    //委托传回定位，获取最后一个
    func locationManager(manager:  CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lock.lock()
        currentLocation = locations.last
        //注意：获取集合中最后一个位置（最新的位置）
        print("定位经纬度为：\(currentLocation.coordinate.latitude)")
        //一直发生定位错误输出结果为0：原因是我输出的是currentLocation.altitude(表示高度的)而不是currentLoction.coordinate.latitude（这个才是纬度）
        print(currentLocation.coordinate.longitude)
        lock.unlock()
    }
    
    func locationManager(manager:  CLLocationManager, didFailWithError error: NSError) {
        print("定位出错拉！！\(error)")
    }
}

// extension类似OC的category,也是只能扩充方法,不能扩充属性
extension SetupViewController : UITableViewDataSource, UITableViewDelegate{
    //cell 高度的设置
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }
        if section == 1 {
            return sectionTwo.count
        }
        if section == 2 {
            return sectionThree.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let CellID = "SetupOneTableViewCell"
            let cell = SetupOneTableViewCell(style: .default, reuseIdentifier: CellID)
            //            let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath) as! SetupOneTableViewCell
            cell.selectionStyle = .none;
            //            cell.textLabel?.text = "测试数据:\((indexPath as NSIndexPath).row)"
            cell.nameStr = sectionOne[indexPath.item] as? String
            cell.subNameStr = sectionOnes[indexPath.item] as? String
            cell.selectionStyle = .none;
            if indexPath.item == 0 {
                cell.isFirst = true
            }
            if indexPath.item == 2 {
                cell.isLast = true
            }
            return cell
        }
        
        if indexPath.section == 1 {
            let CellID = "SetupTwotableViewCell"
            let cell = self.tableView.dequeueReusableCell(withIdentifier: CellID) as! SetupTwotableViewCell
            //            cell.textLabel?.text = "测试数据:\((indexPath as NSIndexPath).row)"
            cell.nameStr = sectionTwo[indexPath.item] as? String
            cell.selectionStyle = .none;
            if indexPath.item == 0 {
                cell.isFirst = true
            }
            if indexPath.item == 2 {
                cell.isLast = true
            }
            return cell
        }
        if indexPath.section == 2 {
            let CellID = "SetupJurisdictionTableViewCell"
            let cell = self.tableView.dequeueReusableCell(withIdentifier: CellID) as! SetupJurisdictionTableViewCell
            cell.nameStr = sectionThree[indexPath.item] as? String
            cell.selectionStyle = .none;
            cell.showState = true
            if indexPath.item == 0 {
                cell.isFirst = true
            }
            if indexPath.item == 2 {
                cell.showState = false
                cell.valueStr = "版本号3.4.5"
            }
            if indexPath.item == 3 {
                cell.isLast = true
            }
            
            //            cell.textLabel?.text = "测试数据:\((indexPath as NSIndexPath).row)"
            return cell
        }
        let CellID = "CellID"
        //        var cellDefault = tableView.dequeueReusableCell(withIdentifier: CellID)
        var cellDefault:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: CellID)
        if cellDefault==nil {
            cellDefault = UITableViewCell(style: .subtitle, reuseIdentifier: CellID)
        }
        //        if cellDefault == nil {
        //            // 在swift中使用枚举: 1> 枚举类型.具体的类型 2> .具体的类型
        //            cellDefault = UITableViewCell(style: .default, reuseIdentifier: CellID)
        //        }
        //        // 2.给cell设置数据:cell为可选类型，从缓存池中取出的cell可为空，所以为可选类型,最后返回cell的时候要进行强制解包，此时已经保证了可选类型不为空，若为空强制解包会为空
        //        cellDefault?.textLabel?.text = "测试数据:\((indexPath as NSIndexPath).row)"
        // 3.返回cell
        return cellDefault!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("点击了:\((indexPath as NSIndexPath).row)")
//        let settingUrl = NSURL(string:UIApplication.openSettingsURLString)!
//        if UIApplication.shared.canOpenURL(settingUrl as URL) {
//            UIApplication.shared.openURL(settingUrl as URL)
//        }
        //TODO: 在swift类中调用 oc的block.
        let bridgeVC = DHBridgeViewController.init()
        bridgeVC.secondDelegate = self
        bridgeVC.hintBlock = {(param) -> () in
            print("在swift类中调用 oc的block吗？ \(param) 哈哈哈")
        }
        bridgeVC.refreshHintLabelBlock = {(param) -> () in
            print("在swift类中调用 oc的block吗？ \(param) 哈哈哈")
        }
        present(bridgeVC, animated: true)
    }
    //TODO: 在swift类中调用 oc的dalegate.
    func refreshHintLabel(_ hintString: String) {
        print("在swift中实现oc的代理方法回传值：String \(hintString)")
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 3
        }
        if section == 2 {
            return 3
        }
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 3
        }
        if section == 1 {
            return 3
        }
        return 0.01
    }
    
}
extension UIColor {
    //Create Func
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
        
    }
}
/*
 
**构造方法
    swift语言要求结构体和类必须在构造方法结束前完成其中存储属性的构造，延时存储属性例外。因此，开发者在设计类时，往往采用两种方法来处理存储属性：
        <1>在类和结构体中声明存储属性时直接为其设置初始默认值
        <2>在类和结构体的构造方法中对存储属性进行构造或者设置默认值
    
    swift语言中，所有的构造方法都需要使用init()来标识，开发者可以通过函数重载来创建适合各个场景的构造方法。
    
    如果类或结构体中所有存储属性都有初始默认值，那么开发者不显示地提供任何构造方法，编译器也会默认自动生成一个无参的构造方法init().
 
    和类不同的是，结构体可以不实现其构造方法，，编译器会默认生成一个构造方法，将所有的属性作为参数
 
    如果开发者为值类型结构(例如：结构体)提供了一个自定义的构造方法，则系统默认生成的构造方法将失效，系统为了防止开发者调用自定义的构造方法时误调用到系统
 生成的构造方法，使构造方法可以嵌套使用
 
    指定构造方法：指定构造方法的官方名称：Designated,指定构造方法是类的基础构造方法，任何类都至少有一个指定构造方法，指定构造方法声明时不需要任何关键字
 修饰，
            
    便利构造方法：便利构造方法的官方名称：Convernience，是为了开发者方便使用，为类额外添加的构造方法
               注意：便利构造方法最后也是要调用指定构造方法的
    
    指定构造方法与便利构造方法的使用原则：
        子类的指定构造方法中必须调用父类的指定构造方法
        便利构造方法中必须调用当前类的其它构造方法
        便利构造方法归根结底要调用某个指定构造方法
 
    构造方法的继承关系，以及使用原则：
        <1>在继承关系中，如果子类没有覆写或者重写任何指定构造方法，则默认子类会继承父类所有的指定构造方法
        <2>如果子类中提供了父类所有的指定构造方法(无论是通过继承方式还是覆写方式)，则子类会默认继承父类的便利构造方法
        <3>覆写父类的指定构造方法需要使用override关键字，和普通方法的覆写一样
        <4>便利构造方法并不存在覆写的概念，便利构造方法必须调用类本身的其它构造方法，因此无论子类中定义的便利构造方法和父类是否相同，其都是子类独立的构造
            方法
        <5>子类覆写了父类的便利构造方法，那么需要子类覆写这个构造方法依赖的父类相关的指定构造方法
 
    构造方法的安全性检查：
        <1>子类的指定构造方法中，必须完成当前类所有存储属性的构造，才能调用父类的指定构造方法
            目的：在构造完从父类继承下来的所有存储属性前，本身定义的所有存储属性也已构造完成
        <2>子类如果要自定义父类中存储属性的值，必须在调用父类的构造方法之后进行设置
            目的：子类在设置从父类继承下来的存储属性时，此属性已构造完成
        <3>如果便利构造方法中需要重新设置某些存储属性的值，必须在调用指定构造方法之后进行设置
            目的：便利构造方法中对存储属性的设置不会被指定构造方法中的设置覆盖
        <4>子类在调用父类构造方法之前，不能使用self来引用属性
            目的：在使用self关键字调用实例本身时，实例已经构造完成
    
    可失败的构造方法：一个构造方法可能需要一些特定情况的参数，当传递的参数不符合要求时，开发者需要让这次构造失败。这时使用可失败的构造方法。
                    可失败构造方法的定义非常简单，只需要使用init?()即可，在实现可失败构造方法时，开发者可以根据需求返回nil
    
    必要构造方法：如果一个类中的某些构造方法被指定为必要构造方法，则其子类必须实现这个构造方法（可以通过继承和覆写的方式），必要构造方法需要使用required关键字进行修饰
 
**析构方法
    析构方法：析构方法和构造方法是互逆的，当实例被销毁时，系统会调用它的析构方法
            我们可以在析构方法中销毁实例使用的内存资源
 
**知识拓展
    属性的设计技巧：
        如果一个类或结构体大多数实例的某个属性都需要相同的值，开发者应该将其设置为这个属性的初始默认值
        如果某个属性在逻辑上是允许为nil的，开发者可以将其声明成Optional类型，对于Optional类型的属性，如果在构造方法中不进行赋值，则会默认赋值为nil
    属性监听器的调用时机：
        在对存储属性设置默认值或者在构造方法中对其构造时，并不会触发属性监听器，只有在构造完成后，再对其赋值时才会触发
 
*/

class Music{
    
    var singer:String
    let time:Double
    var zone:String = "China"{
        didSet{
            print("current zone \(self.zone)")
        }
    }
    var musicType:String = "popular"{
        didSet{
            print("current musicType \(self.musicType)")
        }
    }
    
    //init()、init(singer:String, time:Double, zone:String)都是指定构造方法，一个类可以设置多个指定构造方法
    init() {
        self.singer = "Nobody"
        self.time = 0.0
        self.zone = "NoWhere"
        print("Designated Empty Method")
    }
    init(singer:String, time:Double, zone:String) {
        self.time = time
        self.singer = singer
        self.zone = zone
        print("Designated Method")
    }
    
    //下面这两个是便利构造方法，一个类也可以有多个便利构造方法
    //便利构造函数通常用在对系统的类进行构造函数的扩充时使用
    //1、//便利构造函数通常都是写在extension里面
    //2、便利函数init前面需要加载convenience
    //3、在便利构造函数中需要明确的调用self.init()
    convenience init(singer:String, time:Double, zone:String, turnType:String){
        self.init(singer: singer, time: time, zone: zone)//designed函数必须最先调用
        print("This music is turn on")
    }
    convenience init(musicType:String){
        self.init()//designed函数必须最先调用
        print("This music type is \(musicType)")
    }
}
 
class RapMusic:Music{
    
    var speed:Int = 0
    var key:Int = 0
    //子类覆写父类的指定构造方法，在子类中必须调用必须调用父类的指定构造方法
    override init(){
        super.init(singer: "Piter", time: 2.34, zone: "America")
    }
    convenience init(speed:Int) {
        self.init()
        self.speed = speed
        print("init rap music speed is \(self.speed)")
    }
    convenience init(key:Int) {
        self.init()
        self.key = key
    }
}
 
class PopularMusic:Music{
    
    var speed:Int = 0
    var popularZone:String
    lazy var popularYear:Int = 0
    
    override init() {
        //必须完成当前类所有存储属性的构造
        self.popularZone = "Beijing"
        //子类在调用父类构造方法之前，不能使用self来引用属性
        //self.singer = "Anny"    //'self' used in property access 'singer' before 'super.init' call
        
        super.init()    //Property 'self.popularZone' not initialized at super.init call，需要先给popularZone赋初值
        print("PopularMusic Designated Empty Method")
        
        self.singer = "Anny"
        print("PopularMusic singer is:\(self.singer)")
    }
    
    //Initializer does not override a designated initializer from its superclass
    //子类覆写了父类的便利构造方法，那么需要子类覆写这个构造方法依赖的父类相关的指定构造方法
    convenience init(musicType:String) {
        //self.singer = "Anna"    //'self' used before 'self.init' call or assignment to 'self',需要在调用完指定构造方法之后进行
        self.init()
        print("This popular music type is \(musicType)")
        
        //如果便利构造方法中需要重新设置某些存储属性的值，必须在调用指定构造方法之后进行设置
        self.singer = "Anna"
        print("PopularMusic singer is:\(self.singer) in convenience init!")
    }
}
 
//可失败构造方法与必要构造方法
class Check{
    var property:Int
    
    //必要构造方法
    required init(param:Int){
        property = param
    }
    
    //可失败的构造方法
    init?(param:Bool){
        //使用守护语句，当param为ture时才进行构造
        guard param else{
            return nil
        }
        property = 1
    }
    
    //属性的构造可以使用闭包的方式
    var name:Int = {
        print("Check name init value")
        return 6+6
    }()     //这个（）不能丢掉，否则这个属性就变成了一个只读的计算属性了，发生了本质的区别
    
    //析构方法
    deinit{
        print("Check 实例被销毁")
    }
}
class CashCheck:Check{
    
    //这里不用加override，会报一个警告：'override' is implied when overriding a required initializer
    required init(param: Int) {
        super.init(param: param)
        print("This is CashCheck override required init")
        
        property = param + 1   //在父类的init方法调用后再进行新的赋值
    }
}
 
class StructureMethod{
    
    //简单的使用指定构造方法与便利构造方法
    func useDesignatedAndConvernience(){
        let musicOne = Music(singer: "pany", time: 3.20, zone: "Ace", turnType: "turn on")
        musicOne.musicType = "popular"
        
        let musicTwo = Music(musicType: "Rap")
        musicTwo.zone = "China"
    }
    
    //构造方法的继承关系
    func useInheritanceRelationship(){
        let popularM = PopularMusic(musicType: "current popular")
        /* 构造方法的调用顺序如下：
         Designated Empty Method    父类的指定构造方法
         PopularMusic Designated Empty Method   子类的指定构造方法
         This popular music type is current popular     子类自己的便利构造方法
         */
        popularM.speed = 2
    }
    
    //构造方法的安全性检查
    func useSafetyInspection(){
        let popularM = PopularMusic(musicType: "current popular use safety")
        /* 构造方法的调用顺序：
         Designated Empty Method
         PopularMusic Designated Empty Method
         PopularMusic singer is:Anny
         This popular music type is current popular use safety
         PopularMusic singer is:Anna in convenience init!
         */
        popularM.popularYear = 2022
    }
    
    //可失败构造方法与必要构造方法
    func useCanFail(){
        
        //使用可失败的构造方法
        let check = Check(param: false)
        //初始化中，这个被打印了：Check name init value
        if(check == nil){
            print("Check 初始化失败！")
        }
        
        let cashCheck = CashCheck(param: 2)
        /*打印如下：
         Check name init value  父类计算属性在初始化时，闭包的打印
         This is CashCheck override required init   子类覆写的父类必要构造方法
         */
        print("cashCheck is: \(cashCheck.property), name is: \(cashCheck.name)")
        //cashCheck is: 3, name is: 12
        
        //这个方法结束前，系统释放check对象时，调用了Check类的析构方法，Check 实例被销毁
        //注意：这里只打印了一次：Check 实例被销毁，说明子类的实例变量在被销毁时，没有调用父类的析构方法
    }
    
    //析构方法的使用
    func useDeinit(){
        
        //注意这里初始化是必须是可选类型的变量，且必须为var的变量
        var check:Check? = Check(param: 22) //否则系统会报错：'nil' cannot be assigned to type 'Check'
        check = nil
        /* 打印顺序如下：
         Check name init value  //初始化时name计算属性闭包中赋值
         Check 实例被销毁    实例被置为nil时调用析构方法
         */
    }
}
//最简单
//class SingletonOne {
//    static let sharedInstance = SingletonOne()
//    private init() {}
//    //切记私有化初始化方法，防止外部通过init直接创建实例。
//}
class SingletonClass: NSObject {

    static let shared = SingletonClass()
    
    // Make sure the class has only one instance
    // Should not init or copy outside
    private override init() {}
    
    override func copy() -> Any {
        return self // SingletonClass.shared
    }
    
    override func mutableCopy() -> Any {
        return self // SingletonClass.shared
    }
    
    // Optional
    func reset() {
        // Reset all properties to default value
    }
}
/**
静态属性 shared 持有唯一的实例，对外公开。

重载 init() 方法，使其对外不可见，不可以在外部调用，防止在外部创建实例。

重载 copy()、mutableCopy() 方法，返回 self，防止在外部复制实例。这里也可以返回 SingletonClass.shared，效果是一样的，因为只有一个实例。只有 shared 能调用 copy()、mutableCopy() 方法，那么 self 就是 shared。写 self，代码比较简洁。

单例一旦创建，一直持有，不能手动销毁，但可以重置数据。如果需要的话，可以添加一个重置数据的方法 reset()。例如，当前用户退出登录，需要把当前用户实例的所有属性重置为默认值，防止数据错误。

*/
