//
//  TearmViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/5/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class TearmViewController: BaseViewController {

    
    @IBOutlet weak var content: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.content.text = "Lorem Ipsum chỉ đơn giản là một đoạn văn bản giả, được dùng vào việc trình bày và dàn trang phục vụ cho in ấn. Lorem Ipsum đã được sử dụng như một văn bản chuẩn cho ngành công nghiệp in ấn từ những năm 1500, khi một họa sĩ vô danh ghép nhiều đoạn văn bản với nhau để tạo thành một bản mẫu văn bản.Đoạn văn bản này không những đã tồn tại năm thế kỉ, mà khi được áp dụng vào tin học văn phòng, nội dung của nó vẫn không hề bị thay đổi. Nó đã được phổ biến trong những năm 1960 nhờ việc bán những bản giấy Letraset in những đoạn Lorem Ipsum, và gần đây hơn, được sử dụng trong các ứng dụng dàn trang, như Aldus PageMaker."
    }
    


}
