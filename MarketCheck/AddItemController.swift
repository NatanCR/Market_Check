//
//  AddItemController.swift
//  MarketCheck
//
//  Created by Henrique Batista de Assis on 21/03/22.
//

import UIKit

let listaCategorias: [String] =
[
    "Açougue",
    "Bebidas",
    "Cereais e Grãos",
    "Congelados e Frios",
    "Higiene Pessoal",
    "Hortifruti",
    "Laticínios",
    "Padaria",
    "Papelaria",
    "Pets",
    "Produtos de Limpeza",
    "Utilidades",
    "Outros"
]

struct ItemAdicionado
{
    var item:      String = ""
    var categoria: String = ""
}

let myTable = MyTableViewController()
let adi = AdicaoDeItem()

let userDefaults = UserDefaults()

class AddItemController: UIViewController
{
    var addedItem = ItemAdicionado()
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var textItem: UITextField!
    @IBOutlet weak var teste: UIBarButtonItem!
    
    
    @IBAction func teste(_ sender: Any) {
        if let itemDigitado = textItem.text
        {
            print("Item: " + addedItem.item)
            print("Categoria: " + addedItem.categoria)
            
            addedItem.item = itemDigitado
            
            if addedItem.item == "" || addedItem.categoria == ""
            {
                Alerta()
            }
            
            else // salva o item e categoria escolhidos
            {
                MandaEscolha()
            }
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.delegate   = self
        tableView.dataSource = self
        
        addedItem.item = ""
        addedItem.categoria = ""
    }
    
    func Alerta()
    {
        var mensagemAlerta: String
        
        if addedItem.item == "" && addedItem.categoria != ""
        {
            mensagemAlerta = "Nenhum item encontrado."
        }
        
        else if addedItem.categoria == "" && addedItem.item != ""
        {
            mensagemAlerta = "Nenhuma categoria selecionada."
        }
        
        else
        {
            mensagemAlerta = "Nenhum item encontrado e nenhuma categoria selecionada."
        }
        
        let alertWindow = UIAlertController(title: nil, message: mensagemAlerta, preferredStyle: .alert)
        alertWindow.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (_)in }))
        present(alertWindow, animated: true, completion: nil)
    }
    
    func MandaEscolha()
    {
//        adi.list.append(addedItem.item)
//        adi.cats.append(addedItem.categoria)
        
        
        adi.AdicionaItemECategoria(item: addedItem.item, categoria: addedItem.categoria)
        myTable.AdicionaItem(item: addedItem.item, categoria: addedItem.categoria)
        adi.SaveData()
        myTable.SaveData()
        
        navigationController?.popViewController(animated: true)
    }
    
} // fecha classe


extension AddItemController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        addedItem.categoria = listaCategorias[indexPath.row]
    }
}

extension AddItemController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 13 // 13 categorias
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = listaCategorias[indexPath.row]
        cell.imageView?.image = UIImage(named: listaCategorias[indexPath.row])
        
        return cell
    }
    
}
