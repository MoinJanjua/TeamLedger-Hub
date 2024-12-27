import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var letStartButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize the button with a gradient
        applyGradientToButton(button: letStartButton, colors: [UIColor(hex: "FF6A5A"), UIColor(hex: "FF9B90")])
    }
    
    @IBAction func letStartButtonTapped(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.modalTransitionStyle = .crossDissolve
        self.present(newViewController, animated: true, completion: nil)
    }

    // Apply gradient to the button
    func applyGradientToButton(button: UIButton, colors: [UIColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = button.bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.cornerRadius = button.layer.cornerRadius
        gradientLayer.masksToBounds = true
        
        button.layer.insertSublayer(gradientLayer, at: 0)
        button.setTitleColor(.white, for: .normal) // Ensure text is visible
    }
}

// UIColor Extension for Hex Colors
extension UIColor {
    convenience init(hexs: String) {
        let hexs = hexs.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hexs).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hexs.count {
        case 3: // RGB (12-bit)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (1, 1, 1)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: 1)
    }
}
