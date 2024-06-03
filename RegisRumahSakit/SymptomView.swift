//
//  SymptomView.swift
//  RegisRumahSakit
//
//  Created by Jason Emanuel on 31/05/24.
//

import SwiftUI
import HealthKit

struct SymptomView: View {
    @StateObject private var viewModel = SymptomManager()
    @Binding var patientData: PatientData
    @State private var showInputSheet = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var selectedSymptom: HKCategoryTypeIdentifier? = nil
    @State private var showResult = false
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.symptoms, id: \.uuid) { sample in
                    VStack(alignment: .leading) {
                        Text(formatIdentifier(sample.categoryType.identifier))
                            .font(.headline)
                        Text("Start: \(formatDate(sample.startDate))")
                        Text("End: \(formatDate(sample.endDate))")
                    }
                }
                
                NavigationLink(destination: ResultView(patientData: $patientData, symptoms: viewModel.symptoms), isActive: $showResult) {
                    Button(action: {
                        showResult = true
                    }) {
                        Text("Langkah Berikutnya")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                .navigationTitle("Health Symptoms")
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Health Symptoms"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    func formatIdentifier(_ identifier: String) -> String {
        let prefix = "HKCategoryTypeIdentifier"
        var name = identifier.replacingOccurrences(of: prefix, with: "")
        name = name.replacingOccurrences(of: "([A-Z])", with: " $1", options: .regularExpression, range: name.range(of: name))
        name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        return name
    }

    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMM yyyy 'at' HH:mm:ss"
        formatter.timeZone = TimeZone(identifier: "Asia/Jakarta") // WIB time zone
        return formatter.string(from: date)
    }
}

#Preview {
    ContentView()
}

