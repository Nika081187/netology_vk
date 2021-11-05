//
//  AcceptRegistrationViewController.swift
//  VKNew
//
//  Created by v.milchakova on 05.11.2021.
//

import UIKit

class AcceptRegistrationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Строка \(#line) в функции \(#function) в файле \(#file)")
        view.backgroundColor = .white
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        view.addSubview(scrollView)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false

        scrollView.contentSize = view.frame.size
        
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(codeLabel)
        scrollView.addSubview(codeTextField)
        scrollView.addSubview(regButton)
        scrollView.addSubview(checkImage)

        setConstraints()
    }

    func setConstraints() {
        scrollView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }

        titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(scrollView).offset(148)
            make.width.equalTo(274)
            make.centerX.equalTo(view)
            make.height.equalTo(22)
        }
        
        descriptionLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.height.equalTo(40)
            make.width.equalTo(265)
            make.centerX.equalTo(view)
        }
        
        codeLabel.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(codeTextField.snp.top).offset(-5)
            make.height.equalTo(15)
            make.width.equalTo(150)
            make.leading.equalTo(codeTextField)
        }

        codeTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(138)
            make.height.equalTo(60)
            make.leading.equalTo(view).offset(57)
            make.trailing.equalTo(view).offset(-58)
        }

        regButton.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(view).offset(93)
            make.trailing.equalTo(view).offset(-94)
            make.top.equalTo(codeTextField.snp.bottom).offset(86)
            make.height.equalTo(47)
        }
        
        checkImage.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.top.equalTo(regButton.snp.bottom).offset(43)
            make.height.equalTo(100)
            make.width.equalTo(86)
        }
    }
    
    @objc private func keyboardWillShow(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height / 2
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height / 2
            }
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification){
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets = .zero
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height / 2
            }
        }
    }

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.toAutoLayout()
        return scrollView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor(red: 0.965, green: 0.592, blue: 0.027, alpha: 1)
        label.font = UIFont(name: "Inter-SemiBold", size: 18)
        label.attributedText = NSMutableAttributedString(string: "Подтверждение регистрации", attributes: [NSAttributedString.Key.kern: 0.18])
        return label
    }()
    
    private lazy var codeLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = UIColor(red: 0.495, green: 0.507, blue: 0.512, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        label.attributedText = NSMutableAttributedString(string: "Введите код из SMS", attributes: [NSAttributedString.Key.kern: 0.18])
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping

        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.18
        paragraphStyle.alignment = NSTextAlignment.center

        let normalText = "Мы отправили SMS с кодом на номер \n"
        let attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                     NSAttributedString.Key.kern: 0.14,
                     NSAttributedString.Key.paragraphStyle: paragraphStyle] as [NSAttributedString.Key : Any]
        let attributedString = NSMutableAttributedString(string: normalText, attributes: attrs)

        let boldText = "+38 099 999 99 99"
        let normalString = NSMutableAttributedString(string: boldText, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])

        attributedString.append(normalString)
        label.attributedText = attributedString
        
        return label
    }()
    
    private lazy var codeTextField: UITextField = {
        let field = UITextField()

        field.textColor = .darkGray
        field.textAlignment = .center
        field.font = UIFont.systemFont(ofSize: 20)
        field.placeholder = "_ _ _ - _ _ _"

        field.layer.cornerRadius = 10
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor(red: 0.149, green: 0.196, blue: 0.22, alpha: 1).cgColor

        field.leftViewMode = .always
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        field.leftView = paddingView

        field.toAutoLayout()
        return field
    }()
    
    private lazy var regButton: UIButton = {
        let button = UIButton()

        button.setTitle("ЗАРЕГИСТРИРОВАТЬСЯ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel!.font = UIFont(name: "Inter-Medium", size: 16)
        
        button.addTarget(self, action: #selector(loginButtonPressed), for:.touchUpInside)
        button.layer.backgroundColor = UIColor(red: 0.149, green: 0.196, blue: 0.22, alpha: 1).cgColor
        button.layer.cornerRadius = 10

        button.toAutoLayout()
        return button
    }()
    
    private lazy var checkImage: UIView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "checkImage")
        view.toAutoLayout()
        return view
    }()
    
    @objc func loginButtonPressed() {
        print("Нажали кнопку регистрации")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 16
   }
}
