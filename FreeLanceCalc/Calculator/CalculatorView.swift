//
//  CalculatorView.swift
//  FreeLanceCalc
//
//  Created by Nhat Le on 28/9/24.
//

import SwiftUI

struct CalculatorView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                TextField("Input json file name", text: $viewModel.jsonFileName, prompt: Text("Input json file name"))
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                infoView
            }
            .navigationTitle("Freelance time calculator")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var infoView: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack {
                    Text("Working days of month: \(viewModel.getWorkingDaysInCurrentMonth())")
                    Text("Expected(5 hours/day): \(viewModel.getWorkingDaysInCurrentMonth()*5) hours")
                }
                VStack {
                    Text("Days of work: \(viewModel.totalDays)")
                        .font(.title)
                    Text("Interger parts sum:")
                        .font(.title)
                    Text("\(viewModel.intergerSum) hours")
                        .font(.subheadline)
                }
                VStack {
                    Text("Decimal parts sum:")
                        .font(.title)
                    Text("\(viewModel.decimalSum) minites")
                        .font(.subheadline)
                    Text("To hours:\(viewModel.hoursOfDecimalPart)")
                        .font(.subheadline)
                }
                Text("Total minutes: \(viewModel.timeInMinutes)")
                    .font(.subheadline)
                VStack {
                    Text("Total:")
                    Text("\(viewModel.totalHours) hours and \(viewModel.minutes) minutes")
                        .font(.title)
                    Divider()
                    TextField("Inptut price", text: viewModel.bindingPrice)
                        .textFieldStyle(.roundedBorder)
                    Text("Money'll receive")
                    Text(String(format: "%.2f", viewModel.receivedVND))
                }
            }
        }
    }
}

#Preview {
    CalculatorView()
}
