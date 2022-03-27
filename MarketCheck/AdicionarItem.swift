//
//  AdicionarItem.swift
//  MarketCheck
//
//  Created by Guilherme Lozano Borges on 17/03/22.
//

import Foundation
import UIKit


let list = ["a", "b", "c"]
var check: [Bool] = []

class TableViewController: UITableViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in list
        {
            check.append(false)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if !check[indexPath.row] // celula quando nao tem check
        {
            cell.textLabel?.text = list[indexPath.row]
            cell.imageView?.image = UIImage(systemName: "circlebadge")
        }
        
        else // celula quando tem check
        {
            cell.textLabel?.text = list[indexPath.row]
            cell.imageView?.image = UIImage(systemName: "checkmark.circle.fill")
        }
        //tableView.reloadData()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if check[indexPath.row] // se ta check, tira o check SELECIONANDO
        {
            check[indexPath.row] = false
        }
        
        else // se ta sem check, fica check SELECIONANDO
        {
            check[indexPath.row] = true
        }
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return list.count
    }
}
