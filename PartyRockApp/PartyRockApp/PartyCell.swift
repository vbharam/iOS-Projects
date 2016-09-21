//
//  PartyCell.swift
//  PartyRockApp
//
//  Created by Vishal Bharam on 9/20/16.
//  Copyright © 2016 Codecoop. All rights reserved.
//

import UIKit

class PartyCell: UITableViewCell {

    @IBOutlet weak var videoPreviewImage: UIImageView!
    @IBOutlet weak var videoTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateUI(partyRock: PartyRock) {
        videoTitle.text = partyRock.videoTitle
        
        // Image update:
        let url = URL(string: partyRock.imageURL)
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url!)
                DispatchQueue.global().sync {
                    self.videoPreviewImage.image = UIImage(data: data)
                }
            } catch {
                // Handle the error
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
