//
//  ProfilePhotoStackView.swift
//  VKNew
//
//  Created by v.milchakova on 05.11.2021.
//

import UIKit

@available(iOS 13.0, *)
class ProfilePhotoStackView: UIView {
    let baseOffset: CGFloat =  12
    
    private lazy var photoLabel: UILabel = {
        let photoLabel = UILabel()
        photoLabel.toAutoLayout()
        photoLabel.textColor = .black
        photoLabel.text = "Фотографии \(PhotoStorage().photos.count)"
        photoLabel.font = UIFont.boldSystemFont(ofSize: 15)
        return photoLabel
    }()
    
    private lazy var arrowButton: UIButton = {
        let arrowButton = UIButton()
        arrowButton.toAutoLayout()
        arrowButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        arrowButton.tintColor = .black
        arrowButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return arrowButton
    }()
    
    @objc func buttonPressed() {
        print("Нажали стрелку Ко всем фото")
        let root = findViewController()
        root!.navigationController?.pushViewController(PhotosViewController(), animated: false)
    }
    
    private lazy var photoStackView: UIStackView = {
        let stack = UIStackView()
        setupImagesToStackView(stack: stack)
        stack.spacing = 8
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.toAutoLayout()
        return stack
    }()
    
    func setupImagesToStackView(stack: UIStackView){
        (0...3).forEach { index in
            let image = UIImageView()
            image.image = PhotoStorage().photos[index]
            image.layer.masksToBounds = false
            image.layer.cornerRadius = 6
            image.clipsToBounds = true
            image.toAutoLayout()
            stack.addArrangedSubview(image)
        }
    }
    
    private lazy var footer: UIView = {
        let footer = UIView()
        footer.toAutoLayout()
        footer.backgroundColor = UIColor.systemGray5
        return footer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(photoLabel)
        addSubview(arrowButton)
        addSubview(photoStackView)
        addSubview(footer)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            photoLabel.topAnchor.constraint(equalTo: topAnchor, constant: baseOffset),
            photoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(baseOffset)),
            photoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: baseOffset),
            photoLabel.heightAnchor.constraint(equalToConstant: 20),
            
            arrowButton.centerYAnchor.constraint(equalTo: photoLabel.centerYAnchor),
            arrowButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(baseOffset)),
            arrowButton.heightAnchor.constraint(equalToConstant: 24),
            arrowButton.widthAnchor.constraint(equalToConstant: 15),
            
            photoStackView.topAnchor.constraint(equalTo: photoLabel.bottomAnchor, constant: baseOffset),
            photoStackView.widthAnchor.constraint(equalToConstant: self.frame.width),
            photoStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(baseOffset)),
            photoStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(baseOffset)),
            photoStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: baseOffset),
            
            footer.topAnchor.constraint(equalTo: photoStackView.bottomAnchor, constant: baseOffset),
            footer.trailingAnchor.constraint(equalTo: trailingAnchor),
            footer.leadingAnchor.constraint(equalTo: leadingAnchor),
            footer.heightAnchor.constraint(equalToConstant: 8),
        ])
    }
}

extension UIView {
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}

