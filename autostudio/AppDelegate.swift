//
//  AppDelegate.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import UIKit
import CoreData
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var container = Container()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.registerDependencies()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK: - DI stack
    
    func registerDependencies() {
        container.register(NetworkServiceType.self, factory: {_ in return NetworkService()})
        container.register(APIClientType.self, factory: {r in
            return APIClient(networkService: r.resolve(NetworkServiceType.self)!)})
        
        container.register(ClientTableServiceType.self, factory: {r in return ClientTableService(apiClient: r.resolve(APIClientType.self)!)})
        
        
        
        container.register(ClientsTableViewModelType.self, factory: {r in return ClientTableViewModel(service: r.resolve(ClientServiceType.self)!)}).inObjectScope(.container)
        
        
        
        
        container.register(CreateClientServiceType.self, factory: { r in
            return CreateClientService(apiClient: r.resolve(APIClientType.self)!)
        })
        container.register(CreateClientViewModelType.self, factory: { r in
            return CreateClientViewModel(createClientService: r.resolve(CreateClientServiceType.self)!)
        })
        
        container.register(ClientDetailsServiceType.self, factory: { r in
            return ClientDetailsService(apiClient: r.resolve(APIClientType.self)!)
        })
        container.register(ClientDetailsViewModelType.self, factory: {r in return
            ClientDetailsViewModel(clientDetailsService: r.resolve(ClientDetailsServiceType.self)!)
        })
        
        container.register(EditClientViewModelType.self, factory: {_ in return EditClientViewModel()})
        
        container.register(ClientServiceType.self, factory: {r in
            return ClientService(apiClient: r.resolve(APIClientType.self)!)
        }).inObjectScope(.container)
    }
    

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "autostudio")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

