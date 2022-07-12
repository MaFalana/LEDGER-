//
//  File.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/3/22.
//

import Foundation
import SwiftUI
import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var SecondaryView: UIView!
    @IBOutlet weak var lighticonButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //shadowSetup()
        if UserDefaults.standard.object(forKey: "isDark") != nil{} else
        {
            UserDefaults.standard.set(self.traitCollection.userInterfaceStyle == .dark ? true: false, forKey: "isDark")
        }
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)
        {
            if self.traitCollection.userInterfaceStyle == .dark && !(UserDefaults.standard.value(forKey: "isDark") as! Bool)
            {
                changeIcon("Appicon-Dark")
                UserDefaults.standard.set(true, forKey: "isDark")
            }
            else if (UserDefaults.standard.value(forKey: "isDark") as! Bool) && self.traitCollection.userInterfaceStyle == .light
            {
                changeIcon("Appicon")
                UserDefaults.standard.set(false, forKey: "isDark")
            }
        }
    }
}




func changeIcon(_ iconName: String)
{
    guard UIApplication.shared.supportsAlternateIcons else
    {
        return
    }
    
    UIApplication.shared.setAlternateIconName(iconName == "" ? nil : iconName, completionHandler:
    {
        (error) in

        if let error = error
        {
            print ("App icon failed to change due to \(error.localizedDescription)")
        }

        else
        {

            print ("App icon changed successfully")
        }
    })
}
