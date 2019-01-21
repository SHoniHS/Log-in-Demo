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
    
    @IBOutlet var logOutButton: UIButton!
    
    @IBAction func logOut(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
       
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        do {
            
            let results = try context.fetch(request)
            
            if results.count > 0 {
                
                for result in results as![NSManagedObject]{
                    
                    context.delete(result)
                    
                    do {
                        
                        try context.save()
                        
                    } catch {
                        
                        print("Indicidual delete failed")
                        
                    }
                }
                
                label.alpha = 0
                
                logOutButton.alpha = 0
                
        //        textField.alpha = 1
                
                logInButtom.alpha = 1
                
                isLoggedIn = false
                
                logOutButton.alpha = 0
                
                logInButtom.setTitle("Login", for: [])
                
            }
            
        } catch {
            
            print("Delete failed")
            
        }
    }
    
    @IBOutlet var textField: UITextField!
    
    @IBOutlet var label: UILabel!
    
    @IBOutlet var logInButtom: UIButton!
    
    var isLoggedIn = false

    @IBAction func logIn(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        if isLoggedIn {
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            
            do {
                
                let results = try context.fetch(request)
                
                if results.count > 0 {
                    
                    for result in results as! [NSManagedObject] {
                        
                        result.setValue(textField.text, forKey: "name")
                        
                        do {
                            
                            try context.save()
                            
                        } catch {
                            
                            print("Update username failed")
                        }
                        
                    }
                    
                    label.text = "Hi there " + textField.text! + "!"
                    
                }
                
            } catch {
                
                print("Update username failed")
            }
            
            
        } else {
            let newValue = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
            
            newValue.setValue(textField.text, forKey: "name")
            
            do {
                
                try context.save()
                
       //         textField.alpha = 0
                
       //         logInButtom.alpha = 0
                
                logInButtom.setTitle("Update username", for: [])
                
                label.alpha = 1
                
                label.text = "Hi there " + textField.text! + "!"
                
                isLoggedIn = true
                
                logOutButton.alpha = 1
                
            } catch {
                
                print("Failed to save")
                
            }
           
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        request.predicate = NSPredicate(format: "name = %@", "Sonia")
        
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.fetch(request)
            
            for result in results as! [NSManagedObject] {
                
                if let username = result.value(forKey: "name") as? String {
                    
          //          textField.alpha = 0
          
          //          logInButtom.alpha = 0
                    
                    logInButtom.setTitle("Update username", for: [])

                    label.alpha = 1
                    
                    label.text = "Hi there " + username + "!"
                    
                }
                
            }
            
        } catch {
            
            print("There is an error")
            
        }
        
    }


}

