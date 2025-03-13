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
    @StateObject var viewModel = ProfileViewModel()

    var body: some View {
        mainContent
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }

    // MARK: - Main Content
    private var mainContent: some View {
        VStack {
            profileHeader
            editingSections
            editButtons
            infoButtons
        }
    }

    // MARK: - Editing Sections
    private var editingSections: some View {
        Group {
            if viewModel.isEditingImage { imageEditor }
            if viewModel.isEditingName { nameEditor }
        }
    }

    // MARK: - Profile Header
    private var profileHeader: some View {
        HStack(spacing: 16) {
            profileImage
            profileNameSection
        }
    }

    private var profileImage: some View {
        Image(viewModel.selectedImage ?? "user2")
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.gray.opacity(0.25)))
            .onTapGesture {
                withAnimation { viewModel.presentEditImage() }
            }
    }

    private var profileNameSection: some View {
        VStack(alignment: .leading) {
            Text("Good Day!")
                .font(.largeTitle)
                .foregroundColor(.gray)
                .minimumScaleFactor(0.5)
            Text(viewModel.profileName ?? "Name")
                .font(.title)
        }
    }

    // MARK: - Name Editor
    private var nameEditor: some View {
        VStack {
            TextField("Enter Name...", text: $viewModel.currentName)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).stroke())

            buttonRow(
                cancelAction: viewModel.dismissEdit,
                doneAction: {
                    viewModel.profileName = viewModel.currentName
                    viewModel.dismissEdit()
                }
            )
        }
    }

    // MARK: - Image Editor
    private var imageEditor: some View {
        VStack {
            imageSelectionScrollView
            buttonRow(
                cancelAction: viewModel.dismissEdit,
                doneAction: viewModel.setNewImage
            )
            .padding(.bottom)
        }
    }

    private var imageSelectionScrollView: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(viewModel.images, id: \.self) { image in
                    imageSelectionButton(image: image)
                }
            }
            .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.15)))
        }
    }

    private func imageSelectionButton(image: String) -> some View {
        Button(action: { viewModel.didSelectNewImage(name: image) }) {
            VStack {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                if viewModel.selectedImage == image {
                    Circle()
                        .frame(width: 16, height: 16)
                        .foregroundColor(.primary)
                }
            }
            .padding()
        }
    }

    // MARK: - Edit Buttons
    private var editButtons: some View {
        VStack {
            editNameButton
            editImageButton
        }
        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.15)))
    }

    private var editNameButton: some View {
        FitnessProfileItemButton(title: "Edit name", image: "square.and.pencil") {
            withAnimation { if viewModel.isEditingImage { viewModel.isEditingImage = false } }
            viewModel.currentName = viewModel.profileName ?? ""
            viewModel.presentEditName()
        }
    }

    private var editImageButton: some View {
        FitnessProfileItemButton(title: "Edit Image", image: "square.and.pencil") {
            withAnimation {
                viewModel.presentEditImage()
            }
        }
    }

    // MARK: - Info Buttons
    private var infoButtons: some View {
        VStack {
            FitnessProfileItemButton(title: "Contact Us", image: "envelope") { print("contact") }
            FitnessProfileItemButton(title: "Privacy Policy", image: "doc") { print("privacy") }
            FitnessProfileItemButton(title: "Terms of Service", image: "doc") { print("terms") }
        }
        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.15)))
    }

    // MARK: - Reusable Components
    private func buttonRow(cancelAction: @escaping () -> Void, doneAction: @escaping () -> Void) -> some View {
        HStack {
            cancelButton(action: cancelAction)
            doneButton(action: doneAction)
        }
    }

    private func cancelButton(action: @escaping () -> Void) -> some View {
        Button(action: { withAnimation { action() } }) {
            Text("Cancel")
                .padding()
                .frame(maxWidth: 100)
                .foregroundColor(.red)
                .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
        }
    }

    private func doneButton(action: @escaping () -> Void) -> some View {
        Button(action: { withAnimation { action() } }) {
            Text("Done")
                .padding()
                .frame(maxWidth: 100)
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 10).fill(.black))
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}



