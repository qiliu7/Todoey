import UIKit

var textField = UITextField()

let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
    
alert.addTextField { (alertTextField) in
    alertTextField.placeholder = "Create new item"
    textField = alertTextField
}
    
    
    
    
    
    
    
    
func name (alertTextField: UITextField) {
    
    alertTextField.placeholder = "Create new item"
    textField = alertTextField
}



