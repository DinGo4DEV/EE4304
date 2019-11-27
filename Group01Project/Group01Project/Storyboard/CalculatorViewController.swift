//
//  CalculatorViewController.swift
//  Group01Project
//
//  Created by kamtat ho on 8/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import UIKit


extension UIImage {
    func alpha(_ value:CGFloat)->UIImage?
    {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

extension UIButton
{
    func disclosureButton(baseColor:UIColor)
    {
        guard let image = UIImage(named: "icons8-chevron-down-50.png")?.withRenderingMode(.alwaysTemplate) else
        {
            return
        }
        guard let imageHighlight = UIImage(named: "icons8-chevron-down-50.png")?.alpha(0.3)?.withRenderingMode(.alwaysTemplate) else
        {
            return
        }
        self.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        self.setTitle("select", for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
        self.setImage(image, for: .normal)
        self.setImage(imageHighlight, for: .highlighted)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: self.bounds.size.width-image.size.width*0.3, bottom: 0, right: 0);
        self.layer.borderWidth = 0.25
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.contentEdgeInsets = UIEdgeInsets(top: 10,left: 0,bottom: 10,right: 5)
        
    }
}
class CalculatorViewController: BaseViewController, UITabBarDelegate, UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate  {
    var rootRouter: RootRouter? {
        return router as? RootRouter
    }
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    var outtoolBar = UIToolbar()
    var outpicker  = UIPickerView()
    var firstUnit : String = ""
    var secondUnit : String = ""
    var inputrate : Double = 0.0
    var outputrate : Double = 0.0
    let cur : [String] = ["USD","GBP","JPY","CAD","AUD","SGD","TWD","CHF","CNY","KRW","THB","MYR","EUR","PHP","INR","HKD"]
    let cur2 = ["USD","GBP","JPY","CAD","AUD","SGD","TWD","CHF","CNY","KRW","THB","MYR","EUR","PHP","INR","HKD"]
    @IBOutlet var select: UIButton!
    @IBOutlet var selectout: UIButton!
    @IBOutlet var output: UILabel!
    @IBOutlet var input: UITextField!
    @IBOutlet var image: UIImageView!
    @IBOutlet var image2: UIImageView!

    
    override func loadView() {
        super.loadView()
        if(RestManager.HKMARateJson == nil){
            var parma:HKMA.params = HKMA.params()
            apiManager.request_fxChange_HKMA(params: parma){
                [weak self](result) in
                RestManager.HKMARateJson = result as? HKMA.FxRateJson
            }
        }
    }
    
    @IBAction func calculate(_sender: UIButton){
        print(RestManager.HKMARateJson.result!.records![0])
        if var amount = Double(input.text!) {
            var rate : Double = 0
        if firstUnit != "" && secondUnit != ""{
            switch firstUnit{
            case "USD":
                 amount = amount * RestManager.HKMARateJson.result!.records![0].usd!
            case "GBP":
                amount = amount * RestManager.HKMARateJson.result!.records![0].gbp!
            case "JPY":
                amount = amount * RestManager.HKMARateJson.result!.records![0].jpy!
            case "SGD":
                amount = amount * RestManager.HKMARateJson.result!.records![0].sgd!
            case "AUD":
                amount = amount * RestManager.HKMARateJson.result!.records![0].aud!
            case "TWD":
                amount = amount * RestManager.HKMARateJson.result!.records![0].twd!
            case "CAD":
                amount = amount * RestManager.HKMARateJson.result!.records![0].cad!
            case "CHF":
                amount = amount * RestManager.HKMARateJson.result!.records![0].chf!
            case "CNY":
                amount = amount * RestManager.HKMARateJson.result!.records![0].cny!
            case "KRW":
                amount = amount * RestManager.HKMARateJson.result!.records![0].krw!
            case "THB":
                amount = amount * RestManager.HKMARateJson.result!.records![0].thb!
            case "MYR":
                amount = amount * RestManager.HKMARateJson.result!.records![0].myr!
            case "EUR":
                amount = amount * RestManager.HKMARateJson.result!.records![0].eur!
            case "PHP":
                amount = amount * RestManager.HKMARateJson.result!.records![0].php!
            case "INR":
                amount = amount * RestManager.HKMARateJson.result!.records![0].inr!
            case "HKD":
                amount = amount * 1
            default:
                amount = 0
            }
            switch secondUnit{
            case "USD":
                amount = amount / RestManager.HKMARateJson.result!.records![0].usd!
            case "GBP":
                amount = amount / RestManager.HKMARateJson.result!.records![0].gbp!
            case "JPY":
                amount = amount / RestManager.HKMARateJson.result!.records![0].jpy!
            case "SGD":
                amount = amount / RestManager.HKMARateJson.result!.records![0].sgd!
            case "AUD":
                amount = amount / RestManager.HKMARateJson.result!.records![0].aud!
            case "TWD":
                amount = amount / RestManager.HKMARateJson.result!.records![0].twd!
            case "CAD":
                amount = amount / RestManager.HKMARateJson.result!.records![0].cad!
            case "CHF":
                amount = amount / RestManager.HKMARateJson.result!.records![0].chf!
            case "CNY":
                amount = amount / RestManager.HKMARateJson.result!.records![0].cny!
            case "KRW":
                amount = amount / RestManager.HKMARateJson.result!.records![0].krw!
            case "THB":
                amount = amount / RestManager.HKMARateJson.result!.records![0].thb!
            case "MYR":
                amount = amount / RestManager.HKMARateJson.result!.records![0].myr!
            case "EUR":
                amount = amount / RestManager.HKMARateJson.result!.records![0].eur!
            case "PHP":
                amount = amount / RestManager.HKMARateJson.result!.records![0].php!
            case "INR":
                amount = amount / RestManager.HKMARateJson.result!.records![0].inr!
            case "HKD":
                amount = amount * 1
            default:
                amount = 0
            }
            print(amount)
            let new = Double( round(1000 * amount)/1000 )
            var b: String = String(new)
            output.text! = b
        }
        else {
            let alert = UIAlertController(title: "Data Validation Error", message: "You haven't selected both currency", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { (action: UIAlertAction!) in
            }))
            present(alert, animated: true , completion: nil)
            }
    }
        else {
            let alert = UIAlertController(title: "Data Validation Error", message: "Input cannot empty", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { (action: UIAlertAction!) in
            }))
            present(alert, animated: true , completion: nil)
        }
        input.resignFirstResponder()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        picker.dataSource = self
        outpicker.delegate = self
        outpicker.dataSource = self
        
        select.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        select.disclosureButton(baseColor: view.tintColor)
        selectout.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        selectout.disclosureButton(baseColor: view.tintColor)
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        view.layoutIfNeeded()
    }
    
