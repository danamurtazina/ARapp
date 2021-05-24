//
//  Model.swift
//  ARM
//
//  Created by Дана Муртазина on 23.05.2021.
//

import SwiftUI
import RealityKit
import Combine

enum ModelCategory: CaseIterable {
    case france
    case italy
    case russia
    case egypt
    case england
    case usa
    
    var label: String {
        get {
            switch self {
            case .france:
                return "France"
            case .italy:
                return "Italy"
            case .russia:
                return "Russia"
            case .egypt:
                return "Egypt"
            case .england:
                return "England"
            case .usa:
                return "USA"
            }
        }
    }
}


class Model {
    var name: String
    var category: ModelCategory
    var thumbnails: UIImage
    var modelEntity: ModelEntity?
    var scaleCompensation: Float
    
    private var cancellable: AnyCancellable?
    
    init(name: String, category: ModelCategory, scaleCompensation: Float = 1.0) {
        self.name = name
        self.category = category
        self.thumbnails = UIImage(named: name) ?? UIImage(systemName: "photo")!
        self.scaleCompensation = scaleCompensation
    }
    
    
    func asyncLoadModelEntity() {
        let filename = self.name + ".usdz"
        
        self.cancellable = ModelEntity.loadModelAsync(named: filename)
            .sink(receiveCompletion: { loadCompletion in
                
                switch loadCompletion {
                case .failure(let error): print("Unable to load modelEntity for \(filename).Error: \(error.localizedDescription)")
                case .finished:
                    break
                }
            
            }, receiveValue: { modelEntity in
            
                self.modelEntity = modelEntity
                self.modelEntity?.scale *= self.scaleCompensation
                
                print("modelEntity for \(self.name) has been loaded.")
                
            })
    }
}

struct Models {
    var all: [Model] = []
    
    init() {
        //France
        let EiffelTower = Model(name: "EiffelTower", category: .france, scaleCompensation: 0.32/100)
        
        self.all += [EiffelTower]
        
        //Italy
        let Colloseum = Model(name: "Colloseum", category: .italy, scaleCompensation: 0.32/100)
        
        self.all += [Colloseum]
        
        //Russia
        let SaintBasilCathedral = Model(name: "SaintBasilCathedral", category: .russia, scaleCompensation: 0.32/100)
        
        
        self.all += [SaintBasilCathedral]
        
        //Egypt
        let Sphinx = Model(name: "Sphinx", category: .egypt, scaleCompensation: 0.32/100)
        
        self.all += [Sphinx]
        
        //England
        let BigBen = Model(name: "BigBen", category: .england, scaleCompensation: 0.32/100)
        
        self.all += [BigBen]
        
        //USA
        let LibertyStatue = Model(name: "LibertyStatue", category: .usa, scaleCompensation: 0.32/10001)
        
        self.all += [LibertyStatue]
    }
    
    func get (category: ModelCategory) -> [Model] {
        return all.filter( {$0.category == category} )
    }
    
}
