//
//  GistCell.swift
//  GistNotes
//
//  Created by ios-junior on 27.05.17.
//  Copyright © 2017 ios-junior. All rights reserved.
//

import UIKit

class GistCell: UICollectionViewCell {
 
    
    weak var navigationController: UINavigationController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var gist: Gist? {
        
        didSet {
            loginLabel.text = self.gist?.login ?? "unknow user"
            if let date = self.gist?.created_at {
                dateLabel.text = String().dateWithFormat(dateString: date)
            }
            
            if let id = self.gist?.id {
                idLabel.text = "#" + id
            
                let notesCount = Gist.notesCount(gist_id: id)
                if notesCount > 0 {
                    commentsLabel.text = String(Gist.notesCount(gist_id: id)) + " notes"
                }
                else {
                    commentsLabel.text = ""
                }
                
            }

            descTextView.text = self.gist?.desc
            setupAvatarImageView()
        }
    }
    
    func setupAvatarImageView() {
        
        if let avatarImageUrl = gist?.avatarUrl {
            avatarImageView.loadImageUsingUrlString(avatarImageUrl)
        }
        else {
            avatarImageView.image = UIImage(named: "avatar")
        }
    }
    
    let detailButton: UIButton = {
        let button = UIButton()
        button.setTitle("•••", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(actionGistDetail(_:)), for: .touchUpInside)

        return button
    }()
    
    func actionGistDetail(_ sender: Any) {
        
        let gistViewController = GistViewController()
        navigationController?.pushViewController(gistViewController, animated: true)
    }
    
    let avatarImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = nil
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 32
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "unknow user"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(colorLiteralRed: 53/255, green: 144/255, blue: 255/255, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    let descTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 10)
        textView.contentInset = UIEdgeInsetsMake(-4,-4,0,0)
        textView.isEditable = false
        textView.isUserInteractionEnabled = false
        return textView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(colorLiteralRed: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkGray
        return label
    }()
    
    func setupViews() {
        
        addSubview(avatarImageView)
        addSubview(loginLabel)
        addSubview(dateLabel)
        addSubview(idLabel)
        addSubview(descTextView)
        addSubview(separatorView)
        addSubview(commentsLabel)

        addConstraintsWithFormat(format: "H:|-16-[v0(64)]-16-[v1]-[v2]-16-|", views: avatarImageView, loginLabel, dateLabel)
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-[v1]-|", views: avatarImageView, idLabel)
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-[v1]-|", views: avatarImageView, descTextView)
        addConstraintsWithFormat(format: "H:|-16-[v0]-|", views: commentsLabel)
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: separatorView)
        
        addConstraintsWithFormat(format: "V:|-16-[v0(64)]-31-[v1(1)]-[v2]-|", views: avatarImageView, separatorView, commentsLabel)
        addConstraintsWithFormat(format: "V:|-16-[v0]-[v1]-[v2(30)]-[v3]-[v4]-|", views: loginLabel, idLabel, descTextView, separatorView, commentsLabel)
        addConstraintsWithFormat(format: "V:|-16-[v0]-[v1]-[v2(30)]-[v3]-[v4]-|", views: dateLabel, idLabel, descTextView, separatorView, commentsLabel)
        

        
        
    }

}
