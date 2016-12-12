//
//  ViewController.swift
//  Whats The Weather
//
//  Created by Rishav Pandey on 09/12/16.
//  Copyright © 2016 AviaBird. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var city: UITextField!
    @IBOutlet var discription: UILabel!
    
    @IBAction func weatherCheck(_ sender: AnyObject) {
        discription.text = ""
        let city_name = NSString(string: city.text!)
        let cityName = city_name.replacingOccurrences(of: " ", with: "-")
        let url = URL(string: "http://www.weather-forecast.com/locations/\(cityName)/forecasts/latest")!
        let urlRequest = NSMutableURLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest as URLRequest) {
            data, response, error in
            if error != nil {
                print(error)
            } else {
                if let unwrappedData = data {
                    let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                    let substring = "</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                    if let stringArray = dataString?.components(separatedBy: substring) {
                        if stringArray.count > 1 {
                            print(stringArray[1])
                            let string = "</span>"
                            let mainString = stringArray[1].components(separatedBy: string)
                            print(mainString[0])
                            let message = mainString[0].replacingOccurrences(of: "&deg;", with: "°")
                            DispatchQueue.main.sync(execute: {
                                self.discription.textColor = UIColor.brown
                                self.discription.text = "\(message)"
                            })
                        }else {
                            DispatchQueue.main.sync(execute: {
                                self.discription.textColor = UIColor.red
                                self.discription.text = "Please Enter Correct City Name"
                            })
                        }
                    }
                }
            }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

