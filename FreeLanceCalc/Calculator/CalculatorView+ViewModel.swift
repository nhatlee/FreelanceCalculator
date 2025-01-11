//
//  CalculatorView+ViewModel.swift
//  FreeLanceCalc
//
//  Created by Nhat Le on 28/9/24.
//

import Foundation
import Combine
import SwiftUI

extension CalculatorView {
    //If you need the fraction digits and preserve its precision digits you would need to use Swift Decimal type and initialize it with a String
    typealias TimeType = Float
    final class ViewModel: ObservableObject {
        @Published var jsonFileName: String = "Jan2025"
        
        @Published var intergerSum: TimeType = 0
        @Published var decimalSum: TimeType = 0
        @Published var hoursOfDecimalPart: TimeType = 0

        @Published var totalHours: Int = 0
        @Published var timeInMinutes: TimeType = 0
        @Published var totalDays: Int = 0
        @Published var minutes: Int = 0
        
        @Published var priceInVND: Double = 23600
        @Published var receivedVND: Double = 0
        
        private var cancellable = Set<AnyCancellable>()
        
        init() {
            addObservers()
        }
        
        deinit {
            cancellable.removeAll()
        }
        
        private func addObservers() {
            $jsonFileName
                .sink { [weak self] inputFileName in
                    guard !inputFileName.isEmpty else { return }
                    self?.calculate()
                }
                .store(in: &cancellable)
            
//            $priceInVND
//                .sink { [weak self] price in
//                guard let sSelf = self else { return }
//                let pricePerHour = 10
//                sSelf.receivedVND = (Double(sSelf.totalHours) + Double(sSelf.minutes/60)) * pricePerHour * sSelf.priceInVND
//                print("receivedVND:\(sSelf.receivedVND) for totalHours: \(sSelf.totalHours)- totalHours:\(sSelf.minutes)")
//            }
//            .store(in: &cancellable)
        }
        
        func calculate() {
            guard let path = Bundle.main.url(forResource: jsonFileName, withExtension: "json") else {
                print("----> Invalid file name")
                return
            }
            print("processing for:\(jsonFileName) ...")
            do {
                let data = try Data(contentsOf: path)
                let result = try JSONDecoder().decode([TimeType].self, from: data)
                
                totalDays = result.count
                let integerParts = result.map {$0.whole}
                
                intergerSum = integerParts.reduce(0, +)
                print("Interger sum:\(intergerSum)")
                
                let decimalParts = result.map{ $0.fraction * 100 }
                decimalSum = decimalParts.reduce(0, +)
                let decimalSumInt = Int(decimalSum)
                let hour = decimalSumInt/60
                minutes = decimalSumInt - hour * 60
                print("Decimal sum:\(decimalSum)- hour:\(hour) - minutes:\(minutes)")
                
                hoursOfDecimalPart = decimalSum/60
                print("Hours from decimal part:\(hoursOfDecimalPart)")
                totalHours = Int(intergerSum) + hour
                
                timeInMinutes = decimalSum + intergerSum * 60
            } catch {
                print("Error:---->\(error)")
            }
        }
        
        func getWorkingDaysInCurrentMonth() -> Int {
            // Get the current date
            let currentDate = Date()
            let calendar = Calendar.current

            // Get the current month and year
            let year = calendar.component(.year, from: currentDate)
            let month = calendar.component(.month, from: currentDate)

            // Get the range of days in the current month
            let range = calendar.range(of: .day, in: .month, for: currentDate)!

            var workingDays = 0

            // Iterate through each day in the month
            for day in range.lowerBound..<range.upperBound {
                // Create a date for the current day
                if let date = calendar.date(from: DateComponents(year: year, month: month, day: day)) {
                    // Check if the date is a weekday (Monday to Friday)
                    if calendar.isDateInWeekend(date) == false {
                        workingDays += 1
                    }
                }
            }

            return workingDays
        }
        
        var bindingPrice: Binding<String> {
            .init(
                get: { String(format:"%.2f", self.priceInVND) },
                set: { self.priceInVND = Double($0) ?? 0 }
            )
        }
    }
    
}
