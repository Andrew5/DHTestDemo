//
//  MySeconfSwift.swift
//  MyFirstOCUseSwiftDemo
//
//  Created by jabraknight on 2019/7/25.
//  Copyright © 2019 jabraknight. All rights reserved.
//

import Foundation
import UIKit
//(一)要创建一个协议,写在class之前
protocol FTVCdelegte : NSObjectProtocol{
    //在协议里面，声明许多方法
    // 第一个，改变标题
    func change(title:String)
    //第二个，改变背景色
    func ChangeColoer (Coloer:UIColor)
    //是否成功的标志
    func ChangSucces(YON:Bool)
}

typealias swiftBlock = (_ str:String) -> Void

//假如你想传个字符串
typealias MyColsure = (_ str: String) -> Void


class MySeconfSwift: UIViewController , UITableViewDataSource,UITableViewDelegate{
    //如果你的类不需要便利构造器的话, 那么你就不必定义便利构造器, 便利构造器前面必须加上 convenience 关键字
    //init 规则
    //定义 init 方法必须遵循三条规则
    //指定构造器必须调用它直接父类的指定构造器方法.
    //便利构造器必须调用同一个类中定义的其它初始化方法.
    //便利构造器在最后必须调用一个指定构造器.
    init() {
        //提示给self.name初始化 -> 分配空间,设置初始值!
        myTableView = UITableView()
        super.init(nibName: nil, bundle: nil)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //定义外部访问的属性
    var arr = [Any]()//定义数组 数组中内容不确定 用Any 任何类型的实例
    var publicParaStr:String{
        get{
            return "job"
        }
        set{
            print("set ok")
        }
    }
    var namestr = String()
    var lab = UILabel()
    private var personNib = UINib()
    var myTableView:UITableView
    var btn = IrregularButton()
    
    //获取屏幕大小
    var screenBounds:CGRect = UIScreen.main.bounds

    private let BTN_TAG = 1001
    
    //MARK: UITableViewDataSource
    // cell的个数
    //override:重写父类方法须加关键字
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 10
    }
    // UITableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cellIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
//        if cell != nil {
//            cell = [personNib instantiateWithOwner:nil options:nil][0];
//        }
        
        cell?.textLabel?.text = "我是名字"
        cell?.detailTextLabel?.text = "我是副标题"
        return cell!
    }
    // 设置cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    // 选中cell后执行此方法
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("我点击的: \(indexPath.row)")
        if indexPath.row == 1 {
            let shoppingList: [AnyObject] = NSArray(objects: UIImage(named: "1")!,UIImage(named: "2")!,UIImage(named: "3")!,UIImage(named: "4")!,UIImage(named: "5")!,UIImage(named: "6")!) as [AnyObject]

//            var shoppingList: [AnyObject] = NSArray(objects: UIImage.imageNamed("1"),UIImage.imageNamed("2"),UIImage.imageNamed("3"),UIImage.imageNamed("4"),UIImage.imageNamed("5"),nil)
            let imageView: UIImageView = UIImageView(frame: CGRect(x: UIScreen.main.bounds.size.width-90, y: 0, width: 80, height: 80))
            imageView.layer.borderColor = UIColor.red.cgColor
            imageView.layer.borderWidth = 1.0
            self.view.addSubview(imageView)
            let imageCom = MGXStitchImage.stitchImage(images:shoppingList as! Array<UIImage>, size:CGSize(width: 50, height: 50), backgroundColor:UIColor.red)
            imageView.image = imageCom;
               
//            imageView = UIImageView(image: UIImage(named: "main_badge@3x"), highlightedImage: UIImage(named: "main_badge@3x"))
            
        } else {
            let chromeLayer = ExplosionLayer.createLayer(superLayer: self.view.layer, lab, ExplosionAnimationType.FallAnimation)
            chromeLayer.explode()
        }
         
    }
    //Anyobject可以表示class类型的实例,Any可以表示任何类型的实例
    public var swiftBlock:((String,String,String,String)->())?//声明回调
//    var MyColsure:((String)->())?// (()->()) 闭包参数
    var MyColsure:(([String:AnyObject])->())?//闭包属性的定义
    
    
