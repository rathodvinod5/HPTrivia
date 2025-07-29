//
//  Store.swift
//  HPTrivia
//
//  Created by Vinod Rathod on 29/07/25.
//
import StoreKit

@MainActor
@Observable
class Store {
    var products: [Product] = []
    var purchased = Set<String>()
    
    private var updates: Task<Void, Never>? = nil
    
    // Load avalaible products
    func loadProducts() async {
        do {
            products = try await Product.products(for: ["hp4", "hp5", "hp6", "hp7"])
            products.sort {
                $0.displayName < $1.displayName
            }
        } catch {
            print("Unable to load products: \(error)")
        }
    }
    
    // Purchase a product
    
    // Check for purchased products
    
    // Connect with app store to watch for purchase and transaction updates
    
}
