//
//  ProfileView.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 3/11/25.
//

//
//  ProfileView.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 3/11/25.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("profileName") var profileName: String?
    @AppStorage("profileImage") var profileImage: String?
    
    @State private var isEditingName = false
    @State private var currentName = ""
    
    @State private var isEditingImage = false
    @State private var selectedImage: String?
    
    @State private var images = ["user1", "user2", "user3", "user4", "user5", "user6", "user7", "user8"]
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                Image(profileImage ?? "user2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.gray.opacity(0.25))
                    )
                    .onTapGesture {
                        withAnimation {
                            isEditingName = false
                            
                            isEditingImage = true
                        }
                        
                    }
                VStack(alignment: .leading) {
                    Text("Good Day!")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                        .minimumScaleFactor(0.5)
                    
                    Text(profileName ?? "Name")
                        .font(.title)
                }
            }
            
            if isEditingName {
                TextField("Enter Name...", text: $currentName)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                    )
                HStack {
                    Button {
                        withAnimation { isEditingName = false
                            currentName = profileName ?? ""
                        }
                    } label: {
                        Text("Cancel")
                            .padding()
                            .frame(maxWidth: 100)
                            .foregroundColor(.red)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                    }
                    Button {
                        withAnimation {profileName = currentName
                            isEditingName = false
                        }
                    } label: {
                        Text("Done")
                            .padding()
                            .frame(maxWidth: 100)
                            .foregroundColor(.white)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.black))
                    }
                }
            }
            
            if isEditingImage {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(images, id: \.self) { image in
                            Button {
                                //withAnimation(.interpolatingSpring(stiffness: 50, damping: 10))  added
                                withAnimation(.interpolatingSpring(stiffness: 50, damping: 10))  {
                                    selectedImage = image
                                }
                            } label: {
                                VStack {
                                    Image(image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                    
                                    if selectedImage == image {
                                        Circle()
                                            .frame(width: 16, height: 16)
                                            .foregroundColor(.primary)
                                    }
                                }
                                .padding()
                            }
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.gray.opacity(0.15))
                    )
                }
                
                HStack {
                    Button {
                        //withAnimation(.interpolatingSpring(stiffness: 50, damping: 10)) added
                        withAnimation(.interpolatingSpring(stiffness: 50, damping: 10))  {
                            isEditingImage = false
                            selectedImage = profileImage
                        }
                    } label: {
                        Text("Cancel")
                            .padding()
                            .frame(maxWidth: 100)
                            .foregroundColor(.red)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                    }
                    Button {
                        withAnimation {
                            profileImage = selectedImage
                            isEditingImage = false
                        }
                    } label: {
                        Text("Done")
                            .padding()
                            .frame(maxWidth: 100)
                            .foregroundColor(.white)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.black))
                    }
                }
                .padding(.bottom)
            }
            
            VStack {
                FitnessProfileItemButton(title: "Edit name", image: "square.and.pencil") {
                    // Close the other editor if it's open
                    
                    withAnimation {
                        if isEditingImage {
                            isEditingImage = false
                        }
                    }
                    currentName = profileName ?? ""
                    isEditingName = true
                }
                FitnessProfileItemButton(title: "Edit image", image: "square.and.pencil") {
                    // Close the other editor if it's open
                    withAnimation {
                        if isEditingName {
                            isEditingName = false
                        }
                    }
                    isEditingImage = true
                }
            }
            .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.15)))
            
            VStack {
                FitnessProfileItemButton(title: "Contact Us", image: "envelope") {
                    print("contact")
                }
                FitnessProfileItemButton(title: "Privacy Policy", image: "doc") {
                    print("privacy")
                }
                FitnessProfileItemButton(title: "Terms of Service", image: "doc") {
                    print("terms")
                }
            }
            .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.15)))
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .onAppear {
            withAnimation {
                selectedImage = profileImage
                currentName = profileName ?? ""
            }
        }
    }
}

struct FitnessProfileButton: View {
    var title: String
    var image: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: image)
                    .foregroundColor(.black)
                Text(title)
                    .foregroundColor(.primary)
                    .font(.headline)
                Spacer()
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1)))
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}


