//
//  ProfileTableHederView.swift
//  VKNew
//
//  Created by v.milchakova on 05.11.2021.
//

import UIKit

@available(iOS 13.0, *)
class ProfileTableHederView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(cont)
        
        cont.addSubview(infoLabel)
        cont.addSubview(statusButton)
        cont.addSubview(nameLabel)
        cont.addSubview(avatarImage)
        cont.addSubview(jobLabel)
        cont.addSubview(infoImage)
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
    
    private lazy var statusButton: UIButton = {
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
    
    @objc func buttonPressed() {
        print("Нажали статус")
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            
            cont.topAnchor.constraint(equalTo: topAnchor),
            cont.leadingAnchor.constraint(equalTo: leadingAnchor),
            cont.trailingAnchor.constraint(equalTo: trailingAnchor),
            cont.widthAnchor.constraint(equalTo: widthAnchor),
            cont.heightAnchor.constraint(equalToConstant: 220),
            
            avatarImage.topAnchor.constraint(equalTo: cont.topAnchor, constant: 16),
            avatarImage.leadingAnchor.constraint(equalTo: cont.leadingAnchor, constant: 16),
            avatarImage.widthAnchor.constraint(equalToConstant: 100),
            avatarImage.heightAnchor.constraint(equalToConstant: 100),

            statusButton.bottomAnchor.constraint(equalTo: cont.bottomAnchor, constant: -30),
            statusButton.widthAnchor.constraint(equalToConstant: 344),
            statusButton.heightAnchor.constraint(equalToConstant: 50),
            statusButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: cont.topAnchor, constant: 27),
            nameLabel.centerXAnchor.constraint(equalTo: statusButton.centerXAnchor, constant: 30),
            nameLabel.widthAnchor.constraint(equalToConstant: 200),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            jobLabel.bottomAnchor.constraint(equalTo: infoLabel.topAnchor, constant: -5),
            jobLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            jobLabel.widthAnchor.constraint(equalToConstant: 57),
            jobLabel.heightAnchor.constraint(equalToConstant: 15),

            infoLabel.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: -34),
            infoLabel.widthAnchor.constraint(equalToConstant: 200),
            infoLabel.heightAnchor.constraint(equalToConstant: 18),
            
            infoImage.centerYAnchor.constraint(equalTo: infoLabel.centerYAnchor),
            infoImage.trailingAnchor.constraint(equalTo: infoLabel.leadingAnchor, constant: -8),
            infoImage.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            infoImage.widthAnchor.constraint(equalToConstant: 20),
            infoImage.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}


