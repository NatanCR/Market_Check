//
//  BotaoCategorias.swift
//  MarketCheck
//
//  Created by Henrique Batista de Assis on 11/03/22.
//

import Foundation
import UIKit

// VARIAVEIS E INSTANCIAS ////////////
var vc = ViewController()
private let midX = (vc.view.frame.width / 2) - 175 // pegando o centro do eixo x da tela do celular

//enum Categoria
//{
//    case Hortifruti
//    case Padaria
//}

// CLASSE ////////////////////////////////
public class BotaoCategoria : UITableViewController
{
    //public let botao = UIButton(configuration: .plain(), primaryAction: nil)
    public var table = UITableView()

    
    // METODO CRIABOTAO //////////////////////
    /*
    public func CriaBotao() // metodo que cria o botao das categorias
    {
        // BASE
        botao.frame = CGRect(x: midX, y: 150, width: 350, height: 40) // setando posicao e tamanho do botao
        
        // TITULO
        botao.configuration?.title = "Padaria"
        
        // BORDA
        botao.layer.borderWidth = 1.0
        botao.layer.borderColor = UIColor.black.cgColor // adicionando borda no botao da cor preta
        botao.layer.cornerRadius = 10 // muda a curvatura das bordas do botao
        
        // IMAGEM / ICONE
        botao.configuration?.image = UIImage(systemName: "1.circle") // setando uma imagem pro botao
        botao.configuration?.imagePlacement = .leading // imagem sera colocada a esquerda do titulo
        botao.configuration?.imagePadding = 8.0 // separacao da imagem com os outros conteudos do botao
        
        // CONTEUDO
        botao.configuration?.baseForegroundColor = UIColor.black // altera a cor do conteudo do botao (conteudo = texto e imagens)
        botao.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 230) // alinhamento de todo o conteudo do botao
        
    }
     */
    
    public override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    
    public func tableview(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "garai"
        return cell
    }
}
