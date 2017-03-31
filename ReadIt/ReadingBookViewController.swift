//
//  ViewController.swift
//  ReadIt
//
//  Created by 何清宝 on 17/3/26.
//  Copyright © 2017年 heqingbao. All rights reserved.
//

import UIKit

import Alamofire
import AlamofireImage
import SwiftyJSON

class ReadingBookViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    var books = [Book]()
    
    var bookCellWidth: CGFloat = 0
    var bookCellHeight: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "在读"
        self.view.backgroundColor = Constants.bgColor
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(onAddButtonClicked))
        
        bookCellWidth = (self.view.bounds.width - 12 - 12 - 12 - 12) / 3
        bookCellHeight = bookCellWidth / 0.669
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: collectionViewLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        collectionView.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        collectionView.alwaysBounceVertical = true
        
        collectionView.register(BookViewCell.self, forCellWithReuseIdentifier: cellId)
        
        self.view.addSubview(collectionView)
        
        // test data
        let book1 = Book(isbn: "9787544253994", title: "百年孤独", pages: 400)
        book1.image = "https://img3.doubanio.com/mpic/s6384944.jpg"
        
        let book2 = Book(isbn: "9787208061644", title: "追风筝的人", pages: 400)
        book2.image = "https://img3.doubanio.com/mpic/s1727290.jpg"
        
        let book3 = Book(isbn: "9787508672069", title: "未来简史", pages: 400)
        book3.image = "https://img3.doubanio.com/mpic/s29287103.jpg"
        
        let book4 = Book(isbn: "9787544270878", title: "解忧杂货店", pages: 400)
        book4.image = "https://img3.doubanio.com/mpic/s27264181.jpg"
        
        let book5 = Book(isbn: "9787514357042", title: "风雪追击", pages: 400)
        book5.image = "https://img1.doubanio.com/mpic/s29362779.jpg"
        
        let book6 = Book(isbn: "9787539971810", title: "岛上书店", pages: 400)
        book6.image = "https://img3.doubanio.com/mpic/s28049685.jpg"
        
        let book7 = Book(isbn: "9787550013247", title: "摆渡人", pages: 400)
        book7.image = "https://img3.doubanio.com/mpic/s28063701.jpg"
        
        books.append(book1)
        books.append(book2)
        books.append(book3)
        books.append(book4)
        books.append(book5)
        books.append(book6)
        books.append(book7)
        
        for _ in 1...9 {
            let book = Book(isbn: "9787550013247", title: "摆渡人", pages: 400)
            book.image = "https://img3.doubanio.com/mpic/s28063701.jpg"
            books.append(book)
        }
        
//        for book in books {
//            let url = "https://api.douban.com/v2/book/isbn/:" + book.isbn
//            Alamofire.request(url).responseJSON(completionHandler: { (response) in
//                switch response.result {
//                case .success(let value):
//                    let json = JSON(value)
//                    book.image = json["image"].string
//                    collectionView.reloadData()
//                case .failure(let error):
//                    print(error)
//                }
//            })
//        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BookViewCell
        cell.book = books[indexPath.item]
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bookCellWidth, height: bookCellHeight)
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.book = books[indexPath.item]
        detailViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    // MARK: - Custom acitons
    
    func onAddButtonClicked() {
        let addBookViewController = AddBookViewController()
        let navController = UINavigationController(rootViewController: addBookViewController)
        present(navController, animated: true, completion: nil)
    }
}