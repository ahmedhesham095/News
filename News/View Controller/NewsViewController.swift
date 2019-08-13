//
//  NewsViewController.swift
//  News
//
//  Created by Ahmed Hesham on 7/26/19.
//  Copyright © 2019 Ahmed Hesham. All rights reserved.
//

import UIKit
import SwiftPullToRefresh
class NewsViewController: UIViewController {
    
    lazy var utils :  ViewControllerUtils = {
        return ViewControllerUtils()
    }()
    lazy var presenter :  NewsPresenter = {
        return NewsPresenter(withDelegate: self)
    }()
    let networkManager = NetworkManager.sharedInstance
    var articlesArray = [Article]()
    var cachedArticlesArray = [ArticleList]()
    var pageOffset = 1
    var countryCode : String?
    var isLoadMore = false
    
    @IBOutlet weak var newsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTable.delegate = self
        newsTable.dataSource = self
        newsTable.rowHeight = UITableView.automaticDimension
        newsTable.register(UINib(nibName: "NewsViewCell", bundle: nil), forCellReuseIdentifier: Constants.CELL_IDENTIFIER)
        setupPullToRefresh()
        setupLoadMore()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector:
            #selector(networkBecomesConnected), name: NSNotification.Name.networkReconnected, object: nil)
        self.showAlertForCountryCode()
    }
    /**
     show Pull to Refresh
     */
    func setupPullToRefresh()  {
        newsTable.spr_setIndicatorHeader {
            self.presenter.loadNews(countryCode: self.countryCode ?? "", pageOffset: self.pageOffset )
            self.newsTable.spr_endRefreshing()
        }
    }
    /**
     show LoadMore
     */
    func setupLoadMore()  {
        newsTable.spr_setIndicatorFooter {
            self.isLoadMore = true
            self.presenter.loadNews(countryCode: self.countryCode ?? "", pageOffset: (self.pageOffset ) + 1)
        }
    }
    /**
     alert dialogue to get the country code from user
     */
    func showAlertForCountryCode() {
        let alert = UIAlertController(title: "Country Code", message: "Please Enter the Country Code to get the news ", preferredStyle: .alert)
        alert.addTextField(configurationHandler: { (textField) -> Void in
        })
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (action) -> Void in
            let textField = alert?.textFields![0]  
            self.countryCode = textField?.text
            self.presenter.loadNews(countryCode: self.countryCode ?? "" , pageOffset: self.pageOffset)
        }))
        self.present(alert, animated: true , completion: nil)
    }
    /**
     Handle Ioading data when the internet becomes active
     */
    @objc func networkBecomesConnected() {
        self.presenter.loadNews(countryCode: self.countryCode ?? "" , pageOffset: self.pageOffset)
    }
}

extension NewsViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if articlesArray.isEmpty == false {
            return articlesArray.count
        } else {
            return cachedArticlesArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTable.dequeueReusableCell(withIdentifier: Constants.CELL_IDENTIFIER , for: indexPath) as! NewsViewCell
        if articlesArray.isEmpty == false {
            cell.configure(with:  articlesArray[indexPath.row])
        } else {
            cell.configure(with: nil , or: cachedArticlesArray[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController()
        detailsVC.providesPresentationContextTransitionStyle = true
        detailsVC.definesPresentationContext = true
        detailsVC.modalPresentationStyle = .overCurrentContext
        detailsVC.popoverPresentationController?.sourceView = self.view
        self.present(detailsVC , animated: true)
        if articlesArray.isEmpty == false {
            detailsVC.setDescriptonText(with: articlesArray[indexPath.row].descriptionField ?? "")
        } else {
            detailsVC.setDescriptonText(with: cachedArticlesArray[indexPath.row].descriptionField)
        }
        
    }
}

extension NewsViewController : NewsProtocol {
    
    func configureofflineUI(with cachedArticles: [ArticleList]) {
        self.cachedArticlesArray = cachedArticles
        self.newsTable.reloadData()
    }
    
    func configureUI(with articles: [Article], and message: String?) {
        if isLoadMore == true {
            self.articlesArray.append(contentsOf: articles)
            self.isLoadMore = false
        } else {
            self.articlesArray = articles
        }
        self.newsTable.reloadData()
    }
    
    func showLoader() {
        self.utils.showActivityIndicator(uiView: self.view)
    }
    
    func hideLoader() {
        self.utils.hideActivityIndicator(uiView: self.view)
    }
}
