//
//  ViewController.swift
//  MilestoneProject
//
//  Created by Machine on 27.01.2022.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Alışveriş Listesi"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addProduct))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(refresh))
        
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareList))
                let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                toolbarItems = [spacer, shareButton]
                navigationController?.isToolbarHidden = false
                
    }
    
    @objc func shareList(){
        let currentList = shoppingList.joined(separator: "\n")
        let vc = UIActivityViewController(activityItems: [currentList], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = toolbarItems?.last
        present(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        return shoppingList.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
         cell.textLabel?.text = shoppingList[indexPath.row]
        
         return cell

     }

    
    
    func startAgain() {
        title = shoppingList.randomElement()
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func addProduct() {
        let ac = UIAlertController(title: "Ne lazım?", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Kapat", style: .cancel))
        ac.addAction(UIAlertAction(title: "Ekle", style: .default) {
            [weak self, weak ac] _ in
            guard let text = ac?.textFields?[0].text else { return }
            self?.addProductToList(item: text)
        })
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }

    
    func addProductToList(item : String) {
        shoppingList.insert(item, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @objc func refresh() {
            startAgain()
        
    }
    
    
    
}

