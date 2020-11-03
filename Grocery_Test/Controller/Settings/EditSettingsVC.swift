//
//  EditSettingsVC.swift
//  Grocery_Test
//
//  Created by Денис Андриевский on 03.11.2020.
//

import UIKit

final class EditSettingsVC: UIViewController, UINavigationControllerDelegate {

    // MARK: - IBOutlets
    @IBOutlet private weak var mainView: EditSettingsView!
    
    // MARK: - Properties
    private var imagePickerController: UIImagePickerController!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.updateUI()
        mainView.delegate = self
        setupImagePickerController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if User.shared.token == nil {
            AlertService.presentYouMustSignUpAlert(self, cancelBlock: { [unowned self] in
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    private func setupImagePickerController() {
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = .photoLibrary
    }
    
    private func presentImagePickerController() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            self.present(imagePickerController, animated: true, completion: nil)
        } else {
            AlertService.presentSimpleOkAlert(self, title: C.oops, message: C.cameraRestrictedMessage)
        }
    }

}
// MARK: - UIImagePickerControllerDelegate
extension EditSettingsVC: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        User.shared.imageData = selectedImage.fixOrientation().pngData()
        mainView.userImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - EditSettingsViewDelegate
extension EditSettingsVC: EditSettingsViewDelegate {
    
    func didCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didPressChangeImageBtn() {
        presentImagePickerController()
    }
    
    func didPressDone(name: String?, surname: String?) {
        if let name = name, name != "" {
            User.shared.name = name
        }
        if let surname = surname, surname != "" {
            User.shared.surname = surname
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
