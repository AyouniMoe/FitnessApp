//
//  ProfileViewModel.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 3/12/25.
//

import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var isEditingName = false
    @Published var currentName = ""
    @Published var profileName: String? = UserDefaults.standard.string(forKey: "profileName")
    
    @Published var isEditingImage = false
    @Published var profileImage: String? = UserDefaults.standard.string(forKey: "profileImage")
    @Published var selectedImage: String? = UserDefaults.standard.string(forKey: "profileImage")
    
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
}

