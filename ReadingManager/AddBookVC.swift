//
//  AddBookVC.swift
//  ReadingManager
//
//  Created by apple on 09/01/2020.
//  Copyright © 2020 Yasz. All rights reserved.
//

import UIKit

class AddBookVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var dateLa: UILabel!
    @IBOutlet weak var currentTxt: UITextField!
    @IBOutlet weak var pagesTxt: UITextField!
    @IBOutlet weak var notesTxt: UITextView!
    @IBOutlet weak var bookIm: UIImageView!
    @IBOutlet var buttonsArray:[CheckBox]!
    var imagePicker:UIImagePickerController!
    var editBook:Book?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker=UIImagePickerController()
        imagePicker.delegate=self
        
        if editBook != nil{
            loadBook()
        }
        notesTxt.clipsToBounds=true;
        notesTxt.layer.cornerRadius=10
        
    }
    
    @IBAction func save(_ sender: Any) {
        let book:Book!
        
        if editBook != nil{
            book=editBook
        }else{
            book=Book(context: context)
        }
        
        book.currentPage=currentTxt.text
        book.title=titleTxt.text
        book.notes=notesTxt.text
        book.pages=pagesTxt.text
        book.image=bookIm.image
        if editBook==nil{
            book.date=Date()
        }
        book.days=[]
        for i in 0...6{
            book.days?.append(buttonsArray[i].isChecked)
        }
        
        ad.saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    func loadBook(){
        titleTxt.text=editBook?.title
        currentTxt.text=editBook?.currentPage
        pagesTxt.text=editBook?.pages
        notesTxt.text=editBook?.notes
        bookIm.image=editBook?.image as? UIImage
        
        let formatter=DateFormatter()
        formatter.dateFormat="MMM d,yyyy"
        let nb=editBook?.date
        dateLa.text=formatter.string(from: nb!)

        for i in 0...6{
            buttonsArray[i].isChecked=(editBook?.days?[i])!
        }
    }
    
    @IBAction func pickImage(_ sender: Any) {
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image=info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            imagePicker.dismiss(animated: true, completion: nil); return
        }
        bookIm.image=image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
 

}



class CheckBox: UIButton {
    
    
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(getCheckedImage(), for: UIControl.State.normal)
            } else {
                self.setImage(getUncheckedImage(), for: UIControl.State.normal)
            }
        }
    }

    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }

    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
    
    func getCheckedImage()->UIImage{
        switch (tag) {
            case 0:
                return UIImage(named: "sunChecked")!
            case 1:
                return UIImage(named: "monChecked")!
            case 2:
                return UIImage(named: "tueChecked")!
            case 3:
                return UIImage(named: "wedChecked")!
            case 4:
                return UIImage(named: "thuChecked")!
            case 5:
                return UIImage(named: "friChecked")!
            case 6:
                return UIImage(named: "satChecked")!
            default:
                return UIImage(named: "sunChecked")!
        }
    }
    
    func getUncheckedImage()->UIImage{
        switch (tag) {
            case 0:
                return UIImage(named: "sunUnchecked")!
            case 1:
                return UIImage(named: "monUnchecked")!
            case 2:
                return UIImage(named: "tueUnchecked")!
            case 3:
                return UIImage(named: "wedUnchecked")!
            case 4:
                return UIImage(named: "thuUnchecked")!
            case 5:
                return UIImage(named: "friUnchecked")!
            case 6:
                return UIImage(named: "satUnchecked")!
            default:
                return UIImage(named: "sunUnchecked")!
        }
    }
    
}
