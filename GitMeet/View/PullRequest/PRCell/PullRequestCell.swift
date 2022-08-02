//
//  PullRequestCell.swift
//  GitMeet
//
//  Created by Shashank Pali on 02/08/22.
//

import UIKit

class PullRequestCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusImg: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var closedAtLabel: UILabel!
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(model: Request) {
        titleLabel.text = model.title
        closedAtLabel.text = model.closedAt?.convertDateFormat()
        
        let placeholderImg = UIImage(systemName: "person.circle.fill") ?? UIImage()
        profileImg.imageFromServerURL(urlString: model.user.avatarURL ?? "", placeholderImage: placeholderImg)
        userLabel.text = model.user.login
        createdAtLabel.text = model.createdAt.convertDateFormat()
    }
    
}
