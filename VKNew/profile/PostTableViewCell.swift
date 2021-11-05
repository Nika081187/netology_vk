//
//  PostTableViewCell.swift
//  VKNew
//
//  Created by v.milchakova on 05.11.2021.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    let baseOffset: CGFloat =  16
    
    public func configureViaStorage(post: StoragePost){
        nameLabel.text = post.author
        postImage.image = post.image
        descriptionLabel.text = post.title
        likesLabel.text = "Likes: \(post.likes)"
        viewsLabel.text = "Views: \(post.views)"
    }
    
    public func configureViaCoreData(post: Post){
        nameLabel.text = post.author
        descriptionLabel.text = post.title
        likesLabel.text = "Likes: \(post.likes)"
        viewsLabel.text = "Views: \(post.views)"
        guard let image = post.image else {
            return
        }
        postImage.image = UIImage(data: image)
    }

    public lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.toAutoLayout()
        nameLabel.textColor = .black
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        nameLabel.numberOfLines = 2
        return nameLabel
    }()
    
    public lazy var postImage: UIImageView = {
        let postImage = UIImageView()
        postImage.toAutoLayout()
        postImage.contentMode = .scaleAspectFit
        postImage.backgroundColor = .black
        return postImage
    }()
    
    public lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.toAutoLayout()
        descriptionLabel.textColor = .gray
        descriptionLabel.font = descriptionLabel.font.withSize(14)
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    
    public lazy var likesLabel: UILabel = {
        let likesLabel = UILabel()
        likesLabel.toAutoLayout()
        likesLabel.textColor = .black
        likesLabel.font = descriptionLabel.font.withSize(16)
        return likesLabel
    }()
    
    public lazy var viewsLabel: UILabel = {
        let viewsLabel = UILabel()
        viewsLabel.toAutoLayout()
        viewsLabel.textColor = .black
        viewsLabel.font = descriptionLabel.font.withSize(16)
        return viewsLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(postImage)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(viewsLabel)
        contentView.addSubview(likesLabel)
        
        let constraint =  [
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: baseOffset),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: baseOffset),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -(baseOffset)),

            postImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            postImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            postImage.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            descriptionLabel.leadingAnchor.constraint(equalTo: postImage.leadingAnchor, constant: baseOffset),
            descriptionLabel.trailingAnchor.constraint(equalTo: postImage.trailingAnchor, constant: -(baseOffset)),
            descriptionLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: baseOffset),
            
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            likesLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -(baseOffset)),
            
            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            viewsLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -(baseOffset)),

        ]
        
        NSLayoutConstraint.activate(constraint)
    }
}
