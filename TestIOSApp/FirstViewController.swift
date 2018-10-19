//
//  FirstViewController.swift
//  TestIOSApp
//
//  Created by Hovhannes Sukiasyan on 18.10.2018.
//  Copyright © 2018 Hovhannes Sukiasyan. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    let customView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        initLogoImageView()
        initCustomView()
        
    }
    
    func setUI() {
        let view = UIView(frame: self.view.frame)
        let gradient = CAGradientLayer()
        
        gradient.frame = view.bounds
        
        let upColor = UIColor(hexString: "#7249E7")
        let downColor = UIColor(hexString: "#871F97")
        
        gradient.colors = [upColor.cgColor, downColor.cgColor]
        self.view.layer.insertSublayer(gradient, at: 0)
    }
    
    func initLogoImageView() {
        let x = self.view.frame.size.width/2 - 73.5
        let y = self.view.frame.size.height/4 - 30
        let logoIV = UIImageView(frame:CGRect(x:x, y:y, width:147, height:60))
        logoIV.image = UIImage (named: "logo")
        logoIV.contentMode = .scaleAspectFill
        self.view.addSubview(logoIV)
    }
   
    func initCustomView() {
        let width = self.view.frame.size.width - 40
        let y = self.view.frame.size.height/2
        customView.frame = CGRect(x:20, y:y, width:width, height:y)
        customView.backgroundColor = UIColor.white
        customView.layer.cornerRadius = 8
        self.view.addSubview(customView)
        initCustomButton()
    }
    
    func initCustomButton() {
        let width = self.view.frame.size.width - 100
        let customBtn = UIButton(frame:CGRect(x:30, y:40, width:width, height:40))
        customBtn.layer.borderColor = UIColor(hexString: "#871F97").cgColor
        customBtn.layer.borderWidth = 2
        customBtn.layer.cornerRadius = 20
        customBtn.setTitle("Вперед", for: UIControlState.normal)
        customBtn.setTitleColor(UIColor(hexString: "#871F97"), for: .normal)
        customBtn.addTarget(self, action:#selector(customAction), for: .touchUpInside)
        self.customView.addSubview(customBtn)
    }
    
    @objc func customAction() {
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainVC") as UIViewController
        self.present(viewController, animated: false, completion: nil)
    }
    
}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
