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
    private var favorites: Bool = false
    private var titleText = ""
    private var tapped = false
    private let table = UITableView(frame: .zero, style: .grouped)
    private var coreDataManager: CoreDataStack!
    private var tableFavoritesPredicate: NSPredicate?
    private let common = CommonFuncs()
    
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
    
    init(withCoreData: Bool = false, title: String, manager: CoreDataStack) {
        super.init(nibName: nil, bundle: nil)
        titleText = title
        favorites = withCoreData
        coreDataManager = manager
    }
    
    override func viewDidAppear(_ animated: Bool) {
        reloadTable()
    }
    
    func reloadTable() {
        print("Перезагружаем таблицу постов")
        Storage.favoritePosts = self.common.convertCoreDataPostsToStoragePost(posts: common.fetchData(predicate: (favorites ? tableFavoritesPredicate : nil)))
        table.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleText
        view.addSubview(table)
        
        self.navigationController?.navigationBar.isHidden = true
        
        tableSetup()
        setupLayout()
        gestureRecognizerSetup()
        
        if favorites {
            let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
            
            view.addSubview(navBar)

            let navItem = UINavigationItem()
            let doneItem = UIBarButtonItem(title: "Find", style: .plain, target: nil, action: #selector(showFilterAlert))
            let photoItem = UIBarButtonItem(title: "Clear filter", style: .plain, target: nil, action: #selector(clearFilterButtonClicked))

            navItem.rightBarButtonItem = doneItem
            navItem.leftBarButtonItem = photoItem

            navBar.setItems([navItem], animated: false)
        }
    }
    
    @objc func showFilterAlert() {
        let ac = UIAlertController(title: "Enter author name", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "OK", style: .default) { [self, unowned ac] _ in
            guard let field = ac.textFields else { return }
            let answer = field[0]
            guard let text = answer.text else { return }
            showAuthor(name: text)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    func showAuthor(name: String) {
        print("Показываем посты с определенным автором")
        tableFavoritesPredicate = NSPredicate(format: "author = %s", argumentArray: [name])
        reloadTable()
    }
    
    @objc func clearFilterButtonClicked() {
        print("Очищаем фильтр по автору")
        tableFavoritesPredicate = nil
        reloadTable()
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
        print("Пост \(post.author) добавлен в Избранное: favorites \(common.fetchData(predicate: (favorites ? tableFavoritesPredicate : nil)).count)")
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
            if favorites {
                let count = common.fetchData(predicate: favorites ? tableFavoritesPredicate : nil).count
                print("Количество постов в favorites: \(count)")
                return count
            } else {
                return Storage.posts.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! PostTableViewCell
        if favorites {
            let post = common.fetchData(predicate: (favorites ? tableFavoritesPredicate : nil))[indexPath.row]
            cell.configureViaCoreData(post: post)
        } else {
            let post = Storage.posts[indexPath.row]
            cell.configureViaStorage(post: post)
        }
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if favorites {
            return UISwipeActionsConfiguration(actions: [
                makeDeleteContextualAction(forRowAt: indexPath)
            ])
        } else { return nil }
    }

    //MARK: - Contextual Actions
    private func makeDeleteContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .destructive, title: "Delete") { (action, swipeButtonView, completion) in
            print("Свайпнули удалить")
            let post = self.common.fetchData(predicate: self.favorites ? self.tableFavoritesPredicate : nil)[indexPath.row]

            self.coreDataManager.delete(object: post)
            print("Пост \(post.author ?? "Неизвестный") добавлен в Избранное: favorites \(self.common.fetchData(predicate: self.favorites ? self.tableFavoritesPredicate : nil).count)")
            completion(true)
            self.reloadTable()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PostTableViewCell
        
        guard let name = cell.nameLabel.text, let title = cell.descriptionLabel.text, let image = cell.postImage.image, let likes = cell.likesLabel.text, let views = cell.viewsLabel.text else {
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