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
class CalculatorViewController: BaseViewController, UITabBarDelegate, UIPickerViewDataSource,UIPickerViewDelegate  {
    var rootRouter: RootRouter? {
        return router as? RootRouter
    }
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    var outtoolBar = UIToolbar()
    var outpicker  = UIPickerView()
    
    let cur : [String] = ["USD","GBP","JPY","CNY","CAD","AUD","SGD","TWD","CHF","THB","MYR","FRF"]
    let cur2 = ["USD","GBP","JPY","CNY","CAD","AUD","SGD","TWD","CHF","THB","MYR","FRF"]
    @IBOutlet var select: UIButton!
    @IBOutlet var selectout: UIButton!
    @IBOutlet var output: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTabBar?.delegate = self
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
        }
        else{
            selectout.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
            selectout.setTitle(cur2[row], for: .normal)
        }
        
    }
    

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch(tabBar.selectedItem?.title){
        case "Insights":
            self.dismiss(animated: false, completion: nil)
            rootRouter?.showInsights()
            break
        case "Home":
            self.dismiss(animated: false, completion: nil)
            rootRouter?.showHome()
        case "Calculator":
            self.dismiss(animated: false, completion: nil)
            rootRouter?.showCalculators()
        case .none:
            break
        case .some(_):
            break
        }
    }
}
