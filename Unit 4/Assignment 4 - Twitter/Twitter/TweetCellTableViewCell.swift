//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Cameron Sherry on 4/19/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBAction func favoriteTweetAction(_ sender: Any) {
        let isFavorited = !favorited
        if isFavorited {
            TwitterAPICaller.client?.favoriteTweet(tweetID: tweetID, success: {
                self.setFavorite(true)
            }, failure: { (Error) in
                print("Favorite tweet did not succeed: ", Error)
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetID: tweetID, success: {
                self.setFavorite(false)
            }, failure: { (Error) in
                print("Unfavorite tweet did not succeed: ", Error)
            })
        }
    }
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBAction func retweetButtonAction(_ sender: Any) {
    }
    
    var favorited: Bool = false
    var tweetID: Int = -1
    
    func setFavorite(_ isFavorited: Bool) {
        favorited = isFavorited
        if favorited {
            favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        } else {
            favoriteButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
