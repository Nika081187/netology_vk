//
//  ProfileSettingsView.swift
//  VKNew
//
//  Created by v.milchakova on 14.11.2021.
//

import UIKit

class ProfileSettingsView: UIViewController {

//    override init(frame: CGRect) {
//        view.addSubview(cont)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("coder")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cont)
    }
    
    private lazy var cont: UILabel = {
//        let view = UIView()

        var view = UILabel()
        
        view.toAutoLayout()

        view.frame = CGRect(x: 0, y: 0, width: 308, height: 808)

        view.backgroundColor = .white


        var shadows = UIView()

        shadows.frame = view.frame

        shadows.clipsToBounds = false

        view.addSubview(shadows)


        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 0)

        let layer0 = CALayer()

        layer0.shadowPath = shadowPath0.cgPath

        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor

        layer0.shadowOpacity = 1

        layer0.shadowRadius = 25

        layer0.shadowOffset = CGSize(width: -9, height: 4)

        layer0.bounds = shadows.bounds

        layer0.position = shadows.center

        shadows.layer.addSublayer(layer0)


        var shapes = UIView()

        shapes.frame = view.frame

        shapes.clipsToBounds = true

        view.addSubview(shapes)


        let layer1 = CALayer()

        layer1.backgroundColor = UIColor(red: 0.961, green: 0.953, blue: 0.933, alpha: 1).cgColor

        layer1.bounds = shapes.bounds

        layer1.position = shapes.center

        shapes.layer.addSublayer(layer1)
        
        return view
    }()
}
