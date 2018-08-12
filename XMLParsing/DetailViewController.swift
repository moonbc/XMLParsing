//
//  DetailViewController.swift
//  XMLParsing
//
//  Created by 402-07 on 2018. 8. 12..
//  Copyright © 2018년 moonbc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //상위 뷰 컨트롤러부터 데이터를 넘겨받을 변수를 선언
    var book: Book?
    
    @IBOutlet weak var tvSummary: UITextView!
    
    @IBOutlet weak var lblAuthor: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = book?.title
        self.lblAuthor.text = book?.author
        self.tvSummary.text = book?.summary
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
