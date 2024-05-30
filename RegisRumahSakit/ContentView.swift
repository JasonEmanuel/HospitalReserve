//
//  ContentView.swift
//  RegisRumahSakit
//
//  Created by Jason Emanuel on 29/05/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var patientData = PatientData()
    @State private var showResult = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Data Pribadi")) {
                    TextField("Nama Lengkap", text: $patientData.name)
                    TextField("Nama Panggilan", text: $patientData.nickname)
                    Picker("Jenis Kelamin", selection: $patientData.gender) {
                        Text("Pilih").tag("")
                        Text("Laki-laki").tag("Laki-laki")
                        Text("Perempuan").tag("Perempuan")
                    }
                    .pickerStyle(MenuPickerStyle())
                    DatePicker("Tanggal Lahir", selection: $patientData.birthDate, displayedComponents: .date)
                    TextField("Tempat Lahir", text: $patientData.birthPlace)
                }
                
                Section(header: Text("Informasi Tambahan")) {
                    Picker("Golongan Darah", selection: $patientData.bloodType) {
                        Text("Pilih").tag("")
                        Text("A").tag("A")
                        Text("B").tag("B")
                        Text("AB").tag("AB")
                        Text("O").tag("O")
                    }
                    .pickerStyle(MenuPickerStyle())
                    Picker("Rhesus", selection: $patientData.rhesus) {
                        Text("Pilih").tag("")
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
                
                NavigationLink(destination: ResultView(
                    name: $patientData.name,
                    nickname: $patientData.nickname,
                    gender: $patientData.gender,
                    birthDate: $patientData.birthDate,
                    birthPlace: $patientData.birthPlace,
                    bloodType: $patientData.bloodType,
                    rhesus: $patientData.rhesus,
                    religion: $patientData.religion,
                    phoneNumber: $patientData.phoneNumber,
                    email: $patientData.email,
                    nik: $patientData.nik,
                    nationality: $patientData.nationality
                ), isActive: $showResult) {
                    Button(action: {
                        showResult = true
                    }) {
                        Text("Langkah Berikutnya")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
            .navigationBarTitle("Registrasi Pasien", displayMode: .inline)
        }
    }
}

#Preview {
    ContentView()
}