    @IBAction func ShowPicker(_ sender: UIButton) {
        picker = UIPickerView.init()
        picker.tag = 1
        picker.delegate = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = UIBarStyle.default
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    @IBAction func ShowPickerOut(_ sender: UIButton) {
        outpicker = UIPickerView.init()
        outpicker.tag = 2
        outpicker.delegate = self
        outpicker.backgroundColor = UIColor.white
        outpicker.setValue(UIColor.black, forKey: "textColor")
        outpicker.autoresizingMask = .flexibleWidth
        outpicker.contentMode = .center
        outpicker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(outpicker)
        
        outtoolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        outtoolBar.barStyle = UIBarStyle.default
        outtoolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        
        self.view.addSubview(outtoolBar)
    }
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        outtoolBar.removeFromSuperview()
        outpicker.removeFromSuperview()
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == picker{
            return cur.count
        }
        else{
            return cur2.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == picker{
            return cur[row]
        }
        else{
            return cur2[row]
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == picker{
            select.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
            select.setTitle(cur[row], for: .normal)
            firstUnit = cur[row]
            changeflag(country: firstUnit, flag: image)
        }
        else{
            selectout.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
            selectout.setTitle(cur2[row], for: .normal)
            secondUnit = cur2[row]
            changeflag(country: secondUnit, flag: image2)
        }
        
    }
    func changeflag(country: String, flag: UIImageView ){
        switch country{
        case "USD":
            flag.image = UIImage(named: "usd")
        case "GBP":
            flag.image = UIImage(named: "gbp")
        case "JPY":
            flag.image = UIImage(named: "jpy")
        case "SGD":
            flag.image = UIImage(named: "sgd")
        case "AUD":
            flag.image = UIImage(named: "aud")
        case "TWD":
            flag.image = UIImage(named: "twd")
        case "CAD":
            flag.image = UIImage(named: "cad")
        case "CHF":
            flag.image = UIImage(named: "chf")
        case "CNY":
            flag.image = UIImage(named: "cny")
        case "KRW":
            flag.image = UIImage(named: "krw")
        case "THB":
            flag.image = UIImage(named: "thb")
        case "MYR":
            flag.image = UIImage(named: "myr")
        case "EUR":
            flag.image = UIImage(named: "eur")
        case "PHP":
            flag.image = UIImage(named: "php")
        case "INR":
            flag.image = UIImage(named: "inr")
        case "HKD":
            flag.image = UIImage(named: "hkd")
        default:
            flag.image = UIImage(named: "hkd")
    }
    
    }
}
