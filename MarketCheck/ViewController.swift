//
//  ViewController.swift
//  MarketCheck
//
//  Created by Henrique Batista de Assis on 10/03/22.
//

import UIKit

//let categorias = Categorias()

var categorias = Categorias()
var btaoCategoria = BotaoCategoria()
let tableView = UITableView()
let indexPath = IndexPath()

var cont: Int = 0

class ViewController: UIViewController
{
    let mtvc = MyTableViewController()
    
    @IBAction func VaiTableTeste()
    {
        navigationController?.pushViewController(mtvc, animated: true) // acao que transiciona de uma tela pra table view controller da classe MyTableViewController
    }
    
    @IBAction func TesteInsereAcougue()
    {
        if cont == 0
        {
            mtvc.AdicionaItem(item: "Carne", categoria: "Açougue")
            cont += 1
            
        }
        
        else if cont == 1
        {
            mtvc.AdicionaItem(item: "Vaca", categoria: "Açougue")
            cont += 1
        }
        
        else if cont == 2
        {
            mtvc.AdicionaItem(item: "Pexe", categoria: "Açougue")
            cont = 0
        }
        
        mtvc.tableView.reloadData()
    }
    
    @IBAction func TesteInserePadaria()
    {
        if cont == 0
        {
            mtvc.AdicionaItem(item: "Rosca", categoria: "Padaria")
            cont += 1
        }
        
        else if cont == 1
        {
            mtvc.AdicionaItem(item: "Pao", categoria: "Padaria")
            cont += 1
        }
        
        else if cont == 2
        {
            mtvc.AdicionaItem(item: "Bolo", categoria: "Padaria")
            cont = 0
        }
        
        mtvc.tableView.reloadData()
    }
    
    // ////////////////////////////////////////////////////////////////////////////////////////
    /*
    @IBAction func botãoCategoria(_ sender: Any)
    {
        
    let alert: UIAlertController = UIAlertController(title: "Alerta", message: "Olá eu sou um alerta ;)", preferredStyle: .alert)
        
        let action1: UIAlertAction = UIAlertAction(title: "Default", style: .default) {
        (action) in
        
        print("vc clicou no botão Default")
        
        }
        
        let action2: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) {
        (action) in
        
        print("vc clicou no botão Cancel")
        
        }
        let action3: UIAlertAction = UIAlertAction(title: "Destructive", style:
        .destructive) { (action) in
        
        print("vc clicou no botão Destructive")
        
        }
                        
        alert.addAction(action1)
        alert.addAction(action2)
        alert.addAction(action3)
        
        self.present(alert, animated:true, completion: nil)
    }
    */
    
}
