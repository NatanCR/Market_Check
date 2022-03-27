//
//  AdicaoDeItem.swift
//  MarketCheck
//
//  Created by Henrique Batista de Assis on 18/03/22.
//

import Foundation
import UIKit

let defaults = UserDefaults()
let addItemController = AddItemController()

var list: [String] = []
var cats: [String] = []
var check: [Bool]  = []

class AdicaoDeItem: UITableViewController
{
    override func viewWillAppear(_ animated: Bool)
    {
        if let loadCheck = defaults.value(forKey: "loadCheck") as? [Bool]
        {
            check = loadCheck
        }
        
        if let loadList = defaults.value(forKey: "listSave") as? [String]
        {
            list = loadList
        }
        
        if let loadCats = defaults.value(forKey: "catsSave") as? [String]
        {
            cats = loadCats
        }
        
        self.tableView.reloadData()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    func AdicionaItemECategoria(item: String, categoria: String)
    {
        list.append(item)
        cats.append(categoria)
    }
    
    @IBAction func DeleteItens()
    {
        let alertDelete = UIAlertController(title: "Deletar Itens", message: "Tem certeza que deseja deletar todos os itens?", preferredStyle: .alert)
        alertDelete.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { [weak self] (_)in } ))
        alertDelete.addAction(UIAlertAction(title: "Deletar", style: .destructive, handler: { (action) in self.DeleteAll()} ))
        
        let noItemsAlert = UIAlertController(title: nil, message: "Não há itens para ser deletado.", preferredStyle: .alert)
        noItemsAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (_)in } ))
        
        if (list.count > 0)
        {
            present(alertDelete, animated: true, completion: nil)
        }
        
        else
        {
            present(noItemsAlert, animated: true, completion: nil)
        }
        
    }
    
    func DeleteAll()
    {
        check = []
        list =  []
        cats =  []
        
        SaveData()
        mtvc.RemoveAll()
        
        self.tableView.reloadData()
    }
    
    func SaveData()
    {
        defaults.setValue(list, forKey: "listSave")
        defaults.setValue(cats, forKey: "catsSave")
        
        for _ in list
        {
            check.append(false)
        }
        defaults.setValue(check, forKey: "loadCheck")
    }
    
    func ChangeCheckItem(categoria: String, item: String, checkInterno: Bool)
    {
        var jaCheckei = false
        
        for i in 0 ..< cats.count
        {
            if categoria == cats[i]
            {
                for j in 0 ..< list.count
                {
                    if item == list[j] && j == i && !jaCheckei && check[j] == checkInterno
                    {
                        print("chekei")
                        check[j] = !check[j]
                        jaCheckei = true
                        SaveData()
                    }
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        if !check[indexPath.row] // celula quando nao tem check
        {
            cell.textLabel?.text = list[indexPath.row]
            cell.imageView?.image = UIImage(systemName: "circlebadge")
            cell.textLabel?.textColor = .black
        }

        else // celula quando tem check
        {
            cell.textLabel?.text = list[indexPath.row]
            cell.imageView?.image = UIImage(systemName: "checkmark.circle.fill")
            cell.textLabel?.textColor = .systemGray2
        }
        //tableView.reloadData()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if check[indexPath.row] // se ta check, tira o check SELECIONANDO
        {
            check[indexPath.row] = false
            mtvc.ChangeCheck(item: list[indexPath.row], categoria: cats[indexPath.row], check: check[indexPath.row])
        }
        
        else // se ta sem check, fica check SELECIONANDO
        {
            check[indexPath.row] = true
            mtvc.ChangeCheck(item: list[indexPath.row], categoria: cats[indexPath.row], check: check[indexPath.row])
        }
        
        self.tableView.reloadData()
        defaults.setValue(check, forKey: "loadCheck")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            mtvc.RemoveItem(item: list[indexPath.row], categoria: cats[indexPath.row])
            
            list.remove(at: indexPath.row)
            cats.remove(at: indexPath.row)
            
            // REORGANIZANDO OS CHECKS
            let indiceCheck = indexPath.row
            
            for i in indiceCheck ..< check.count
            {
                if (i == check.count-1)
                {
                    check.removeLast()
                }
                
                else
                {
                    check[i] = check[i + 1]
                }
            }
            
            
            self.tableView.reloadData()
            SaveData()
        }
    }
    
}
