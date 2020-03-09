//
//  AllBooksVC.swift
//  ReadingManager
//
//  Created by apple on 08/01/2020.
//  Copyright © 2020 Yasz. All rights reserved.
//

import UIKit
import CoreData

class AllBooksVC: UITableViewController,NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var addBu: UIBarButtonItem!
    @IBOutlet weak var deleteBu: UIBarButtonItem!
    @IBOutlet weak var selectBu: UIBarButtonItem!
    var controller:NSFetchedResultsController<Book>!
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let books=controller.fetchedObjects else {
            return 0
        }
        return books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "AllBooksCell", for: indexPath) as! AllBooksCell
        configureCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing{
            return
        }
        let book=controller.object(at: indexPath)
        performSegue(withIdentifier: "edit", sender: book)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="edit"{
            let destination=segue.destination as! AddBookVC
            destination.editBook=sender as? Book
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBooks()
        tabBarController?.tabBar.tintColor=UIColor.white
        tabBarController?.tabBar.barTintColor=UIColor.black
        tableView.allowsSelectionDuringEditing=true
        tableView.allowsMultipleSelectionDuringEditing=true
        deleteBu.isEnabled=false
        deleteBu.tintColor=UIColor.clear
    }
    
    @IBAction func selectMultipleRows(_ sender: UIBarButtonItem) {
        
        tableView.isEditing = !tableView.isEditing
        
        if tableView.isEditing{
            deleteBu.isEnabled=true
            deleteBu.tintColor=UIColor.black
            addBu.isEnabled=false
            selectBu.title="Cancel"
        }
        else{
            deleteBu.isEnabled=false
            deleteBu.tintColor=UIColor.clear
            addBu.isEnabled=true
            selectBu.title="Select"
        }
    }
    
    @IBAction func deleteSelectedRows(_ sender: UIBarButtonItem) {
        guard let selectedBooks=tableView.indexPathsForSelectedRows else {
            return
        }
        for bookIndex in selectedBooks{
            let book=controller.object(at: bookIndex)
            context.delete(book)
        }
        tableView.isEditing=false
        deleteBu.isEnabled=false
        deleteBu.tintColor=UIColor.clear
        addBu.isEnabled=true
        selectBu.title="Select"
        ad.saveContext()
    }
    
    func fetchBooks(){
        let fetchReq:NSFetchRequest<Book>=Book.fetchRequest()
        fetchReq.sortDescriptors=[NSSortDescriptor(key: "date", ascending: false)]
        controller=NSFetchedResultsController(fetchRequest: fetchReq, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate=self
        do{
            try controller.performFetch()
        }catch{
            self.title="fetching error"
        }

    }
    
    func configureCell(cell:AllBooksCell, indexPath:IndexPath){
        let book=controller.object(at: indexPath)
        cell.bookIm.image=book.image as? UIImage
        cell.currentLa.text=book.currentPage
        cell.pagesLa.text=book.pages
        cell.titleLa.text=book.title
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {

        switch(type) {

        case.insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case.update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! AllBooksCell
                configureCell(cell: cell, indexPath: indexPath )
            }
            break
        case.move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break

        }
    }


}
