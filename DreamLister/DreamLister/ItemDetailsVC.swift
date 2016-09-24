//
//  ItemDetailsVC.swift
//  DreamLister
//
//  Created by Vishal Bharam on 9/23/16.
//  Copyright © 2016 Codecoop. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Outlets:
    @IBOutlet weak var itemTitle: CustomTextField!
    @IBOutlet weak var itemPrice: CustomTextField!
    @IBOutlet weak var itemDetails: CustomTextField!
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var thumbImage: UIImageView!
    
    var imagePicker: UIImagePickerController!
    
    var stores: [Store] = []
    
    // Edit
    var itemToEdit: Item?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title:
                "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        // StorePicker:
        storePicker.delegate = self
        storePicker.dataSource = self
        
        // ImagePicker:
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        // Dummy Data:
        // generateStoreData()
        getStoreData()
        loadItemData()
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let store = stores[row]
        return store.name
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    
    
    @IBAction func saveItem(_ sender: AnyObject) {
        
        var item: Item!
        let picture = Image(context: context)
        picture.image = thumbImage.image
        
        if (itemToEdit == nil) {
            item = Item(context: context)
        } else {
            item = itemToEdit
        }
        
        item.toImage = picture
        
        if let title = itemTitle.text {
            item.title = title
        }
        
        if let price = itemPrice.text {
            item.price = (price as NSString).doubleValue
        }
        
        if let details = itemDetails.text {
            item.details = details
        }
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    func loadItemData() {
        if (itemToEdit != nil) {
            if let item = itemToEdit {
                itemTitle.text = item.title
                itemPrice.text = "\(item.price)"
                itemDetails.text = item.details
                
                thumbImage.image = item.toImage?.image as? UIImage
                
                if let store = item.toStore {
                    var index = 0
                    
                    repeat {
                        let s = stores[index]
                        
                        if (s.name == store.name) {
                            storePicker.selectRow(index, inComponent: 0, animated: false)
                        }
                        
                        index += 1
                        
                    } while (index < stores.count)
                }
            }
        }
    }
    
    
    @IBAction func deleteItem(_ sender: AnyObject) {
        
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func addImage(_ sender: AnyObject) {
        present(imagePicker, animated: false, completion: nil)        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            thumbImage.image = img
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    func getStoreData() {
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            stores = try context.fetch(fetchRequest)
            storePicker.reloadAllComponents()
        } catch {
            // Handle all the errors:
        }
    }
    
    
    func generateStoreData() {
        let store1 = Store(context: context)
        store1.name = "Apple"
        
        let store2 = Store(context: context)
        store2.name = "Amazon"
        
        let store3 = Store(context: context)
        store3.name = "eBay"
        
        let store4 = Store(context: context)
        store4.name = "Target"
        
        let store5 = Store(context: context)
        store5.name = "Tesla Dealership"
        
        let store6 = Store(context: context)
        store6.name = "Best Buy"
        
        // Save the data:
        ad.saveContext()
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
