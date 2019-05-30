//
//  RootContainner.swift
//  PodCastSwift
//
//  Created by tskim on 20/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import Moya
import Swinject

#if DEBUG
var loggerPlugin: [PluginType] {
    return [NetworkLoggerPlugin(verbose: true)]
}
#else
var loggerPlugin: [PluginType] {
    return []
}
#endif

let rootContainer: Container = {
    let container = Container()
    
    var moyaPlugins: [PluginType] = []
    moyaPlugins += loggerPlugin
    
    let provider = MoyaProvider<PodCastApi>(plugins: moyaPlugins)
    
    container.register(iTuneServiceType.self, factory: { _ in iTuneService(provider) })
    return container
}()
