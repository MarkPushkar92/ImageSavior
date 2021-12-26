//
//  TableViewCell.swift
//  ImageSavior
//
//  Created by Марк Пушкарь on 03.12.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    lazy var photo: UIImageView = {
        let photo = UIImageView()
        photo.clipsToBounds = true
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.layer.cornerRadius = 6
        return photo
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        contentView.addSubview(photo)
        
        let constraints = [
            photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photo.topAnchor.constraint(equalTo: contentView.topAnchor),
            photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ]
        NSLayoutConstraint.activate(constraints)
        
        
    }

}
