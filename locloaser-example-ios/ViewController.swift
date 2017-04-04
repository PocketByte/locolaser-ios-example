/*
 * Copyright © 2017 Denis Shurygin. All rights reserved.
 * Licensed under the Apache License, Version 2.0
 */

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var labelPlural1 : UILabel!
    @IBOutlet var labelPlural2 : UILabel!
    @IBOutlet var labelPlural3 : UILabel!
    @IBOutlet var labelPlural4 : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.labelPlural1.text = String.localizedStringWithFormat(Str.screen_main_plural_string, 25)
        self.labelPlural2.text = String.localizedStringWithFormat(Str.screen_main_plural_string, 1)
        self.labelPlural3.text = String.localizedStringWithFormat(Str.screen_main_plural_string, 0)
        self.labelPlural4.text = String.localizedStringWithFormat(Str.screen_main_plural_string, 32)
        
    }
}

