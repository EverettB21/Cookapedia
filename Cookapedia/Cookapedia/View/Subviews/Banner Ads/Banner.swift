//
//  Banner.swift
//  Golz
//
//  Created by Everett Brothers on 1/19/24.
//

import SwiftUI
import GoogleMobileAds

protocol BannerViewControllerWidthDelegate: AnyObject {
  func bannerViewController(_ bannerViewController: BannerViewController, didUpdate width: CGFloat)
}

struct BannerView: UIViewControllerRepresentable {
    var adID: String
    @State var adWidth: Double
    let bannerView = GADBannerView()
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let bannerController = BannerViewController()
        bannerView.adUnitID = adID
        bannerView.backgroundColor = UIColor.darkGray
        bannerView.rootViewController = bannerController
        bannerController.view.addSubview(bannerView)
        
        return bannerController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        guard adWidth != 0 else { return }
        
        bannerView.adSize = GADAdSizeFromCGSize(CGSize(width: adWidth, height: 50))
        bannerView.load(GADRequest())
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, BannerViewControllerWidthDelegate {
        let parent: BannerView
        
        init(_ parent: BannerView) {
            self.parent = parent
        }
        
        func bannerViewController(_ bannerViewController: BannerViewController, didUpdate width: CGFloat) {
            parent.adWidth = width
        }
    }
}

class BannerViewController: UIViewController {
  weak var delegate: BannerViewControllerWidthDelegate?

  override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

    // Tell the delegate the initial ad width.
      delegate?.bannerViewController(self, didUpdate: view.frame.size.width)
  }

  override func viewWillTransition(
    to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator
  ) {
    coordinator.animate { _ in
      // do nothing
    } completion: { _ in
      // Notify the delegate of ad width changes.
      self.delegate?.bannerViewController(
        self, didUpdate: self.view.frame.size.width)
    }
  }
}
