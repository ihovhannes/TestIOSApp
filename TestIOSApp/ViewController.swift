//
//  ViewController.swift
//  TestIOSApp
//
//  Created by Hovhannes Sukiasyan on 18.10.2018.
//  Copyright © 2018 Hovhannes Sukiasyan. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorImageView: UIImageView!
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
                
        addSlideMenuButton()
        setDefault()
    
        NotificationCenter.default.addObserver(self,
                                          selector: #selector(loadDataFromAPI),
                                              name: NSNotification.Name(
                                          rawValue: "dataDownloadNotification"),
                                            object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func loadDataFromAPI() {
        let api = API()
        api.fetchResultsFromApi {
            (result: API.Server) in
            
            let time = self.getDateFromTimeStamp(timeStamp: Double(result.ts ?? 0))
            let temp = "\(result.t ?? 0)" + "°C"
            let city = result.name ?? ""
            
            DispatchQueue.main.async{
                self.hideDefault()
                self.cityLabel?.text = city
                self.timeLabel?.text = time
                self.tempLabel?.text = temp
            }
        }
    }
    
    func setDefault() {
        infoView.isHidden = true
        errorLabel.text = "Нет данных\nОткройте меню и нажмите\n«Загрузить»"
    }
    
    func hideDefault() {
        infoView.isHidden = false
        errorLabel.isHidden = true
        errorImageView.isHidden = true
        infoView.frame = CGRect(x: 0, y: 65, width: view.frame.size.width, height: 258)
        self.view.addSubview(infoView!)
    }

    func getDateFromTimeStamp(timeStamp : Double) -> String {
        
        let date = NSDate(timeIntervalSince1970: (timeStamp / 1000))
        
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "HH:mm, dd MMMM YYYY"

        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
    
}

