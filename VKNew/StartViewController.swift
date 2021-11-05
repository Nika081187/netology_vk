//
//  StartViewController.swift
//  com.work.with.filemanager
//
//  Created by v.milchakova on 03.11.2021.
//

import UIKit
import SnapKit

class StartViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Строка \(#line) в функции \(#function) в файле \(#file)")
        view.backgroundColor = .white
        
        view.addSubview(logoImage)
        view.addSubview(regButton)
        view.addSubview(loginLabel)
        
        setConstraints()
    }
    
    func setConstraints() {
        logoImage.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(113)
            make.height.equalTo(344)
            make.leading.equalTo(view).offset(15)
            make.trailing.equalTo(view).offset(-16)
        }
        
        regButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(logoImage.snp.bottom).offset(81)
            make.height.equalTo(47)
            make.leading.equalTo(view).offset(57)
            make.trailing.equalTo(view).offset(-58)
        }

        loginLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(regButton.snp.bottom).offset(40)
            make.height.equalTo(20)
            make.leading.equalTo(view).offset(148)
            make.trailing.equalTo(view).offset(-129)
        }
    }
    
    private lazy var logoImage: UIView = {
        let view = UIImageView()
        let image = UIImage(named: "logo")
        view.image = image;
        view.toAutoLayout()
        return view
    }()
    
    private lazy var regButton: UIButton = {
        let view = UIButton()
        view.setTitle("ЗАРЕГИСТРИРОВАТЬСЯ", for: .normal)
        view.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        view.titleLabel!.font = UIFont(name: "Inter-Medium", size: 16)
        view.addTarget(self, action: #selector(registrationButtonPressed), for:.touchUpInside)
        view.layer.backgroundColor = UIColor(red: 0.149, green: 0.196, blue: 0.22, alpha: 1).cgColor
        view.layer.cornerRadius = 10
        view.toAutoLayout()
        return view
    }()
    
    private lazy var loginLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.122, green: 0.118, blue: 0.118, alpha: 1)
        view.font = UIFont(name: "Inter-Regular", size: 14)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.18

        view.attributedText = NSMutableAttributedString(string: "Уже есть аккаунт ", attributes: [NSAttributedString.Key.kern: -0.17, NSAttributedString.Key.paragraphStyle: paragraphStyle])

        let tap = UITapGestureRecognizer(target: self, action: #selector(loginButtonPressed))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
        view.toAutoLayout()
        return view
    }()
    
    @objc func registrationButtonPressed() {
        print("Нажали кнопку регистрации")
    }
    
    @objc func loginButtonPressed() {
        print("Нажали кнопку login")
    }
}

