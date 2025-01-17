//
//  MacAppServerApp.swift
//  MacAppServer
//
//  Created by Kamaal M Farah on 1/17/25.
//

import SwiftUI
import Swifter

@main
struct MacAppServerApp: App {
    @StateObject private var serverManager = ServerManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear { serverManager.startServer() }
                .onDisappear { serverManager.stopServer() }
        }
    }
}

class ServerManager: ObservableObject {
    private var server: HttpServer?

    func startServer() {
        server = HttpServer()

        server?["/hello"] = { request in
            return .ok(.text("Hello, world!"))
        }

        do {
            try server?.start(8080, forceIPv4: true)
            print("Server has started on http://localhost:8080")
        } catch {
            print("Server failed to start: \(error)")
        }
    }

    func stopServer() {
        server?.stop()
        print("Server has stopped")
    }
}
