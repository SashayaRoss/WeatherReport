//
//  WeatherUpdater.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 13/12/2025.
//

import Foundation

final class WeatherUpdater {
    private let interval: TimeInterval
    private let fetchHandler: () async -> Void
    private var timer: DispatchSourceTimer?
    
    init(interval: TimeInterval, fetchHandler: @escaping () async -> Void) {
        self.interval = interval
        self.fetchHandler = fetchHandler
    }
    
    deinit {
        stop()
    }
}

extension WeatherUpdater: WeatherUpdaterProtocol {
    func start() {
        stop()
        let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global(qos: .background))
        timer.schedule(deadline: .now(), repeating: interval, leeway: .milliseconds(Int(interval * 100)))
        
        timer.setEventHandler { [weak self] in
            guard let self = self else { return }
            Task { await self.fetchHandler() }
        }
        
        self.timer = timer
        timer.resume()
    }
    
    func stop() {
        timer?.cancel()
        timer = nil
    }
}
