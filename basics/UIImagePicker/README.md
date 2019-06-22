# UIImagePicker

## Basics

```swift
class CreateCompanyController: UIViewController {

    // important! target self = nil until we load entire VC
    lazy var companyImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "select_photo_empty"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectPhoto)))

        return imageView
    }()
    
    
    @objc func handleSelectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true

        present(imagePickerController, animated: true, completion: nil)
    }
}

// MARK: - UIImagePickerControllerDelegate

extension CreateCompanyController: UIImagePickerControllerDelegate {

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let edittedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        guard let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        companyImageView.image = edittedImage

        dismiss(animated: true, completion: nil)
    }

}
```

![UIImagePicker](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIImagePicker/images/demo.gif)
