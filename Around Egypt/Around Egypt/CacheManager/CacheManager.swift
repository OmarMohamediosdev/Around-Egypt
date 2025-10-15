//
//  CacheManager.swift
//  Around Egypt
//
//  Created by Omar Mohamed on 15/10/2025.
//

import Foundation

final class CacheManager {
    static let shared = CacheManager()
    private init() {}

    private var cacheDirectory: URL {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    }

    // MARK: - Save
    func save<T: Codable>(_ data: T, to filename: String) {
        let url = cacheDirectory.appendingPathComponent(filename)
        do {
            let jsonData = try JSONEncoder().encode(data)
            try jsonData.write(to: url, options: .atomic)
        } catch {
            print("❌ Failed to save cache:", error)
        }
    }

    // MARK: - Load
    func load<T: Codable>(from filename: String, as type: T.Type) -> T? {
        let url = cacheDirectory.appendingPathComponent(filename)
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(type, from: data)
        } catch {
            print("⚠️ Failed to load cache:", error)
            return nil
        }
    }
}
