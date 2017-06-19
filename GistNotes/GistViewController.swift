//
//  GistViewController.swift
//  GistNotes
//
//  Created by ios-junior on 27.05.17.
//  Copyright © 2017 ios-junior. All rights reserved.
//

import UIKit

class GistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {

    var gist: Gist?
    
    func update() {
        loginLabel.text = self.gist?.login ?? "unknow user"
        if let date = self.gist?.created_at {
            dateLabel.text = String().dateWithFormat(dateString: date)
        }
        
        if let id = self.gist?.id {
            idLabel.text = "#" + id
        }
        
        descTextView.text = self.gist?.desc
        setupAvatarImageView()
        
        if let gist_id = gist?.id {
            notes = Note.fetchNoteByGist(gist_id: gist_id)
            tableView.reloadData()
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
    
    let originalGistButton: UIButton = {
        let infoButton = UIButton(type: .infoLight)
        infoButton.addTarget(self, action: #selector(actionOriginalGist(_:)), for: .touchUpInside)
        return infoButton
    }()
    
    func actionOriginalGist(_ sender: Any) {
        let originalGistVC = OriginalViewController()
        originalGistVC.gist = gist
        navigationController?.pushViewController(originalGistVC, animated: true)
    }
    
    
    let notesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("notes", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(UIColor(red: 9/255, green: 80/255, blue: 208/255, alpha: 1), for: .normal)
        return button
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
    
    let notesActionView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(colorLiteralRed: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    let notesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkGray
        label.text = "notes"
        return label
    }()
    
    let addNotesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+ add note", for: .normal)
        button.addTarget(self, action: #selector(addNotes(_:)), for: .touchUpInside)
        button.setTitleColor(UIColor(colorLiteralRed: 53/255, green: 144/255, blue: 255/255, alpha: 1), for: .normal)
        return button
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var notes = [Note]()
    
    func actionEdit(_ sender: AnyObject) {
        let gistEditVC = GistEditViewController()
        gistEditVC.gist = gist
        navigationController?.pushViewController(gistEditVC, animated: true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        actionEdit(descTextView)
    }
    
    func addNotes(_ sender: Any) {
        print("add notes")
        let noteEditVC = NoteEditViewController()
        noteEditVC.gist = gist
        navigationController?.pushViewController(noteEditVC, animated: true)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        let note = notes[indexPath.row]
        cell?.textLabel?.text = note.desc
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let noteEditVC = NoteEditViewController()
        noteEditVC.note = notes[indexPath.item]
        navigationController?.pushViewController(noteEditVC, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        descTextView.delegate = self
        
        navigationItem.title = "Gist"

        navigationController?.navigationBar.isTranslucent = false
        
        let rigthButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(actionEdit(_:)))
        navigationItem.rightBarButtonItem = rigthButtonItem
    
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(headerView)
        
        headerView.addSubview(avatarImageView)
        headerView.addSubview(loginLabel)
        headerView.addSubview(dateLabel)
        headerView.addSubview(idLabel)
        headerView.addSubview(originalGistButton)
        
        contentView.addSubview(notesActionView)
        contentView.addSubview(descTextView)
        
        notesActionView.addSubview(notesLabel)
        notesActionView.addSubview(addNotesButton)
        notesActionView.addSubview(tableView)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        update()
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: scrollView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: scrollView)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: contentView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: contentView)
        view.addConstraint(NSLayoutConstraint(item: contentView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))

        
        scrollView.addConstraintsWithFormat(format: "H:|[v0]|", views: headerView)
        scrollView.addConstraintsWithFormat(format: "H:|[v0]|", views: notesActionView)
        scrollView.addConstraintsWithFormat(format: "H:|[v0]|", views: descTextView)
        scrollView.addConstraintsWithFormat(format: "V:|[v0(100)]-16-[v1]-16-[v2(266)]|", views: headerView, descTextView, notesActionView)
        
        headerView.addConstraintsWithFormat(format: "H:|-16-[v0(64)]-16-[v1]-[v2]-16-|", views: avatarImageView, loginLabel, dateLabel)
        headerView.addConstraintsWithFormat(format: "H:|-16-[v0]-16-[v1]-[v2]-|", views: avatarImageView, idLabel, originalGistButton)
        
        headerView.addConstraintsWithFormat(format: "V:|-16-[v0(64)]-20-|", views: avatarImageView)
        headerView.addConstraintsWithFormat(format: "V:|-16-[v0]-[v1]-36-|", views: loginLabel, idLabel)
        headerView.addConstraintsWithFormat(format: "V:|-16-[v0]-[v1]-36-|", views: dateLabel, idLabel)
        
        headerView.addConstraintsWithFormat(format: "V:|-16-[v0]-[v1]-36-|", views: dateLabel, originalGistButton)
        headerView.addConstraintsWithFormat(format: "V:|-16-[v0]-[v1]-36-|", views: dateLabel, originalGistButton)
        
        notesActionView.addConstraintsWithFormat(format: "H:|-[v0]-[v1(90)]-|", views: notesLabel, addNotesButton)
        notesActionView.addConstraintsWithFormat(format: "H:|[v0]|", views: tableView)
        notesActionView.addConstraintsWithFormat(format: "V:|-[v0(30)]-[v1(220)]|", views: notesLabel, tableView)
        notesActionView.addConstraintsWithFormat(format: "V:|-[v0(30)]-[v1(220)]|", views: addNotesButton, tableView)
        
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
