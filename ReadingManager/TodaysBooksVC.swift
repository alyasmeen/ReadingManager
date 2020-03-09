//
//  TodaysBooksVC.swift
//  ReadingManager
//
//  Created by apple on 13/01/2020.
//  Copyright © 2020 Yasz. All rights reserved.
//

import UIKit
import CoreData

class TodaysBooksVC: UITableViewController {

    var todaysBooks:[Book]=[]
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todaysBooks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "TodaysBooksCell", for: indexPath) as! TodaysBooksCell
        configureCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();self.navigationItem.title="ffff"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadTodaysBooks()
        
        let formatter=DateFormatter()
        formatter.dateFormat="EEEE"
        title=formatter.string(from: Date())
        self.tabBarController?.tabBar.items![1].title="Today's Books"
    }
    
    func loadTodaysBooks(){
        let cal=Calendar(identifier: .gregorian)
        let today=cal.component(.weekday, from: Date())-1
        var allBooks:[Book]=[]
        todaysBooks=[]
        let fetchReq:NSFetchRequest<Book>=Book.fetchRequest()
        fetchReq.sortDescriptors=[NSSortDescriptor(key: "date", ascending: false)]
        do {
            try allBooks=context.fetch(fetchReq)
        } catch {
            print("fetching error")
        }
        
        for book in allBooks{
            if book.days![today]{
                todaysBooks.append(book)
            }
        }
        tableView.reloadData()
        
    }
    
    func configureCell(cell:TodaysBooksCell, indexPath:IndexPath){
        let book=todaysBooks[indexPath.row]
        cell.bookIm.image=book.image as? UIImage
        cell.currentLa.text=book.currentPage
        cell.titleLa.text=book.title
    }

}
