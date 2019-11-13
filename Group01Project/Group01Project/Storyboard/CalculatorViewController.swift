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

class CalculatorViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    let cur : [String] = ["USD","GBP","JPY","CNY","CAD","AUD","SGD","TWD","CHF","THB","MYR","FRF"]
    let cur2 = ["USD","GBP","JPY","CNY","CAD","AUD","SGD","TWD","CHF","THB","MYR","FRF"]
    @IBOutlet var select: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        picker.delegate = self
        picker.dataSource = self
        select.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        select.disclosureButton(baseColor: view.tintColor)
        
        
    }
    override func viewDidLayoutSubviews() {
        view.layoutIfNeeded()
    }
    
    @IBAction func ShowPicker(_ sender: UIButton) {
        picker = UIPickerView.init()
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
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cur.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cur[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        select.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        select.setTitle(cur[row], for: .normal)
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
