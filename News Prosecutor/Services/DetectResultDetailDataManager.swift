//
//  DetectResultDetailDataManager.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/7/8.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DetectResultDetailDataManager {
    static let shared = DetectResultDetailDataManager(moc: NSManagedObjectContext.current)
    
    var managedContext: NSManagedObjectContext
    
    private init(moc: NSManagedObjectContext) {
        self.managedContext = moc
    }
    
    func getDetectResultDetail() -> [DetectResultDetail] {
        var detectResultDetailArray = [DetectResultDetail]()
        let request: NSFetchRequest<DetectResultDetail> = DetectResultDetail.fetchRequest()
        
        do {
            detectResultDetailArray = try self.managedContext.fetch(request)
        } catch {
            print(error)
        }
        
        return detectResultDetailArray
    }
    
    func saveDetectResultDetail(id: UUID, methodName: String, result: Bool) {
        let detectResultDetail = DetectResultDetail(context: self.managedContext)
        detectResultDetail.id = id
        detectResultDetail.methodName = methodName
        detectResultDetail.result = result
        
        do {
            try self.managedContext.save()
        } catch { 
            print(error)
        }
    }
    
    func removeDetectResultDetail(id: UUID) {
        let request: NSFetchRequest<DetectResultDetail> = DetectResultDetail.fetchRequest()
        request.predicate = NSPredicate.init(format: "id=%@", id.uuidString)
        
        do {
            let detectResultDetailArray = try self.managedContext.fetch(request)
            
            for detectResultDetail in detectResultDetailArray {
                self.managedContext.delete(detectResultDetail)
            }
            
            try self.managedContext.save()
            
        } catch {
            print(error)
        }
    }
    
    func updateDetectResultDetail(id: UUID, methodName: String, result: Bool) {
        let request: NSFetchRequest<DetectResultDetail> = DetectResultDetail.fetchRequest()
        request.predicate = NSPredicate.init(format: "id=%@", id.uuidString)
        
        do {
            let detectResultDetail = try self.managedContext.fetch(request).first
            detectResultDetail?.methodName = methodName
            detectResultDetail?.result = result
            
            try self.managedContext.save()
            
        } catch {
            print(error)
        }
    }
}

extension NSManagedObjectContext {
    static var current: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}

