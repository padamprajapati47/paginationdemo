
//
//  Extenstion.swift


//Class is defined for extension , it will add some more functions to apple controls

import UIKit
import Alamofire

extension Date {
    
    public static func convertStringToGiventUTCformate(_ dateinString:String,currntStringForamte:String,convertedtoformate:String)->String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = currntStringForamte
        
        let newDate = dateFormatter.date(from: dateinString) ?? Date()
        dateFormatter.dateFormat = convertedtoformate
        
        return dateFormatter.string(from: newDate)
        
    }
   
}

extension Int {
    func toString() -> String? {
        return String(format:"%d",self)
    }
}

extension Array {
  
    mutating func removeObjectFromArray<T>(_ obj: T) where T : Equatable {
        self = self.filter({$0 as? T != obj})
    }
 
    func contains<T>(_ obj: T) -> Bool where T : Equatable {
            return self.filter({$0 as? T == obj}).count > 0
    }
    
}

extension UIStoryboard {
    
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
  
    var identifier: String {
        if let name = self.value(forKey: "name") as? String {
            return name
        }
        return ""
    }
    
    public func get<T:UIViewController>(_ identifier: T.Type) -> T? {
        let storyboardID = String(describing: identifier)
        
        guard let viewController = instantiateViewController(withIdentifier: storyboardID) as? T else {
            return nil
        }
        return viewController
    }
    
}

extension UIApplication {
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}


