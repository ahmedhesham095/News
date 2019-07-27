//
//  NetworkManager.swift
//  News
//
//  Created by Ahmed Hesham on 7/26/19.
//  Copyright © 2019 Ahmed Hesham. All rights reserved.
//

import Foundation
import Reachability

class NetworkManager: NSObject {
    
    var reachability: Reachability!
    
    // Create a singleton instance
    static let sharedInstance: NetworkManager = { return NetworkManager() }()
    
    
    override init() {
        super.init()
        
        // Initialise reachability
        reachability = Reachability()!
        do {
            // Start the network status notifier
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    static func stopNotifier() -> Void {
        do {
            // Stop the network status notifier
            try (NetworkManager.sharedInstance.reachability).startNotifier()
        } catch {
            print("Error stopping notifier")
        }
    }
    
    // Network is reachable
    static func isReachable(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection != .none {
            completed(NetworkManager.sharedInstance)
        }
    }
    
    // Network is unreachable
    static func isUnreachable(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection == .none {
            completed(NetworkManager.sharedInstance)
        }
    }
    
    // Network is reachable via WWAN/Cellular
    static func isReachableViaWWAN(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection == .cellular {
            completed(NetworkManager.sharedInstance)
        }
    }
    
    // Network is reachable via WiFi
    static func isReachableViaWiFi(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection == .wifi {
            completed(NetworkManager.sharedInstance)
        }
    }
}
