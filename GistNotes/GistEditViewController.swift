//
//  GistEditViewController.swift
//  GistNotes
//
//  Created by ios-junior on 27.05.17.
//  Copyright © 2017 ios-junior. All rights reserved.
//

import UIKit

class GistEditViewController: UIViewController {

    var gist: Gist? = nil
    
    var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 16)
        return textView
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Gist"

        let rigthButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(actionDone(_:)))
        navigationItem.rightBarButtonItem = rigthButtonItem
        
        view.backgroundColor = UIColor.white
        textView.text = gist?.desc
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

        if let editingGist = gist {
            editingGist.desc = textView.text
            
            do {
                try editingGist.managedObjectContext?.save()
            } catch {
                let saveError = error as NSError
                print(saveError)
            }
        }

        navigationController?.popViewController(animated: true)
    }
    
}
