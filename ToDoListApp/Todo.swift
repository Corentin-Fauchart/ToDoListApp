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
    private var dateRealisation: Date

    
    init(nom: String, description: String, date: Date){
        self.nom = nom
        self.description = description
        self.tacheEffectuee = false
        self.dateRealisation  = date
    }
    
    init(nom: String, description: String){
        self.nom = nom
        self.description = description
        self.tacheEffectuee = false
        self.dateRealisation  = Date()
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
    
    func setDateReal(date: Date){
        self.dateRealisation = date
    }
    
    func getDateReal() -> Date{
        return self.dateRealisation
    }
    
}
