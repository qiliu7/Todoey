//
//  ViewController.swift
//  Todoey
//
//  Created by Kappa on 2019/3/22.
//  Copyright © 2019 Qi Liu. All rights reserved.
//

import UIKit
import RealmSwift


class TodoListViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    
    let realm = try! Realm()
    
    var todoItems: Results<Item>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
    }
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    // * gets called when the TableView gets loaded up. & Can be recalled using tabelView.reloadData()
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }

        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Error updating done status \(error)")
            }
        }

        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)

        // declared to store the field generated in closure inside alert.addTextField(), and enlarge its scope
        var textField = UITextField()

        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in

            if textField.text == "" {

                return
                
            } else {

                if let currentCategory = self.selectedCategory {
                    do {
                        try self.realm.write {
                            
                            let newItem = Item()
                            newItem.title = textField.text!
                            print(newItem.dateCreated)
                    
                            currentCategory.items.append(newItem)
                        }
                    } catch {
                        print("Error saving item \(error)")
                    }
                }
                
                self.tableView.reloadData()
            }
        }

        alert.addTextField { (alertTextField) in

            alertTextField.placeholder = "Create a new item"
            textField = alertTextField
        }
        alert.addAction(action)

        present(alert, animated: true, completion: nil)
    }
    
    func loadItems() {

        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
    }

}

//MARK: - Search bar Methods
extension TodoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchBar.text!.count == 0 {
            
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }



    }
}



