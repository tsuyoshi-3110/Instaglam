//
//  commentViewController.swift
//  Instagram
//
//  Created by 斉藤　剛 on 2020/07/26.
//  Copyright © 2020 tsuyoshi.saito. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class commentViewController: UIViewController {
    
    @IBOutlet weak var commentTextField: UITextField!
    
    //　HomeViewcontrollerで求めたセルのインデックスを受け取る変数
    var postData:PostData?
     

    @IBAction func postCommentButton(_ sender: Any) {
        if let comment = commentTextField.text{
            if comment.isEmpty{
                SVProgressHUD.showError(withStatus: "コメントを入力してください")
                return
            }
            
            //HUDで処理中を表示
            SVProgressHUD.show()
            
            let name = Auth.auth().currentUser?.displayName
            
            print("##############\(name!)")
            

            
            var updateValue: FieldValue
            
            updateValue = FieldValue.arrayUnion([name! + ":" + "\(commentTextField.text!)\n"])
            
            let postRef = Firestore.firestore().collection(Const.PostPath).document(postData!.id)
            postRef.updateData(["comment": updateValue])
            
            
            
            //HUDで投稿完了を表示する
            SVProgressHUD.showSuccess(withStatus: "投稿しました")
            
            // 画面を閉じてHomeView画面に戻る
            self.dismiss(animated: true, completion: nil)            }
        
    }
    @IBAction func cancelButton(_ sender: Any) {
        // 画面を閉じてHomeView画面に戻る
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
