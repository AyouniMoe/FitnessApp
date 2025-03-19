//
//  ProfileViewModel.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 3/12/25.
//

import Foundation
import SwiftUI

@Observable

class ProfileViewModel {
     var isEditingName = false
     var currentName = ""
     var profileName: String? = UserDefaults.standard.string(forKey: "profileName")
    
     var isEditingImage = false
     var profileImage: String? = UserDefaults.standard.string(forKey: "profileImage")
     var selectedImage: String? = UserDefaults.standard.string(forKey: "profileImage")
    
     var showAlert = false
    
    var images = [
        "user1", "user2", "user3", "user4", "user5", "user6", "user7", "user8"
    ]
    
    func presentEditName() {
        isEditingName = true
        isEditingImage = false
    }
    
    func presentEditImage() {
        isEditingName = false
        isEditingImage = true
    }
    
    func dismissEdit() {
        isEditingName = false
        isEditingImage = false
    }
    
    func setNewName() {
       // if !currentName.isEmpty { }     IN VID 7:58:08 this was eddited I left it out because the profile view did not have the correct code and wasnt able to see where to incorporate the correct code in the profileview
        
            profileName = currentName
            UserDefaults.standard.setValue(currentName, forKey: "profileName")
            dismissEdit()

    }
    
    func didSelectNewImage(name: String) {
        selectedImage = name
    }
    
    func setNewImage() {
        profileImage = selectedImage
        UserDefaults.standard.setValue(selectedImage, forKey: "profileImage")
        dismissEdit()
    }
    func presentEmailApp() {
        let emailSubject = "Fitness App - Contact US"
        let emailRecipient = "Ayounimo.visionbios@gmail.com"
        
        let encodedSubject = emailSubject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let encodedReciepient = emailRecipient.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        let urlString = "mailto: \(encodedReciepient)?subject=\(encodedSubject)"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.showAlert = true
            }
        }
            
            
        }
        
        
    }
    


