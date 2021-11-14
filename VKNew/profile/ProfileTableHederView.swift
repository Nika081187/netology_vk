//
//  ProfileTableHederView.swift
//  VKNew
//
//  Created by v.milchakova on 05.11.2021.
//

import UIKit

protocol MyViewDelegate {
    func didTapButton()
}

class ProfileTableHederView: UIView {
    
    var delegate: MyViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(cont)
        
        cont.addSubview(infoLabel)
        cont.addSubview(editButton)
        cont.addSubview(nameLabel)
        cont.addSubview(avatarImage)
        cont.addSubview(jobLabel)
        cont.addSubview(infoImage)
        cont.addSubview(nicknameLabel)
        cont.addSubview(settingsButton)
        
        cont.addSubview(postsCountButton)
        cont.addSubview(subscribersCountButton)
        cont.addSubview(followersCountButton)
        
        cont.addSubview(photoButton)
        cont.addSubview(noteButton)
        cont.addSubview(historyButton)

        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("coder")
    }
        
    private lazy var cont: UIView = {
        let view = UIView()
        view.toAutoLayout()
        return view
    }()
    
    public lazy var avatarImage: UIImageView = {
        let avatarImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        avatarImage.toAutoLayout()
        avatarImage.image = #imageLiteral(resourceName: "avatar")
        avatarImage.contentMode = .scaleAspectFill
        avatarImage.tintColor = .white
        avatarImage.layer.borderWidth = 3
        avatarImage.layer.masksToBounds = false
        avatarImage.layer.cornerRadius = avatarImage.frame.height/2
        avatarImage.layer.borderColor = UIColor.white.cgColor
        avatarImage.clipsToBounds = true
        return avatarImage
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.toAutoLayout()
        nameLabel.text = "Анна Иванова"
        nameLabel.textColor = .black
        nameLabel.font = UIFont.boldSystemFont(ofSize: 22)
        return nameLabel
    }()
    
    private lazy var jobLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.toAutoLayout()
        nameLabel.text = "инженер"
        nameLabel.textColor = .lightGray
        nameLabel.font = UIFont.boldSystemFont(ofSize: 12)
        return nameLabel
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.text = "Подробная информация"
        return label
    }()
    
    private lazy var editButton: UIButton = {
        let statusButton = UIButton()
        statusButton.toAutoLayout()
        statusButton.layer.backgroundColor = UIColor(red: 1, green: 0.62, blue: 0.271, alpha: 1).cgColor
        statusButton.setTitle("Редактировать", for: .normal)
        statusButton.setTitleColor(.white, for: .normal)
        statusButton.layer.cornerRadius = 10
        statusButton.layer.masksToBounds = false
        statusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        statusButton.isEnabled = true
        return statusButton
    }()
    
    private lazy var infoImage: UIView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "exclamationmark.circle.fill")
        view.tintColor = UIColor(red: 1, green: 0.62, blue: 0.271, alpha: 1)
        view.toAutoLayout()
        return view
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.tintColor = UIColor(red: 1, green: 0.62, blue: 0.271, alpha: 1)
        var img = UIImage(systemName: "text.justify")
        button.addTarget(self, action: #selector(settingsButtonPressed), for:.touchUpInside)
        button.setImage(img, for: .normal)
        return button
    }()
    
    @objc func settingsButtonPressed() {
        print("Нажали кнопку Настройки профиля")
        delegate?.didTapButton()
    }
    
    private lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.text = "anna.designer.pro"
        return label
    }()
    
    private lazy var postsCountButton: UILabel = {
        let button = UILabel()
        button.toAutoLayout()
        button.textColor = UIColor(red: 1, green: 0.62, blue: 0.271, alpha: 1)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.0
        button.attributedText = NSMutableAttributedString(string: "1400 \n публикаций", attributes: [NSAttributedString.Key.kern: 0.14, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        button.numberOfLines = 2
        button.textAlignment = .center
        button.lineBreakMode = NSLineBreakMode.byWordWrapping
        return button
    }()
    
    private lazy var subscribersCountButton: UILabel = {
        let button = UILabel()
        button.toAutoLayout()
        button.textColor = .black
        button.numberOfLines = 2
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.0
        button.attributedText = NSMutableAttributedString(string: "477 \n подписок", attributes: [NSAttributedString.Key.kern: 0.14, NSAttributedString.Key.paragraphStyle: paragraphStyle])

        button.textAlignment = .center
        button.lineBreakMode = NSLineBreakMode.byWordWrapping
        return button
    }()
    
    private lazy var followersCountButton: UILabel = {
        let button = UILabel()
        button.numberOfLines = 2
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.0
        button.attributedText = NSMutableAttributedString(string: "161 тыс. \n подписчиков", attributes: [NSAttributedString.Key.kern: 0.14, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        button.textAlignment = .center
        
        button.toAutoLayout()
        button.textColor = .black
        button.lineBreakMode = NSLineBreakMode.byWordWrapping
        return button
    }()
    
    private lazy var noteButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setImage(#imageLiteral(resourceName: "noteButton"), for: .normal)
        return button
    }()
    
    private lazy var historyButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setImage(#imageLiteral(resourceName: "historyButton"), for: .normal)
        return button
    }()
    
    private lazy var photoButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setImage(#imageLiteral(resourceName: "photoButton"), for: .normal)
        return button
    }()
    
    @objc func buttonPressed() {
        print("Нажали статус")
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            
            cont.topAnchor.constraint(equalTo: topAnchor),
            cont.leadingAnchor.constraint(equalTo: leadingAnchor),
            cont.trailingAnchor.constraint(equalTo: trailingAnchor),
            cont.widthAnchor.constraint(equalTo: widthAnchor),
            cont.heightAnchor.constraint(equalToConstant: 240),
            
            nicknameLabel.topAnchor.constraint(equalTo: cont.topAnchor, constant: 54),
            nicknameLabel.leadingAnchor.constraint(equalTo: cont.leadingAnchor, constant: 26),
            nicknameLabel.widthAnchor.constraint(equalToConstant: 133),
            nicknameLabel.heightAnchor.constraint(equalToConstant: 24),
            
            settingsButton.widthAnchor.constraint(equalToConstant: 20),
            settingsButton.heightAnchor.constraint(equalToConstant: 20),
            settingsButton.centerYAnchor.constraint(equalTo: nicknameLabel.centerYAnchor),
            settingsButton.trailingAnchor.constraint(equalTo: cont.trailingAnchor, constant: -18),
            
            avatarImage.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: 14),
            avatarImage.leadingAnchor.constraint(equalTo: cont.leadingAnchor, constant: 16),
            avatarImage.widthAnchor.constraint(equalToConstant: 100),
            avatarImage.heightAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: 22),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 30),
            nameLabel.widthAnchor.constraint(equalToConstant: 200),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            jobLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
            jobLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            jobLabel.widthAnchor.constraint(equalToConstant: 57),
            jobLabel.heightAnchor.constraint(equalToConstant: 15),

            infoLabel.topAnchor.constraint(equalTo: jobLabel.bottomAnchor, constant: 5),
            infoLabel.widthAnchor.constraint(equalToConstant: 200),
            infoLabel.heightAnchor.constraint(equalToConstant: 18),
            
            infoImage.centerYAnchor.constraint(equalTo: infoLabel.centerYAnchor),
            infoImage.trailingAnchor.constraint(equalTo: infoLabel.leadingAnchor, constant: -8),
            infoImage.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            infoImage.widthAnchor.constraint(equalToConstant: 20),
            infoImage.heightAnchor.constraint(equalToConstant: 20),
            
            editButton.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 25),
            editButton.widthAnchor.constraint(equalToConstant: 344),
            editButton.heightAnchor.constraint(equalToConstant: 50),
            editButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            postsCountButton.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 15),
            postsCountButton.leadingAnchor.constraint(equalTo: cont.leadingAnchor, constant: 16),
            postsCountButton.widthAnchor.constraint(equalToConstant: 101),
            postsCountButton.heightAnchor.constraint(equalToConstant: 100),
            
            subscribersCountButton.centerYAnchor.constraint(equalTo: postsCountButton.centerYAnchor),
            subscribersCountButton.leadingAnchor.constraint(equalTo: postsCountButton.trailingAnchor, constant: 25),
            subscribersCountButton.widthAnchor.constraint(equalToConstant: 85),
            subscribersCountButton.heightAnchor.constraint(equalToConstant: 100),
            
            followersCountButton.centerYAnchor.constraint(equalTo: subscribersCountButton.centerYAnchor),
            followersCountButton.leadingAnchor.constraint(equalTo: subscribersCountButton.trailingAnchor, constant: 25),
            followersCountButton.widthAnchor.constraint(equalToConstant: 120),
            followersCountButton.heightAnchor.constraint(equalToConstant: 100),
            
            photoButton.topAnchor.constraint(equalTo: postsCountButton.bottomAnchor, constant: 8),
            photoButton.centerXAnchor.constraint(equalTo: postsCountButton.centerXAnchor),
            photoButton.widthAnchor.constraint(equalToConstant: 50),
            photoButton.heightAnchor.constraint(equalToConstant: 68),
            
            noteButton.topAnchor.constraint(equalTo: photoButton.topAnchor),
            noteButton.leadingAnchor.constraint(equalTo: photoButton.trailingAnchor, constant: 79),
            noteButton.widthAnchor.constraint(equalToConstant: 65),
            noteButton.heightAnchor.constraint(equalToConstant: 68),
            
            historyButton.topAnchor.constraint(equalTo: noteButton.topAnchor),
            historyButton.leadingAnchor.constraint(equalTo: noteButton.trailingAnchor, constant: 58),
            historyButton.widthAnchor.constraint(equalToConstant: 68),
            historyButton.heightAnchor.constraint(equalToConstant: 68),
        ])
    }
}