//    for (CBCharacteristic *character in service.characteristics) {
//        CBCharacteristicProperties properties = character.properties;
//        //如果我们需要回调，则就不要使用没有返回的特性来写入数据
//        //        if (properties & CBCharacteristicPropertyWriteWithoutResponse) {
//        //            NSDictionary *dict = @{kSECharacter:character,kSEType:@(CBCharacteristicWriteWithoutResponse)};
//        //            [_writeChatacters addObject:dict];
//        //        }
//
//        if (properties & CBCharacteristicPropertyWrite) {
//        NSDictionary *dict = @{kSECharacter:character,kSEType:@(CBCharacteristicWriteWithResponse)};
//        [_writeChatacters addObject:dict];
//        }
//    }

  
    
    //(二)创建一个遵守协议的对象，写在定义属性处。
    var delegate_zsj:FTVCdelegte?
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        print("页面属性传值：\(myStr)")
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.green
        let newButton:UIButton = UIButton(frame: CGRect(x: 0, y: 20, width: 50, height: 50))
        newButton.backgroundColor = UIColor.blue
        newButton.setTitle(namestr, for: .normal)
        newButton.addTarget(self, action: #selector(backActions), for: .touchUpInside)
        self.view.addSubview(newButton)
        print("页面属性传值：\(namestr)")
        print("\(screenBounds.width)")
        lab = UILabel(frame: CGRect(x: 100, y: 30, width: 15*6, height: 30  ))
        lab.backgroundColor = RGBColor(10, g: 10, b: 10)
        lab.text = "爆炸式星星";
        lab.textColor = UIColor.orange
        lab.layer.cornerRadius = 4.0;
        self.view.addSubview(lab);
        //发送通知
        NotificationCenter.default.addObserver(self, selector: #selector(MySeconfSwift.hello), name: NSNotification.Name(rawValue: "h"), object: nil)

        var mutableArray = [1,2,3]
        for _ in mutableArray {
            mutableArray.removeLast()
        }

        let colorArr = [UIColor(red: 231/255, green: 15/255, blue: 0, alpha: 1),
                        UIColor(red: 237/255, green: 218/255, blue: 0, alpha: 1),
                        UIColor(red: 248/255, green: 160/255, blue: 0, alpha: 1),
                        UIColor(red: 103/255, green: 226/255, blue: 103/255, alpha: 1),
                        UIColor(red: 67/255, green: 196/255, blue: 242/255, alpha: 1)]
        
        let typeArr: [BtnType] = [.leftUp, .rightUp, .leftDown, .rightDown, .center]
        
        for index in 0..<colorArr.count {
            let color = colorArr[index]
            let typetype = typeArr[index]
            //使用_代表忽略(不使用)参数标签。
            let btn = IrregularButton(frame: CGRect(x: 100, y: screenBounds.height-250, width: 100, height: 100  ))
            _ = btn.path(type: typetype)
            _ = btn.backgroundColor(color: color)
            _ = btn.text(text: "按钮\(index+1)")
            _ = btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
            _ = btn.tag = BTN_TAG + index
            
            self.view.addSubview(btn)
        }
        
      
        print("-------\(self.publicParaStr) \(self.arr)")
        checkup(person: ["id": "123456" as AnyObject]) // 没有准考证，不能进入考场!
        checkup(person: ["examNumber": "654321" as AnyObject]) // 没有身份证，不能进入考场!
        checkup(person: ["id": "123456" as AnyObject, "examNumber": "654321" as AnyObject]) // 您的身份证号为:123456，准考证号为
        
        //尾随闭包、逃逸闭包、自动闭包

        //方法methodd()中的参数具有默认的外部參数名，不想使用外部參数名能够使用下划线进行忽略
//        methodd{_ in
//
//        }
        methodd { ([String : AnyObject]) in
            
        }
        
        //创建tableview
        self.myTableView = UITableView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width-100), style: .plain)
        self.myTableView.backgroundColor = UIColor.white
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
        self.view.addSubview(self.myTableView)
        
        personNib = UINib (nibName: "", bundle: nil)//[UINib nibWithNibName:@"PersonCell" bundle:nil]; //这句话就相当于把PersonCell.xib放到了内存里
        self.personNib = UINib (nibName: "", bundle: nil)

    }
//    //闭包
//    if MyColsure != nil {
//       MyColsure!("我的block")
//    }
    //闭包属性的赋值
    // *定义的闭包和参数闭包必须一模一样：参数类型，参数个数，返回值类型
    func methodd(complition:@escaping ([String:AnyObject])->()) {
        
        MyColsure = complition  //赋值就这么简单
        
    }
    @objc func hello() -> Void{
        print("通知 hello")
    }
    //guard 知识点: guard语句只会有一个代码块，guard语句判断其后的表达式布尔值为false时，才会执行之后代码块里的代码，如果为true，则跳过整个guard语句
    func checkup(person: [String: AnyObject?]) {
        
        // 检查身份证，如果身份证没带，则不能进入考场
        guard let id = person["id"] else {
            print("没有身份证，不能进入考场!")
            return
        }
        
        // 检查准考证，如果准考证没带，则不能进入考场
        guard let examNumber = person["examNumber"] else {
            print("没有准考证，不能进入考场!")
            return
        }
        
        // 身份证和准考证齐全，方可进入考场
        print("您的身份证号为:\(String(describing: id))，准考证号为:\(String(describing: examNumber))。请进入考场!")
        
    }

    @objc func backActions(_ sender: UIButton) {
        delegate_zsj?.change(title: "首页")
        delegate_zsj?.ChangeColoer(Coloer: UIColor.purple)
        delegate_zsj?.ChangSucces(YON: true)
        print("select new button")
        
        if swiftBlock != nil{
            swiftBlock!("aaa","bbb","ccc","ddd")
        }
        self.dismiss(animated: true, completion: nil)
//        let vc:UIViewController = self.presentationController
//        if vc is ViewController{
//
//        }
    }
    @objc func btnClick(_ sender: UIButton) {
        var str: String
        switch sender.tag {
        case 1001:
            str = "LeftUp Button"
        case 1002:
            str = "RightUp Button"
        case 1003:
            str = "LeftDown Button"
        case 1004:
            str = "RightDown Button"
        default:
            str = "Center Button"
        }
        print("current click event is \(str)")
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

