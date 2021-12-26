//
//  ContentsViewController.swift
//  ImageSavior
//
//  Created by Марк Пушкарь on 03.12.2021.
//

import UIKit

class ContentsViewController: UIViewController {
    
    var contents: [URL] = {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let directoryContents = try! FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil)
        return directoryContents
    }()
    
    public var currentSettingsViewSetup : SettingsViewSetup?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.toAutoLayout()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellID)
        return tableView
    }()
    
    private let cellID = "cellID"
    
    @objc func callImagePicker() {
        print("hop hey")
        showImagePickerController(sourceType: .photoLibrary)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setupViews()
        let button1 = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(callImagePicker))
        self.navigationItem.rightBarButtonItem  = button1
        tableView.reloadData()
     
    }
    
    private func sortFolderUrls() {
        if let setup = self.currentSettingsViewSetup {
            if setup.isSortingEnabled {
                contents.sort {
                    let compareResult = $0.absoluteString.compare($1.absoluteString, options: .numeric)
                    if setup.isAscendingMode {
                        return compareResult == .orderedAscending
                    } else {
                        return compareResult == .orderedDescending
                    }
                }
            }
        }
    }
    
    public func applySettingsViewSetup(setup : SettingsViewSetup?) {
        self.currentSettingsViewSetup = setup
        self.sortFolderUrls()
        tableView.reloadData()
    }
}

//MARK: extensions IMAGE PICKER

extension ContentsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        let data = image.pngData()
        let imageURL = info[UIImagePickerController.InfoKey.imageURL] as! URL
        let imageName = imageURL.lastPathComponent

        do {
            let documentsUrl = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let filePath = documentsUrl.appendingPathComponent("PICTURE NAME: \(String(describing: imageName))")
            try FileManager.default.createFile(atPath: filePath.path, contents: data, attributes: nil)
            contents.append(filePath)
        } catch {
            print("Error, failed to save image")
        }
        
        tableView.reloadData()
        picker.dismiss(animated: true, completion: nil)
    }
}

//MARK: extensions table view

extension ContentsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TableViewCell
        let path = contents[indexPath.row].path
        cell.photo.image = UIImage(contentsOfFile: path)
        return cell

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension ContentsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
}

//MARK: extensions Layout

extension UIView {
    func toAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

private extension ContentsViewController {

    func setupViews() {

        view.addSubview(tableView)
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}



