//
//  ViewController.swift
//  Log in Demo
//
//  Created by SHS on 16/1/19.
//  Copyright © 2019 SHS. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    
    @IBOutlet var label: UILabel!
    
    @IBOutlet var logInButtom: UIButton!

    @IBAction func logIn(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let newValue = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
        
        newValue.setValue(textField.text, forKey: "name")
        
        do {
            
            try context.save()
            
            textField.alpha = 0
            
            logInButtom.alpha = 0
            
            label.alpha = 1
            
            label.text = "Hi there " + textField.text! + "!"
            
            
        } catch {
            
            print("Failed to save")
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.fetch(request)
            
            for result in results as! [NSManagedObject] {
                
                if let username = result.value(forKey: "name") as? String {
                    
                    textField.alpha = 0
                    
                    logInButtom.alpha = 0
                    
                    label.alpha = 1
                    
                    label.text = "Hi there " + username + "!"
                    
                }
                
            }
            
        } catch {
            
            print("There is an error")
            
        }
        
    }


}

