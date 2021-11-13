//
//  SavedPostViewController.swift
//  VKNew
//
//  Created by v.milchakova on 05.11.2021.
//

import UIKit

class SavedPostViewController: UIViewController {
    
    private let table = UITableView(frame: .zero, style: .grouped)
    private var tableFavoritesPredicate: NSPredicate?
    private let common = CommonFuncs(modelName: "PostModel")
    
    private var reuseId: String {
        String(describing: PostTableViewCell.self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        reloadTable()
    }

    func reloadTable() {
        print("Перезагружаем таблицу постов")
        Storage.favoritePosts = self.common.convertCoreDataPostsToStoragePost(posts: common.fetchData(for: Post.self, predicate: tableFavoritesPredicate))
        table.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(table)
        
        self.navigationController?.navigationBar.isHidden = true
        
        tableSetup()
        setupLayout()
        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        
        view.addSubview(navBar)

        let navItem = UINavigationItem()
        let doneItem = UIBarButtonItem(title: "Find", style: .plain, target: nil, action: #selector(showFilterAlert))
        let photoItem = UIBarButtonItem(title: "Clear filter", style: .plain, target: nil, action: #selector(clearFilterButtonClicked))

        navItem.rightBarButtonItem = doneItem
        navItem.leftBarButtonItem = photoItem

        navBar.setItems([navItem], animated: false)
    }
    
    @objc func clearFilterButtonClicked() {
        print("Очищаем фильтр по автору")
        tableFavoritesPredicate = nil
        reloadTable()
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
    
    func tableSetup() {
        table.toAutoLayout()
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 250
        table.register(PostTableViewCell.self, forCellReuseIdentifier: reuseId)
        table.dataSource = self
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
}

@available(iOS 13.0, *)
extension SavedPostViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section == 0 else {
//            let count = common.fetchData(for: Post.self, predicate: tableFavoritesPredicate).count
//            print("Количество постов в favorites: \(count)")
//            return count
            return Storage.posts.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! PostTableViewCell
//        let post = common.fetchData(for: Post.self, predicate: tableFavoritesPredicate)[indexPath.row]
//        cell.configureViaCoreData(post: post )
        let post = Storage.posts[indexPath.row]
        cell.configureViaStorage(post: post)
        return cell
    }
}
