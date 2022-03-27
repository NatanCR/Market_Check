//
//  MyTableViewController.swift
//  MarketCheck
//
//  Created by Henrique Batista de Assis on 13/03/22.
//

// TABLE  = Conjunto de secoes
// SECOES = Conjunto de linhas
// LINHA  = Cada botao da table
// CELULA = Conteudo dentro de uma linha

//    "Açougue",
//    "Bebidas",
//    "Cereais e Grãos",
//    "Congelados e Frios",
//    "Higiene Pessoal",
//    "Hortifruti",
//    "Laticínios",
//    "Padaria",
//    "Papelaria",
//    "Pets",
//    "Produtos de Limpeza",
//    "Utilidades",
//    "Outros"

//    func CriaNavigationBar()
//    {
//        let screenSize: CGRect = UIScreen.main.bounds
//        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 100))
//
//        let navItem = UINavigationItem()
//
//        let backButton = UIBarButtonItem()
//        let addItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: nil, action: #selector(VaiAdicionarItem))
//
//        backButton.title = "Mercado Check"
//        navItem.title = "Mercado Check"
//        navItem.largeTitleDisplayMode = .always
//        navItem.backBarButtonItem = backButton
//
//        UINavigationBar.appearance().prefersLargeTitles = true
//        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.systemGreen]
//
//        navItem.rightBarButtonItem = addItem
//        navBar.setItems([navItem], animated: false)
//        self.view.addSubview(UIView(frame: .zero))
//        self.view.addSubview(navBar)
//    }

import UIKit

struct itens // struct contendo variaveis de armazenamento para dados de um item
{
    var categoria = String()
    var nomeItem = String()
}

public struct dadosCell: Codable // struct contendo variaveis de armazenamento para dados de cada celula
{
    var aberto = Bool()         // verifica se a categoria esta aberta
    var titulo = String()       // nome da categoria
    var secaoDados = [String]() // vetor de nome dos itens de cada categoria
    var checkItens = [Bool]()
}

public var tableViewData = [dadosCell]() // vetor do struct dadosCell
var itensTotal = [itens]()               // cetor do struct itens
var categoriaSort = CategoriaSort()      // instancia da classe CategoriaSort
var arrayCategorias: [String] = []       // para armazenar apenas as categorias
var indiceInserir: Int = 0                 // para inserir a categoria no vetor no index certo apos realizar o sort
let userDef = UserDefaults()
var canBreak = false

class MyTableViewController: UITableViewController
{
    
    // ADICIONA ITEM ////////////////////////////////////////////////////////////////////////
    func AdicionaItem(item: String, categoria: String) // funcao para adicionar itens dentro de uma categoria
    {
         if !tableViewData.contains(where: {$0.titulo == categoria}) // comparacao para ver se a categoria do item inserido ainda nao existe, comparando apenas a variavel "titulo" dentro da variavel "tableViewData"que contem a struct "dadosCell
        {
            AdicionaCategoria(categoria: categoria) // chama a funcao que adiciona a categoria
        }
        
        let index = tableViewData.firstIndex(where: {$0.titulo == categoria}) // armazena o index da categoria que o item sera inserido
        tableViewData[index!].secaoDados.append(item) // da o append para funcionamento do sort
        tableViewData[index!].checkItens.append(false)
        
        if tableViewData[index!].secaoDados.count > 1 // se tem apenas 1 item, nao precisa organizar
        {
            indiceInserir = categoriaSort.CatSort(cat: tableViewData[index!].secaoDados) // verifica qual index ira inserir o item pelo CategoriaSort
            
            if indiceInserir > -1 // se o index for > -1, precisa ser inserido
            {
                tableViewData[index!].secaoDados.insert(item, at: indiceInserir) // insere o item no index correto
                tableViewData[index!].secaoDados.removeLast() // se o item foi inserido numa posicao difrente, remove ele que esta no final tambem
            }
        }
    }
    
