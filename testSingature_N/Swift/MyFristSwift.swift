//
//  MyFristSwift.swift
//  MyFirstOCUseSwiftDemo
//
//  Created by jabraknight on 2019/7/24.
//  Copyright © 2019 jabraknight. All rights reserved.
//

import Foundation
import UIKit
let G_HEADIMAGE_HEIGHT:CGFloat = 30

class MyFristSwift: UIViewController,FTVCdelegte,SelfAware{
    static func awake() {
        
    }
    func getName() {
        
    }
    open var weight: Int = 0

    var lab = UILabel()//全局变量 存储型变量允许读取和写入
    var p = Person()
    var s = Student()
    var m = PersionModel()
    func searchHistory(_ per :String){
        UserDefaults.standard.set(per, forKey:"name")
        UserDefaults.standard.synchronize()
//        value(forKey: "searchHistoryKey") as? [String] ?? [String]()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchHistory("serchText")
        //创建一个对象并初始化
        p.name = "小强"
        p.age = 13
        s.run()
        m.test()
        
        //支持多点触摸
        self.view.isMultipleTouchEnabled = true
//        let修饰的变量不能改变指针指向
        self.view.backgroundColor = UIColor.green
        lab = UILabel(frame: CGRect(x: 100, y: 30, width: 200, height: 30  ))
        lab.backgroundColor = RGBColor(10, g: 10, b: 10)
        lab.text = "这是我的展示文字"
        lab.textColor = UIColor.orange
        lab.layer.cornerRadius = 4.0
        _ = lab.colorOfPoint(point: CGPoint(x: 10, y: 10))
        self.view.addSubview(lab)
        
        
//        var修饰的变量指针可以重新指向
        let newButton:UIButton = UIButton(frame: CGRect(x: 0, y: 20, width: 50, height: 50))
        newButton.backgroundColor = UIColor.blue
        newButton.setTitle("点我", for: .normal)
        newButton.addTarget(self, action: #selector(newButtonAction), for: .touchUpInside)
        self.view.addSubview(newButton)
        LGJLog("misdf")
        
//        var myWeb = UIWebView.init()
//        myWeb = UIWebView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
//                //下划线对于普通变量,用于忽略变量
//        var strstr = String()
//
//        strstr = foofoo(s1: "Hello", s2: "World")
//        //调用方式可以不加第二个函数的外部函数名：
//        strstr = foo(s1: "Hello", "123")
//
//        strstr = myWeb.stringByEvaluatingJavaScript(from: "navigator.userAgent") as Any as! String
        //as 用于转换类型 Any可以表示任何类型，包括方法类型（function types）
        print("输出的字符串 \(strstr)" as Any)
        //inout 的使用
        var value = 50
        print(value)  // 此时value值为50
        func incrementt(_ value: inout Int, _ length: Int = 10) {
            value += length
        }
        incrementt(&value)
        print(value)  // 此时 value 值为60，成功改变了函数外部变量 value 的值
        
//        //inout 的使用
//        var stepSize = 1
//        func increment(_ number: inout Int) {
//            number += stepSize//crash
        /*
         1.至少一个是写入操作
         2.他们访问的是同一块内存
         3.他们的访问时间重叠(比如在同一个函数内)
         对两个inout参数访问同一个内存地址，也会产生读写权限冲突
         */
//        }
//        increment(&stepSize)

        //inout参数的函数
        /*
         设置了属性观察器呢 或者 是计算属性 实际上是怎么一个流程改变的 改变他的值的
         产生一个副本 然后把副本地址传进去 改变副本的值 再用副本的值改变原先的孩子
         最后用setter方法改变原先的值
         */
        func changeName2(name:inout String){//加#是简写name作为外部参数名
            name = "Hello"
            print(name)
        }
        var payerName2 = "泥嚎"
        print(payerName2)//输出:泥嚎
        changeName2(name: &payerName2)
        print(payerName2)//输出:Hello (payerName2自身传入函数 自身的值也修改了)
        
        
        //进行条件判别 如果guard成立则继续往下执行，不然在else中return
        //guard - else必须同时出现，而且，else中，必须进行return
        guard let spaceName = Bundle.main.infoDictionary!["CFBundleExecutable"] else {
            print("空间名字获取不到")
            return
        }
        
        let clas:AnyClass? = NSClassFromString(spaceName as! String + "."+"ViewController")
        
        guard let clastype = clas as? UIViewController.Type else {
            return
        }
        
        let viewcontoller = clastype.init()
        print(viewcontoller)
        
        
        let testBtn:UIButton = UIButton(frame: CGRect(x: 0, y: 20, width: 50, height: 50))
        testBtn.backgroundColor = UIColor.blue
        testBtn.setTitle("按钮", for: .normal)
        testBtn.addTarget(self, action: #selector(testm), for: .touchUpInside)
        self.view.addSubview(testBtn)
        
    }
   @objc func testm(_ sender: UIButton) {
            
        }
    
    func foofoo(s1: String, s2: String) -> String {
        return s1 + s2;
    }
    func foo(s1: String, _ s2: String) -> String {
        return s1 + s2;
    }
    func change(title: String) {
        lab.text = title
        print("首页swift ：\(String(describing: lab.text))")
    }
    //更改背景色
    func ChangeColoer(Coloer: UIColor) {
        self.view.backgroundColor = Coloer
    }
    //是否成功
    func ChangSucces(YON: Bool) {
        print(YON)
    }
    //重写父类方法须加关键字 是为了防止继承的人 莫名其妙 覆盖了父类的方法，所以要继承的人明确写出来
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func newButtonAction(_ sender: UIButton) {
        print("select new button")
        let userDefaultsStr = UserDefaults.standard.string(forKey: "name") //as? [String] ?? [String]()
        print("本地保存的数据 \(String(describing: userDefaultsStr))")
        print(userDefaultsStr ?? "default value")

        //显示view
//        let customenView:AlertListFullView = AlertListFullView(frame: CGRect(x: 100, y: 70, width: 100, height: 100  ))
//        customenView.backgroundColor = UIColor.red;
//        customenView.layer.cornerRadius = 4.0;
//        self.view.addSubview(customenView);
        
//        self.dismiss(animated: true, completion: nil)
        //swift调用OC
//        let swiftUseOCVC:SwiftUseOCViewController = SwiftUseOCViewController.init();
//        swiftUseOCVC.lhSString = "123"
//        swiftUseOCVC.bridgeFun("吧")
//
//        self.present(swiftUseOCVC, animated: true) {
//
//        }


//        //1:动态获取命名空间
//        guard   let spaceName = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
//            print("获取命名空间失败")
//            return
//        }
        //控制器字符串名称
        let vcNameString = "MySeconfSwift"
        //获取命名空间也就是项目名称
        let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String
        
        //拼接
        let className=clsName! + "." + vcNameString
        
        //字符串转Class 需要注意的是这里的`UIViewController`强转必须带上`.Type`,否则转换不成功
        let classT = NSClassFromString(className)! as! UIViewController.Type
        print("我的页面\(classT)")
        let model = classT.init()
        var count: UInt32 = 0
        let cls = object_getClass(model)
        let plist = class_copyPropertyList(cls, &count);
        
        print("===开始获取");
        for item in 0..<count {
            let property = plist?[Int(item)]
            let cname = property_getName(property!);
            let name = String(cString: cname);
            
            print("property：<\(name)>")
        }
        print("===结束获取");
        
        print("===开始获取");
        let methodList = class_copyMethodList(cls, &count);
        for item in 0..<count {
            let meth = methodList![Int(item)];
            let m = method_getName(meth);
            let mStrl = NSStringFromSelector(m);
            print("方法：\(mStrl)");
        }
        print("===结束获取");

//        URLRouter.shared.pushViewController(viewController:classT.init()  , animated: true)
        //注册通知
        let dic = ["name" : "张三", "age" : 18] as [String : Any]
        NotificationCenter.default.post(name : NSNotification.Name.init(rawValue: "h"), object: dic)
        
//        let vcClass: AnyClass? = NSClassFromString("MySeconfSwift" + "." + "MySeconfSwift") //VCName:表示试图控制器的类名
//        // Swift中如果想通过一个Class来创建一个对象, 必须告诉系统这个Class的确切类型
//        guard let typeClass = vcClass as? UIViewController.Type else {
//            print("vcClass不能当做UIViewController")
//            return
//        }
//        let myVC = typeClass.init()
        
        //swift调用swift
        let sceondVC:MySeconfSwift = MySeconfSwift.init();
        sceondVC.namestr = "开始"
        sceondVC.delegate_zsj = self
        sceondVC.publicParaStr = "123"
        sceondVC.arr = ["sdf","sdf"]
//        sceondVC.
        
        //1. 创建对象的反射，获取对象类型
        let mirror: Mirror = Mirror(reflecting:p)
        print("获取对象类型\(mirror.subjectType)")
        // 打印出：获取对象类型Person
        //2. 获取对象属性名以及对应的值
        for p in mirror.children {
            let propertyNameString = p.label! //属性名使用!，因为label是optional类型
            let value = p.value //属性的值
            print("\(propertyNameString)的值为\(value)")
        }
        //闭包
        sceondVC.swiftBlock = { (address,province,city,area) in
            print(address,province,city,area)
        }
         //闭包传值
//        sceondVC.MyColsure = { (mySwiftBlock: String) -> Void in
//            print("swiftblock的Block数据 \(mySwiftBlock)")
//        }

        self.present(sceondVC, animated: true, completion: nil)
   
    }
    @objc func show(){
        var namestr = String()
        namestr = "sdf"
        print("是的\(namestr)")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch:AnyObject in touches {
            let t:UITouch = touch as! UITouch
            //当在屏幕上连续拍动两下时，背景回复为白色
            if t.tapCount == 2
            {
                self.view.backgroundColor = UIColor.white
            }else if t.tapCount == 1
            {
                self.view.backgroundColor = UIColor.blue
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //获取点击的坐标位置
        for touch:AnyObject in touches {
            let t:UITouch = touch as! UITouch
            print(t.location(in: self.view))
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.count == 2
        {
            //获取触摸点
            let first = (touches as NSSet).allObjects[0] as! UITouch
            let second = (touches as NSSet).allObjects[1] as! UITouch
            //获取触摸点坐标
            let firstPoint = first.location(in: self.view)
            let secondPoint = second.location(in: self.view)
            //计算两点间的距离
            let deltaX = secondPoint.x - firstPoint.x
            let deltaY = secondPoint.y - firstPoint.y
            let initialDistance = sqrt(deltaX + deltaY * deltaY)
            print("两点间的距离:\(initialDistance)")
            //计算两点间的角度
            let height = secondPoint.y - firstPoint.y
            let width = firstPoint.x - secondPoint.x
            let rads = atan(height/width)
            let degrees = 180.0 * Double(rads) / .pi
            print("两点间角度:\(degrees)")
        }
    }
}

@objc
class AlertListFullView: UIView{
    var headImgView:UIImageView?
    var field:UITextField?
    var line:UILabel?
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.backgroundColor = UIColor.white
//        initUI()
//    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    override init(frame:CGRect){
        super.init(frame: frame)
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubViews() {
        
        let frame = self.bounds
        //uiimageVIew
        headImgView = UIImageView(frame:CGRect(x:0,y:0,width:G_HEADIMAGE_HEIGHT,height:G_HEADIMAGE_HEIGHT))
        headImgView?.backgroundColor = UIColor.blue
        
        //uiTextField
        field = UITextField(frame:CGRect(x:0,y:0,width:100,height:G_HEADIMAGE_HEIGHT))
        //        field?.font = UIFont.systemFont(ofSize: 15)
        //uiLabel
        
        line = UILabel(frame: CGRect(x:0,y:frame.size.height-1,width:frame.size.width,height:1))
        line?.backgroundColor = UIColor.orange
        
        self.addSubview(headImgView!)
        self.addSubview(field!)
        self.addSubview(line!)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let frame = self.bounds
        let imgY = (frame.size.height - G_HEADIMAGE_HEIGHT)/2
        headImgView?.frame = CGRect(x:0,y:imgY,width:G_HEADIMAGE_HEIGHT,height:G_HEADIMAGE_HEIGHT)
        
        //field
        let fieldx = G_HEADIMAGE_HEIGHT+5
        let fieldWidth = frame.size.width - fieldx
        
        field?.frame = CGRect(x: fieldx, y: imgY, width: fieldWidth, height: G_HEADIMAGE_HEIGHT)
        
        //label
        var lineFrame = line?.frame
        lineFrame?.origin.y = frame.size.height - 2
        lineFrame?.size.width = frame.size.width
        lineFrame?.size.height = 5
        line?.frame = lineFrame!
        
    }
   
}


