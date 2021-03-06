//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Kappa on 2019/3/28.
//  Copyright © 2019 Qi Liu. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    // the initialization might throw only the first time declared in a thread when resource is constrained
    let realm = try! Realm()

    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }

    // MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added"
        return cell
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
        
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
        
    }
    
    // MARK: - Data Manipulation Methods
    func save(category: Category){
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories() {

        categories = realm.objects(Category.self)

        tableView.reloadData()

    }
    
    // MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        // store a reference to the field created inside the action closure
        var textField = UITextField()
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            if textField.text! == "" {
                
                return
                
            } else {
                
                let newCategory = Category()
                newCategory.name = textField.text!
                
                self.save(category: newCategory)
            }
        }
        
        alert.addTextField { (field) in
            
            textField = field
            field.placeholder = "Create a new category"
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}
