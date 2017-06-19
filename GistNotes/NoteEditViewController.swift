//
//  NoteEditViewController.swift
//  GistNotes
//
//  Created by ios-junior on 28.05.17.
//  Copyright © 2017 ios-junior. All rights reserved.
//

import UIKit
import CoreData

class NoteEditViewController: UIViewController {

    var gist: Gist? = nil
    var note: Note? = nil
    
    var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 16)
        return textView
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationItem.title = "Note"

        let rigthButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(actionDone(_:)))
        navigationItem.rightBarButtonItem = rigthButtonItem
        
        view.backgroundColor = UIColor.white
        textView.text = note?.desc
        textView.becomeFirstResponder()
        view.addSubview(textView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDidShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: textView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: textView)
    }
    
    func handleKeyboardDidShow(notification: Notification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let insets: UIEdgeInsets = UIEdgeInsetsMake(self.textView.contentInset.top, 0, keyboardSize.height, 0)
            self.textView.contentInset = insets
            self.textView.scrollIndicatorInsets = insets
            self.textView.contentOffset = CGPoint(x: self.textView.contentOffset.x, y: self.textView.contentOffset.y + keyboardSize.height)
            
        }
        
    }
    
    func handleKeyboardWillHide(notification: Notification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let insets: UIEdgeInsets = UIEdgeInsetsMake(self.textView.contentInset.top, 0, keyboardSize.height, 0)
            self.textView.contentInset = insets
            self.textView.scrollIndicatorInsets = insets
        }
        
    }
    
    func actionDone(_ sender: AnyObject) {
        

        if let currentNote = note {
            currentNote.desc = textView.text
            do
            {
                try currentNote.managedObjectContext?.save()
                print("Core Data Saved")
                
            }
            catch let error{
                print("Core Data Error \(error)")
                
            }
            
        }
        else {
            
            let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: Note.context) as! Note
            note.gist_id = gist?.id
            note.desc = textView.text
            
            do
            {
                try note.managedObjectContext!.save()
                print("Core Data Saved")
                
            }
            catch let error{
                print("Core Data Error \(error)")
            }
            
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    

}
