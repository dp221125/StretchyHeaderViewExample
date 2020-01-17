//
//  StretchyHeaderViewController.swift
//  StretchyHeaderViewExample
//
//  Created by Seokho on 2020/01/17.
//  Copyright © 2020 Seokho. All rights reserved.
//

import UIKit

class StretchyHeaderViewController: UIViewController {
    
    private weak var tableView: UIScrollView?
    private weak var headerImageView: UIImageView?
    var image: UIImage?
    var minHeaderHeight: CGFloat = 0
    var maxHeaderHeight: CGFloat = 300
    private var headerAnchor: NSLayoutConstraint? {
        didSet {
            self.headerAnchor?.isActive = true
        }
        willSet {
            self.headerAnchor?.isActive = false
        }
    }

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemBackground
        self.view = view
         
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemBackground
        view.addSubview(tableView)
        self.tableView = tableView
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "HeaderImage")
        imageView.backgroundColor = self.tableView?.backgroundColor
        self.headerImageView = imageView
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        headerAnchor = imageView.heightAnchor.constraint(equalToConstant: maxHeaderHeight)
        
        tableView.contentInset.top = maxHeaderHeight
        tableView.contentOffset.y = -maxHeaderHeight
    }
    
    func updateView() {
        guard let scrollView = self.tableView, let imageView = self.headerImageView else { return }

        if  -minHeaderHeight < scrollView.contentOffset.y {
            self.headerAnchor = imageView.heightAnchor.constraint(equalToConstant: minHeaderHeight)
        } else {
            self.headerAnchor = imageView.heightAnchor.constraint(equalToConstant: -scrollView.contentOffset.y)
        }

        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
}
extension StretchyHeaderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(UITableViewCell.self)", for: indexPath)
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }
    
}
extension StretchyHeaderViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.updateView()
    }
}
