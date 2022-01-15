//
//  Todo.swift
//  ToDoListApp
//
//  Created by Corentin Fauchart on 07/12/2021.
//

import Foundation

class Todo: Codable {
    private var nom: String
    private var description: String
    private var tacheEffectuee: Bool

    
    init(nom: String, description: String){
        self.nom = nom
        self.description = description
        self.tacheEffectuee = false
    }
    
    func setEtatTache(etat: Bool){
        self.tacheEffectuee = etat
    }
    
    func getEtatTache() -> Bool{
        return self.tacheEffectuee
    }
    
    func setNom(nom: String){
        self.nom = nom
    }
    
    func getNom() -> String{
        return self.nom
    }
    
    func setDescription(desc: String){
        self.description = desc
    }
    
    func getDescription() -> String{
        return self.description
    }
    
    
}
