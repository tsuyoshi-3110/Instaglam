//
//  PostData.swift
//  Instagram
//
//  Created by 斉藤　剛 on 2020/07/12.
//  Copyright © 2020 tsuyoshi.saito. All rights reserved.
//

import UIKit
import Firebase

class PostData: NSObject{
    var id: String
    var name: String?
    var caption: String?
    var date: Date?
    var likes: [String] = []
    var isLiked: Bool = false
    
    init(document: QueryDocumentSnapshot){
        self.id = document.documentID
        
        let postDic = document.data()
        
        self.name = postDic["name"] as? String
        
        self.caption = postDic["caption"] as? String
        
        let timestamp = postDic["date"] as? Timestamp
        self.date = timestamp?.dateValue()
        
        if let likes = postDic["likes"] as? [String]{
            self.likes = likes
        }
        if let myid = Auth.auth().currentUser?.uid{
            //likesの配列の中にmyidが含まれているかチェックする事で、自分がいいねを押しているかを判断
            if self.likes.firstIndex(of: myid) != nil{
                //myidがあれば、言い値を押していると認識する。
                self.isLiked = true
            }
        }
        
    }
}
