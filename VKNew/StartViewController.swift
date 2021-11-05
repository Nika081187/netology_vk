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
            make.width.equalTo(344)
            make.centerX.equalTo(view)
        }
        
        regButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(logoImage.snp.bottom).offset(81)
            make.height.equalTo(47)
            make.width.equalTo(260)
            make.centerX.equalTo(view)
        }

        loginLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(regButton.snp.bottom).offset(40)
            make.height.equalTo(20)
            make.width.equalTo(150)
            make.centerX.equalTo(view)
        }
    }
    
    private lazy var logoImage: UIView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "startImage")
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
        view.textAlignment = .center

        view.attributedText = NSMutableAttributedString(string: "Уже есть аккаунт", attributes: [NSAttributedString.Key.kern: -0.17, NSAttributedString.Key.paragraphStyle: paragraphStyle])

        let tap = UITapGestureRecognizer(target: self, action: #selector(loginButtonPressed))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
        view.toAutoLayout()
        return view
    }()
    
    @objc func registrationButtonPressed() {
        print("Нажали кнопку регистрации")
        let vc = RegistrationViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }
    
    @objc func loginButtonPressed() {
        print("Нажали кнопку login")
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }
}

