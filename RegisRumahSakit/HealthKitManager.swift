//
//  HealthKitManager.swift
//  RegisRumahSakit
//
//  Created by Jason Emanuel on 30/05/24.
//

import Foundation
import HealthKit

class HealthKitManager: ObservableObject {
    static let shared = HealthKitManager()
    let healthStore = HKHealthStore()
    
    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, NSError(domain: "com.example.healthkit", code: 2, userInfo: [NSLocalizedDescriptionKey: "HealthKit is not available in this device."]))
            return
        }
        
        let readTypes: Set<HKObjectType> = [HKObjectType.characteristicType(forIdentifier: .dateOfBirth)!,
                                            HKObjectType.characteristicType(forIdentifier: .biologicalSex)!,
                                            HKObjectType.characteristicType(forIdentifier: .bloodType)!]
        
        healthStore.requestAuthorization(toShare: nil, read: readTypes, completion: completion)
    }
    
    func fetchPatientData(completion: @escaping (PatientData?, Error?) -> Void) {
        var patientData = PatientData()
        
        do {
            let birthDate = try healthStore.dateOfBirth()
            patientData.birthDate = birthDate
        } catch {
            completion(nil, error)
            return
        }
        
        do {
            let biologicalSex = try healthStore.biologicalSex().biologicalSex
            switch biologicalSex {
            case .female:
                patientData.gender = "Perempuan"
            case .male:
                patientData.gender = "Laki-laki"
            default:
                patientData.gender = "Other"
            }
        } catch {
            completion(nil, error)
            return
        }
        
        do {
            let bloodType = try healthStore.bloodType().bloodType
            switch bloodType {
            case .aPositive:
                patientData.bloodType = "A"
                patientData.rhesus = "Positif"
            case .aNegative:
                patientData.bloodType = "A"
                patientData.rhesus = "Negatif"
            case .bPositive:
                patientData.bloodType = "B"
                patientData.rhesus = "Positif"
            case .bNegative:
                patientData.bloodType = "B"
                patientData.rhesus = "Negatif"
            case .abPositive:
                patientData.bloodType = "AB"
                patientData.rhesus = "Positif"
            case .abNegative:
                patientData.bloodType = "AB"
                patientData.rhesus = "Negatif"
            case .oPositive:
                patientData.bloodType = "O"
                patientData.rhesus = "Positif"
            case .oNegative:
                patientData.bloodType = "O"
                patientData.rhesus = "Negatif"
            default:
                patientData.bloodType = "Unknown"
                patientData.rhesus = ""
            }
        } catch {
            completion(nil, error)
            return
        }
        
        completion(patientData, nil)
    }
}
