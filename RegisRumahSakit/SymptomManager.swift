//
//  HealthKitViewModel.swift
//  RegisRumahSakit
//
//  Created by Jason Emanuel on 31/05/24.
//

import Foundation
import HealthKit

class SymptomManager: ObservableObject {
    private let healthStore = HKHealthStore()
    @Published var symptoms: [HKCategorySample] = []
    
    let symptomIdentifiers: [String: HKCategoryTypeIdentifier] = [
        "Abdominal Cramps": .abdominalCramps,
        "Bloating": .bloating,
        "Constipation": .constipation,
        "Diarrhea": .diarrhea,
        "Dizziness": .dizziness,
        "Fainting": .fainting,
        "Fatigue": .fatigue,
        "Fever": .fever,
        "Generalized Body Ache": .generalizedBodyAche,
        "Headache": .headache,
        "Heartburn": .heartburn,
        "Nausea": .nausea,
        "Rapid Pounding or Fluttering Heartbeat": .rapidPoundingOrFlutteringHeartbeat,
        "Shortness of Breath": .shortnessOfBreath,
        "Sore Throat": .soreThroat,
        "Vomiting": .vomiting
    ]
    
    init() {
        requestAuthorization()
    }
    
    private func requestAuthorization() {
        let symptomTypes = symptomIdentifiers.values.compactMap { HKObjectType.categoryType(forIdentifier: $0) }
        
        healthStore.requestAuthorization(toShare: Set(symptomTypes), read: Set(symptomTypes)) { success, error in
            if success {
                self.fetchSymptomsData()
            } else {
                print("Authorization failed: \(String(describing: error))")
            }
        }
    }
    
    private func fetchSymptomsData() {
        let symptomIdentifiers = self.symptomIdentifiers.values
        
        for identifier in symptomIdentifiers {
            guard let symptomType = HKObjectType.categoryType(forIdentifier: identifier) else {
                continue
            }
            
            let startDate = Date.distantPast
            let endDate = Date()
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
            
            let query = HKSampleQuery(sampleType: symptomType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { query, samples, error in
                if let error = error {
                    print("Error fetching symptoms: \(error.localizedDescription)")
                    return
                }
                
                guard let samples = samples as? [HKCategorySample] else {
                    print("Failed to fetch symptoms samples: \(String(describing: error))")
                    return
                }
                
                DispatchQueue.main.async {
                    self.symptoms.append(contentsOf: samples)
                }
            }
            
            healthStore.execute(query)
        }
    }
    
    func saveSymptom(symptomIdentifier: HKCategoryTypeIdentifier, startDate: Date, endDate: Date, value: Int, completion: @escaping (Bool) -> Void) {
        guard let symptomType = HKObjectType.categoryType(forIdentifier: symptomIdentifier) else {
            print("Symptom type not available")
            completion(false)
            return
        }
        
        let sample = HKCategorySample(type: symptomType, value: value, start: startDate, end: endDate)
        
        healthStore.save(sample) { success, error in
            if success {
                print("Symptom saved successfully")
                DispatchQueue.main.async {
                    self.symptoms.append(sample)
                }
                completion(true)
            } else {
                print("Failed to save symptom: \(String(describing: error))")
                completion(false)
            }
        }
    }
}
