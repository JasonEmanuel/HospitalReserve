//
//  ResultView.swift
//  RegisRumahSakit
//
//  Created by Jason Emanuel on 29/05/24.
//

import SwiftUI
import HealthKit

struct ResultView: View {
    @Binding var patientData: PatientData
    @Binding var symptoms: [HKCategorySample]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Nama: \(patientData.name)")
                Text("Nickname: \(patientData.nickname)")
                Text("Jenis Kelamin: \(patientData.gender)")
                Text("Tanggal Lahir: \(patientData.birthDate)")
                Text("Tempat Lahir: \(patientData.birthPlace)")
                Text("Golongan Darah: \(patientData.bloodType)")
                Text("Rhesus: \(patientData.rhesus)")
                Text("Agama: \(patientData.religion)")
                Text("Nomor HP: \(patientData.phoneNumber)")
                Text("Email: \(patientData.email)")
                Text("NIK: \(patientData.nik)")
                Text("Kewarganegaraan: \(patientData.nationality)")
                
                
                Text("Gejala yang Dilaporkan:")
                    .font(.headline)
                    .padding(.top)
                
                ForEach(symptoms, id: \.uuid) { symptom in
                    VStack(alignment: .leading) {
                        Text(formatIdentifier(symptom.categoryType.identifier))
                            .font(.subheadline)
                        Text("Mulai: \(formatDate(symptom.startDate))")
                        Text("Berakhir: \(formatDate(symptom.endDate))")
                    }
                    .padding(.bottom, 5)
                }
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Hasil Registrasi", displayMode: .inline)
        }
    }
    
    private func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    private func formatIdentifier(_ identifier: String) -> String {
        let prefix = "HKCategoryTypeIdentifier"
        var name = identifier.replacingOccurrences(of: prefix, with: "")
        name = name.replacingOccurrences(of: "([A-Z])", with: " $1", options: .regularExpression, range: name.range(of: name))
        name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        return name
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMM yyyy 'at' HH:mm:ss"
        formatter.timeZone = TimeZone(identifier: "Asia/Jakarta") // WIB time zone
        return formatter.string(from: date)
    }
}

//#Preview {
//    ResultView(name: "Example Name", nickname: "Example Nickname", gender: "Laki-laki", age: "25", birthPlace: "Example City", bloodType: "A", rhesus: "Positif", religion: "Islam", phoneNumber: "123456789", email: "example@example.com", nik: "1234567890123456", nationality: "Indonesia")
//}

