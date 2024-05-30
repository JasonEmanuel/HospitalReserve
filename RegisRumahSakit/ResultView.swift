//
//  ResultView.swift
//  RegisRumahSakit
//
//  Created by Jason Emanuel on 29/05/24.
//

import SwiftUI

struct ResultView: View {
    @Binding var name: String
    @Binding var nickname: String
    @Binding var gender: String
    @Binding var birthDate: Date
    @Binding var birthPlace: String
    @Binding var bloodType: String
    @Binding var rhesus: String
    @Binding var religion: String
    @Binding var phoneNumber: String
    @Binding var email: String
    @Binding var nik: String
    @Binding var nationality: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Nama: \(name)")
            Text("Nickname: \(nickname)")
            Text("Jenis Kelamin: \(gender)")
            Text("Usia: \(birthDate)")
            Text("Tempat Lahir: \(birthPlace)")
            Text("Golongan Darah: \(bloodType)")
            Text("Rhesus: \(rhesus)")
            Text("Agama: \(religion)")
            Text("Nomor HP: \(phoneNumber)")
            Text("Email: \(email)")
            Text("NIK: \(nik)")
            Text("Kewarganegaraan: \(nationality)")
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Hasil Registrasi", displayMode: .inline)
    }
}

//#Preview {
//    ResultView(name: "Example Name", nickname: "Example Nickname", gender: "Laki-laki", age: "25", birthPlace: "Example City", bloodType: "A", rhesus: "Positif", religion: "Islam", phoneNumber: "123456789", email: "example@example.com", nik: "1234567890123456", nationality: "Indonesia")
//}

