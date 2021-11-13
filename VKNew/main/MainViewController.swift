//
//  MainViewController.swift
//  VKNew
//
//  Created by v.milchakova on 05.11.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    private let screenRect = UIScreen.main.bounds
    private lazy var screenWidth = screenRect.size.width
    private lazy var screenHeight = screenRect.size.height
    private var selectedPost: StoragePost!
    private var addedPostTitles = [String]()
    private var tapped = false
    private let table = UITableView(frame: .zero, style: .grouped)

    private let common = CommonFuncs(modelName: "PostModel")
    
    private var reuseId: String {
        String(describing: PostTableViewCell.self)
    }

    private lazy var photos = ProfilePhotoStackView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print(type(of: self), #function)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(table)
        
        self.navigationController?.navigationBar.isHidden = true
        
        tableSetup()
        setupLayout()
        gestureRecognizerSetup()
    }
    
    func tableSetup() {
        table.toAutoLayout()
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 250
        table.register(PostTableViewCell.self, forCellReuseIdentifier: reuseId)
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .white
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.topAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func gestureRecognizerSetup() {
        
        let tapTableGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapTable))
        tapTableGestureRecognizer.numberOfTapsRequired = 2
        table.addGestureRecognizer(tapTableGestureRecognizer)
        table.isUserInteractionEnabled = true
    }
    
    @objc func tapTable() {
        print("Тапнули ячейку")
        
        guard let post = selectedPost else {
            print("Нет сохраненного поста")
            return
        }

        guard let pst = coreDataManager.create(from: Post.self, title: post.title) else {
            return
        }

        pst.author = post.author
        pst.title = post.title
        pst.image = post.image.pngData()
        pst.views = post.views
        pst.likes = post.likes
        
        coreDataManager.save()
        print("Пост \(post.author) добавлен в Избранное: favorites \(common.fetchData(for: Post.self, predicate: nil).count)")
        table.reloadData()
    }
}


@available(iOS 13.0, *)
extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section == 0 else {
            return Storage.posts.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! PostTableViewCell
        let post = Storage.posts[indexPath.row]
        cell.configureViaStorage(post: post)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 { return 140 }
        return .zero
    }
}

@available(iOS 13.0, *)
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return photos
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PostTableViewCell
        
        guard let name = cell.userNameLabel.text, let title = cell.postTextLabel.text, let image = cell.postImage.image, let likes = cell.likesLabel.text, let views = cell.commentLabel.text else {
            return
        }
        
        let post = StoragePost(author: name, title: title, image: image, likes: getInt(text: likes), views: getInt(text: views))
        selectedPost = post
    }
    
    private func getInt(text: String) -> Int64 {
        guard let number = Int64(text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) else {
            fatalError()
        }
        return number
    }
}