    // ADICIONA CATEGORIA //////////////////////////////////////////////////////////////////
    private func AdicionaCategoria(categoria: String) // funcao para adicionar uma nova categoria
    {
        if (tableViewData.count > 0)
        {
            for i in 0 ..< tableViewData.count
            {
                arrayCategorias[i] = tableViewData[i].titulo
            }
        }
        
        arrayCategorias.append(categoria) // passa a categoria para a array que verifica as categorias para fazer o sort
        
        if arrayCategorias.count > 1 // se a quantia de itens no vetor for maior que 1, manda para o sort
        {
            indiceInserir = categoriaSort.CatSort(cat: arrayCategorias) // pega qual o index que deve ser inserido a categoria nova, utilizando da classe "CategoriaSort"
            
            if indiceInserir > -1 // se o index retornado for maior que -1, entao nao é o final do vetor que deve ser inserido
            {
                tableViewData.insert(dadosCell(aberto: false, titulo: categoria, secaoDados: [], checkItens: []), at: indiceInserir)
            }
            
            else // se o index for -1, basta apenas dar um .append
            {
                tableViewData.append(dadosCell(aberto: false, titulo: categoria, secaoDados: [], checkItens: []))
            }
        }
        
        else
        {
            tableViewData.append(dadosCell(aberto: false, titulo: categoria, secaoDados: [], checkItens: [])) // adiciona a nova categoria no final do vetor
        }
        
    }
    
    public func RemoveItem(item: String, categoria: String)
    {
        for i in 0 ..< tableViewData.count
        {
            if (tableViewData[i].titulo == categoria)
            {
                let tableCount = tableViewData.count
                
                for j in 0 ..< tableViewData[i].secaoDados.count
                {
                    if (tableViewData[i].secaoDados[j] == item)
                    {
                        tableViewData[i].secaoDados.remove(at: j)
                    
                        if tableViewData[i].secaoDados.count == 0
                        {
                            let catCount = arrayCategorias.count
                            
                            for k in 0 ..< arrayCategorias.count
                            {
                                if (arrayCategorias.count == catCount)
                                {
                                    if arrayCategorias[k] == tableViewData[i].titulo
                                    {
                                        arrayCategorias.remove(at: k)
                                    }
                                }
                            }
                            
                            if tableViewData.count == tableCount
                            {
                                tableViewData.remove(at: i)
                            }
                        }
                    
                        SaveData()
                        refresh()
                        
                        canBreak = true
                        break
                        
                    } // fecha if de itens
                    
                } // fecha for de itens
                
            } // fecha if de categoria
            
            if canBreak == true
            {
                canBreak = false
                break
            }
            
        } // fecha for de categoria
        
    } // fecha func
    
    public func RemoveAll()
    {
        tableViewData = []
        arrayCategorias = []
        SaveData()
    }
    
    func ChangeCheck(item: String, categoria: String, check: Bool)
    {
        var jaCheck = false
        
        for i in 0 ..< tableViewData.count
        {
            if categoria == tableViewData[i].titulo
            {
                for j in 0 ..< tableViewData[i].secaoDados.count
                {
                    if item == tableViewData[i].secaoDados[j] && !jaCheck && tableViewData[i].checkItens[j] == !check
                    {
                        print("guiguigui")
                        tableViewData[i].checkItens[j] = check
                        jaCheck = true
                        SaveData()
                        break
                    }
                }
            }
        }
    }
    
    public func refresh()
    {
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        if let objArmazenado = UserDefaults.standard.data(forKey: "saveTable")
        {
            if let tableArmazenado = try? JSONDecoder().decode([dadosCell].self, from: objArmazenado)
            {
                tableViewData = tableArmazenado
            }
        }
        
        if let loadCategoria = defaults.value(forKey: "categoriaSave") as? [String]
        {
            arrayCategorias = loadCategoria
        }
        
        refresh()
    }
    
    public func SaveData()
    {
        if let codificado = try? JSONEncoder().encode(tableViewData)
        {
            UserDefaults.standard.set(codificado, forKey: "saveTable")
        }
        
        defaults.setValue(arrayCategorias, forKey: "categoriaSave")
    }
    
    
    // VIEW DID LOAD ///////////////////////////////////////////////////////////////////////
    override func viewDidLoad() // metodo override para mostrar a tela
    {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell") // identificador para cada celula (linha)
        
    }
    
