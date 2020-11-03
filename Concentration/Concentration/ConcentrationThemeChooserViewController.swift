//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by 김준환 on 2020/10/20.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {
//    override var vclLoggingName: String {
//        return "ThemeChooser"
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil {
                // true to indicate that you do not want the split view controller to do anything with the secondary view controller.
                //
                return true
            }
        }
        // false to let the split view controller try to incorporate the secondary view controller’s content into the collapsed interface
        return false
    }

    let themes = [
        "Sports": "⚽️🏀🏈⚾️🎾🏐🏉🎱🏓⛷🎳⛳️",
        "Animals": "🐶🦆🐹🐸🐘🦍🐓🐩🐦🦋🐙🐏",
        "Faces": "😀😌😎🤓😠😤😭😰😱😳😜😇"
    ]
    
    @IBAction func changeTheme(_ sender: Any) {
//        if let cvc = splitViewDetailConcentrationViewController {
//            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
//                cvc.theme = theme
//            }
//        } else if let cvc = lastSeguedToConcentrationViewController {
//            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
//                cvc.theme = theme
//            }
//            navigationController?.pushViewController(cvc, animated: true)
//        }
//        else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
//        }
    }
    
    private var splitViewDetailConcentrationViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    // MARK: - Navigation
    private var lastSeguedToConcentrationViewController: ConcentrationViewController?
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                    lastSeguedToConcentrationViewController = cvc
                }
            }
        }
    }
}
