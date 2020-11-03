//
//  ImageViewController.swift
//  Cassini
//
//  Created by 김준환 on 2020/10/29.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    var imageURL: URL? {
        didSet {
            image = nil
            if view.window != nil { // View가 화면에 나타나면, window가 생긴다.
                fetchImage()
            }
        }
    }
     
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size  // scrollView는 outlet이므로 prepare(seuge)시 nil
            spinner?.stopAnimating()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if imageView.image == nil {
            fetchImage()
        }
    }
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    @IBOutlet var scrollView: UIScrollView! {
        didSet {
            scrollView.minimumZoomScale = 1/25
            scrollView.maximumZoomScale = 1.0
            scrollView.delegate = self
            scrollView.addSubview(imageView)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    var imageView = UIImageView()
    
    private func fetchImage() {
        if let url = imageURL {
            spinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                // 이 클로저가 self를 참조하지만, self는 이 클로저를 참조하지 않으므로 메모리 싸이클은 발생하지 않음
                // 하지만 아래 코드가 실행하는데 오래걸리면 뷰 컨트롤러가 더이상 존재해야하지 않을 때(back 버튼을 눌렀을 때) 클로저가 self를 강한참조 하므로 뷰 컨트롤러가 힙에 존재할 수 있다.
                let urlContents = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let imageData = urlContents, url == self?.imageURL { // 이미지를 fetch하는 중 url이 바뀔 수 있으므로 최종적으로 이미지를 띄우기 전에 url을 확인해야한다.
                        self?.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if imageURL == nil {
//            imageURL = DemoURLs.stanford
//        }
    }
}
