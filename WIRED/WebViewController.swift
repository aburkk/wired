


import UIKit
import WebKit
class WebViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
   // var url: String?
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let url:String = "https://www.wired.com/review/amazon-kindle-2019/"
        let myURL = URL(string: url)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }}


//import UIKit
//import WebKit
//
//class WebViewController: UIViewController {
//
//
//
//    @IBOutlet weak var webView: WKWebView!
//
//    var url: String?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//
//      webView.backgroundColor = UIColor.green
//        let url = URL(string: self.url!)
//        webView.load(URLRequest(url: url!))
//
//        //webView.load(URLRequest(url: URL(string:url!)!))
//        // Do any additional setup after loading the view.
//    }
//
//
//}
