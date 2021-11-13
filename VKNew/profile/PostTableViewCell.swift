//
//  PostTableViewCell.swift
//  VKNew
//
//  Created by v.milchakova on 05.11.2021.
//

import UIKit
import SnapKit

class PostTableViewCell: UITableViewCell {
    let baseOffset: CGFloat =  16
    
    public func configureViaStorage(post: StoragePost){
        userNameLabel.text = post.author
        avatarImage.image = post.image
        userNameLabel.text = post.author
        userDescriptionLabel.text = post.title
        postImage.image = post.image
        postTextLabel.text = post.title
        likesLabel.text = "\(post.likes)"
        commentLabel.text = "\(post.views)"
    }
    
    public func configureViaCoreData(post: Post){
        userNameLabel.text = post.author
        postTextLabel.text = post.title
        likesLabel.text = "\(post.likes)"
        commentLabel.text = "\(post.views)"
        guard let image = post.image else {
            return
        }
        postImage.image = UIImage(data: image)
    }
    
    private lazy var view1: UIView = {
        let view = UIImageView()
        view.toAutoLayout()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var view2: UIView = {
        let view = UIImageView()
        view.toAutoLayout()
        view.layer.backgroundColor = UIColor(red: 0.962, green: 0.951, blue: 0.934, alpha: 1).cgColor
        return view
    }()
    
    public lazy var avatarImage: UIImageView = {
        let image = UIImageView()
        image.toAutoLayout()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .white
        
        image.layer.masksToBounds = false
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
        return image
    }()
    
    public lazy var userNameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.toAutoLayout()
        nameLabel.textColor = .black
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        return nameLabel
    }()
    
    public lazy var userDescriptionLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.toAutoLayout()
        nameLabel.textColor = .gray
        nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        nameLabel.numberOfLines = 2
        return nameLabel
    }()
    
    private lazy var menuButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.tintColor = UIColor(red: 1, green: 0.62, blue: 0.271, alpha: 1)
       // button.layer.backgroundColor = UIColor(red: 1, green: 0.62, blue: 0.271, alpha: 1).cgColor
        var img = UIImage(systemName: "list.bullet")
        button.setImage(img, for: .normal)
        //button.transform.rotated(by: CGFloat(Double.pi / 2))
        return button
    }()
    
    private lazy var horisontalLineImage: UIView = {
        let view = UIImageView()
        view.toAutoLayout()
        view.backgroundColor = UIColor(red: 0.495, green: 0.507, blue: 0.512, alpha: 1)
        return view
    }()

    private lazy var verticalLineImage: UIView = {
        let view = UIImageView()
        view.backgroundColor = .black
        view.toAutoLayout()
        return view
    }()
    
    public lazy var postImage: UIImageView = {
        let postImage = UIImageView()
        postImage.toAutoLayout()
        postImage.contentMode = .scaleAspectFit
        return postImage
    }()

    public lazy var postTextLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.toAutoLayout()
        descriptionLabel.textColor = .gray
        descriptionLabel.font = descriptionLabel.font.withSize(14)
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()

    private lazy var likesButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        return button
    }()

    public lazy var likesLabel: UILabel = {
        let likesLabel = UILabel()
        likesLabel.toAutoLayout()
        likesLabel.textColor = .black
        likesLabel.font = postTextLabel.font.withSize(16)
        return likesLabel
    }()

    private lazy var commentButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "bubble.left"), for: .normal)
        return button
    }()

    public lazy var commentLabel: UILabel = {
        let viewsLabel = UILabel()
        viewsLabel.toAutoLayout()
        viewsLabel.textColor = .black
        viewsLabel.font = postTextLabel.font.withSize(16)
        return viewsLabel
    }()

    private lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(view1)
        contentView.addSubview(view2)
        view1.addSubview(avatarImage)
        view1.addSubview(userNameLabel)
        view1.addSubview(userDescriptionLabel)
        view1.addSubview(menuButton)
        
        view2.addSubview(horisontalLineImage)
        view2.addSubview(verticalLineImage)

        view2.addSubview(postImage)
        view2.addSubview(postTextLabel)

        view2.addSubview(commentLabel)
        view2.addSubview(commentButton)

        view2.addSubview(likesButton)
        view2.addSubview(likesLabel)

        view2.addSubview(bookmarkButton)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {

        view1.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(25)
            make.height.equalTo(60)
            make.leading.equalTo(contentView).offset(15)
            make.trailing.equalTo(contentView).offset(-15)
        }
        
        avatarImage.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view1)
            make.width.equalTo(60)
            make.bottom.equalTo(view1)
            make.leading.equalTo(view1)
        }
        
        userNameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view1)
            make.height.equalTo(24)
            make.width.equalTo(153)
            make.leading.equalTo(avatarImage.snp.trailing).offset(24)
            make.trailing.equalTo(view1).offset(-107)
        }
        
        userDescriptionLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(userNameLabel.snp.bottom).offset(3)
            make.height.equalTo(20)
            make.width.equalTo(68)
            make.leading.equalTo(userNameLabel)
        }
        
        menuButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view1).offset(12)
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.trailing.equalTo(view1).offset(-25)
        }
        
        view2.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view1.snp.bottom).offset(12)
            make.height.equalTo(308)
            make.leading.equalTo(contentView)
            make.trailing.equalTo(contentView)
            make.bottom.equalTo(contentView.snp.bottom)
        }
        
        verticalLineImage.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view2).offset(20)
            make.bottom.equalTo(view2).offset(-69)
            make.width.equalTo(0.5)
            make.leading.equalTo(view2).offset(28)
        }
        
        postTextLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view2).offset(10)
            make.trailing.equalTo(view2).offset(-15)
            make.height.equalTo(100)
            make.leading.equalTo(view2).offset(52)
        }
        
        postImage.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(postTextLabel.snp.bottom).offset(15)
            make.height.equalTo(125)
            make.leading.equalTo(postTextLabel)
            make.trailing.equalTo(view2).offset(-23)
        }
        
        horisontalLineImage.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(postImage.snp.bottom).offset(10)
            make.height.equalTo(0.5)
            make.width.equalTo(view2)
        }
        
        likesButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(horisontalLineImage).offset(10)
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.leading.equalTo(postImage)
        }
        
        likesLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(likesButton)
            make.height.equalTo(20)
            make.width.equalTo(18)
            make.leading.equalTo(likesButton.snp.trailing).offset(10)
        }
        
        commentButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(horisontalLineImage).offset(8)
            make.height.equalTo(24)
            make.width.equalTo(24)
            make.leading.equalTo(likesButton.snp.trailing).offset(58)
        }
        
        commentLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(likesLabel)
            make.height.equalTo(20)
            make.width.equalTo(18)
            make.leading.equalTo(commentButton.snp.trailing).offset(10)
        }
        
        bookmarkButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(likesLabel)
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.trailing.equalTo(view2).offset(-23)
        }
    }
}
