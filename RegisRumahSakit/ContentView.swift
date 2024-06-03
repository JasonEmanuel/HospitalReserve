//
//  ContentView.swift
//  RegisRumahSakit
//
//  Created by Jason Emanuel on 29/05/24.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    
    @State private var patientData = PatientData()
    @State private var showResult = false
    @State private var errorMessage = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Data Pribadi")) {
                    TextField("Nama Lengkap", text: $patientData.name)
                    TextField("Nama Panggilan", text: $patientData.nickname)
                    Picker("Jenis Kelamin", selection: $patientData.gender) {
                        Text("").tag("")
                        Text("Laki-laki").tag("Laki-laki")
                        Text("Perempuan").tag("Perempuan")
                    }
                    .pickerStyle(MenuPickerStyle())
                    DatePicker("Tanggal Lahir", selection: $patientData.birthDate, displayedComponents: .date)
                    TextField("Tempat Lahir", text: $patientData.birthPlace)
                }
                
                Section(header: Text("Informasi Tambahan")) {
                    Picker("Golongan Darah", selection: $patientData.bloodType) {
                        Text("").tag("")
                        Text("A").tag("A")
                        Text("B").tag("B")
                        Text("AB").tag("AB")
                        Text("O").tag("O")
                    }
                    .pickerStyle(MenuPickerStyle())
                    Picker("Rhesus", selection: $patientData.rhesus) {
                        Text("").tag("")
                        Text("Positif").tag("Positif")
                        Text("Negatif").tag("Negatif")
                    }
                    .pickerStyle(MenuPickerStyle())
                    TextField("Agama", text: $patientData.religion)
                }
                
                Section(header: Text("Kontak")) {
                    TextField("Nomor HP", text: $patientData.phoneNumber)
                        .keyboardType(.phonePad)
                    TextField("Email", text: $patientData.email)
                        .keyboardType(.emailAddress)
                }
                
                Section(header: Text("Identitas")) {
                    TextField("NIK", text: $patientData.nik)
                        .keyboardType(.numberPad)
                    TextField("Kewarganegaraan", text: $patientData.nationality)
                }
                
                NavigationLink(destination: SymptomView(patientData: $patientData), isActive: $showResult) {
                    Button(action: {
                        showResult = true
                    }) {
                        Text("Langkah Berikutnya")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
            .navigationBarTitle("Registrasi Pasien", displayMode: .inline)
            .onAppear {
                HealthKitManager.shared.requestAuthorization{ success, error in
                    if success {
                        HealthKitManager.shared.fetchPatientData {data, error in
                            if let data = data {
                                patientData = data
                            } else if let error = error {
                                errorMessage = error.localizedDescription
                            }
                        }
                    } else if let error = error {
                        errorMessage = error.localizedDescription
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
