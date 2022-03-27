//
//  CategoriaSort.swift
//  MarketCheck
//
//  Created by Henrique Batista de Assis on 17/03/22.
//

import UIKit
import Foundation

var mtvc = MyTableViewController()
var indice: Int = -1

class CategoriaSort
{
    public func CatSort(cat: [String]) -> Int // ordena o vetor de categorias e retorna o index que a categoria nova foi inserida
    {
        let categoriaInserida: String = cat[cat.count - 1] // pega qual foi a categoria inserida
        
        for i in 0 ..< cat.count // loop dentro do vetor "cat" e sabendo seu index
        {
            if categoriaInserida < cat[i] // se a categoria inserida for alfabeticamente menor, armazena qual o index que ele deve ser inserida
            {
                indice = i
                break // quebra o loop
            }
            
            else if categoriaInserida == cat[i] // se a categoria for igual ao do vetor, isso quer dizer que ja esta no ultimo elemento do vetor, ou seja, ja esta no lugar certo
            {
                indice = -1 // = -1 apenas para saber que basta dar um .append no vetor principal
            }
        }
        
        return indice // retorna o index que deve ser inserido a categoria
    }
}
