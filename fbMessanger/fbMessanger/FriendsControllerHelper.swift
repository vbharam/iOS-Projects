//
//  FriendsControllerHelper.swift
//  fbMessanger
//
//  Created by Vishal Bharam on 12/8/16.
//  Copyright © 2016 Codecoop. All rights reserved.
//

import UIKit


class Message: NSObject {
    var text: String?
    var date: NSDate?
    
    var friend: Friend?
}


class Friend: NSObject {
    var name: String?
    var profileImageName: String?
}



extension FriendsController {
        
    func setupData() {
        let mark = Friend()
        mark.name = "Mark Zuckerberg"
        mark.profileImageName = "zuckprofile"
        
        let message = Message()
        message.friend = mark
        message.text = "Hello, my name is Mark! Nice to meet you"
        message.date = NSDate()
        
        let steve = Friend()
        steve.name = "Steve Jobs"
        steve.profileImageName = "steve_profile"
        
        let messageSteve = Message()
        messageSteve.friend = steve
        messageSteve.text = "Apple creates great iOS devices for the world"
        messageSteve.date = NSDate()
        
        messages = [message, messageSteve]
    }
}
