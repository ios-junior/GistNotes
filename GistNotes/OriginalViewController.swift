//
//  OriginalViewController.swift
//  GistNotes
//
//  Created by ios-junior on 28.05.17.
//  Copyright © 2017 ios-junior. All rights reserved.
//

import UIKit

class OriginalViewController: UIViewController {

    var gist: Gist?
    
    func update() {
        loginLabel.text = self.gist?.login ?? "unknow user"
        if let date = self.gist?.created_at {
            dateLabel.text = String().dateWithFormat(dateString: date)
        }
        
        if let id = self.gist?.id {
            idLabel.text = "#" + id
        }
        
        descTextView.text = self.gist?.desc_original
        setupAvatarImageView()
        
    }
    func setupAvatarImageView() {
        
        if let avatarImageUrl = gist?.avatarUrl {
            avatarImageView.loadImageUsingUrlString(avatarImageUrl)
        }
        else {
            avatarImageView.image = UIImage(named: "avatar")
        }
    }
    
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let detailView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let avatarImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 32
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(colorLiteralRed: 53/255, green: 144/255, blue: 255/255, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let descTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 12)
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = true
        return textView
    }()
    
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(colorLiteralRed: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        navigationItem.title = "Original gist"
        navigationController?.navigationBar.isTranslucent = false
        
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(headerView)
        
        headerView.addSubview(avatarImageView)
        headerView.addSubview(loginLabel)
        headerView.addSubview(dateLabel)
        headerView.addSubview(idLabel)
        
        contentView.addSubview(descTextView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        update()
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: scrollView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: scrollView)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: contentView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: contentView)
        view.addConstraint(NSLayoutConstraint(item: contentView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))
        
        
        scrollView.addConstraintsWithFormat(format: "H:|[v0]|", views: headerView)
        scrollView.addConstraintsWithFormat(format: "H:|[v0]|", views: descTextView)
        scrollView.addConstraintsWithFormat(format: "V:|[v0(100)]-16-[v1]-16-|", views: headerView, descTextView)
        
        headerView.addConstraintsWithFormat(format: "H:|-16-[v0(64)]-16-[v1]-[v2]-16-|", views: avatarImageView, loginLabel, dateLabel)
        headerView.addConstraintsWithFormat(format: "H:|-16-[v0]-16-[v1]-|", views: avatarImageView, idLabel)
        headerView.addConstraintsWithFormat(format: "V:|-16-[v0(64)]-20-|", views: avatarImageView)
        headerView.addConstraintsWithFormat(format: "V:|-16-[v0]-[v1]-36-|", views: loginLabel, idLabel)
        headerView.addConstraintsWithFormat(format: "V:|-16-[v0]-[v1]-36-|", views: dateLabel, idLabel)
        
        
        let headerViewHeight: CGFloat = 100
        
        let fixedWidth = descTextView.frame.size.width
        descTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = descTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = descTextView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        descTextView.frame = newFrame;
        
        let descTextViewHeight = descTextView.frame.height
        let contentHeight = headerViewHeight + 16 + descTextViewHeight + 16 + 266
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: contentHeight)
        
    }

}