    // NUMBER OF SECTIONS (quantia de secoes) /////////////////////////////////
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return tableViewData.count // numero de secoes da table eh igual ao count (length) do vetor tableViewData
    }
    
    // NUMBER OF ROWS IN SECTION (quantia de linhas na secao) /////////////////////////////////
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int // retorna o numero de linhas numa secao da table
    {
        if tableViewData[section].aberto == true // se a categoria estiver aberta, o numero de linhas nessa secao é a quantia de itens da categoria
        {
            return tableViewData[section].secaoDados.count + 1 // retorna o count do vetor de itens na categoria como quantidade de secoes. precisa do +1 pois o programa conta a categoria em si como uma linha também
        }
        
        else
        {
            return 1 // apenas uma secao se categoria estiver fechado
        }
    }
    
    // CELL FOR ROW AT (o que cada celula terá por linha) /////////////////////////////////////
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let dataIndex = indexPath.row - 1 // apenas pra deixar o codigo mais limpo mais abaixo. precisa do -1 para nao estourar o vetor
        
        if indexPath.row == 0 // se o index da celula da linha for a primeira (a da categoria)
        {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()} // necessario para identificar as celulas
            
            
            cell.textLabel?.text = tableViewData[indexPath.section].titulo // estara escrito na celula o titulo da categoria
            cell.imageView?.image = UIImage(named: tableViewData[indexPath.section].titulo) // adiciona o icone da categoria
            cell.backgroundColor = UIColor.systemGray6
            
            let quantiaCheck = tableViewData[indexPath.section].checkItens.count
            var tudoCheck: Int = 0
            
            for i in 0 ..< quantiaCheck
            {
                if tableViewData[indexPath.section].checkItens[i] == true
                {
                    tudoCheck += 1
                }
            }
            
            if tudoCheck == quantiaCheck
            {
                cell.textLabel?.textColor = UIColor.link
            }
            
            else
            {
                cell.textLabel?.textColor = UIColor.black
            }
            
            return cell
        }
        
        else
        {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
            
            cell.textLabel?.text = tableViewData[indexPath.section].secaoDados[dataIndex] // se nao for a primeira celula da secao, o nome nela sera a do item.
            
            if tableViewData[indexPath.section].checkItens[indexPath.row - 1] // if check eh true
            {
                cell.imageView?.image = UIImage(systemName: "checkmark.circle.fill")
                cell.textLabel?.textColor = UIColor.systemGray2
            }
            
            else if !tableViewData[indexPath.section].checkItens[indexPath.row - 1] // if check eh falso
            {
                cell.imageView?.image = UIImage(systemName: "circlebadge")
                cell.textLabel?.textColor = UIColor.black
            }
            
            cell.backgroundColor = UIColor.white
            
            return cell
        }
    }
    
    // DID SELECT ROW (o que faz quando seleciona a linha) ///////////////////////////////
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.row == 0 // se seleciona a categoria, abre ou fecha seus itens
        {
            if tableViewData[indexPath.section].aberto == true
            {
                tableViewData[indexPath.section].aberto = false // se estiver aberto, ela fecha
            }
        
            else
            {
                tableViewData[indexPath.section].aberto = true // se estiver fechado, ela abre
            }
            
            let secoes = IndexSet.init(integer: indexPath.section) // arrumando o numero de linhas que tem na secao
            tableView.reloadSections(secoes, with: .none) // da reload na table
        }
        
        else // trocar de check
        {
            tableViewData[indexPath.section].checkItens[indexPath.row - 1] = !tableViewData[indexPath.section].checkItens[indexPath.row - 1]
            adi.ChangeCheckItem(categoria: tableViewData[indexPath.section].titulo, item: tableViewData[indexPath.section].secaoDados[indexPath.row - 1], checkInterno: !tableViewData[indexPath.section].checkItens[indexPath.row - 1])
            
            SaveData()
            self.tableView.reloadData()
        }
    }
}
