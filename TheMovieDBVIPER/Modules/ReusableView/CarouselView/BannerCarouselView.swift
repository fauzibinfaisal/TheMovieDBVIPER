//
//  BannerCarouselView.swift
//  TheMovieDBVIPER
//
//  Created by Gop-c2s2-f on 03/04/23.
//

import Foundation
import UIKit

class BannerCarouselView: UIView {
    
    // MARK: Properties
    private var bannerImageViews: [UIImageView] = []
    private var pageControl: UIPageControl!
    
    private var autoSlideTimer: Timer?
    var autoSlideInterval: TimeInterval = 5
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        startAutoSlide()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        startAutoSlide()
    }
    
    // MARK: Public method
    func setImages(_ images: [UIImage]) {
        bannerImageViews.forEach { $0.removeFromSuperview() }
        bannerImageViews = images.map { image in
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 10
            imageView.layer.masksToBounds = true
            return imageView
        }
        
        let scrollView = subviews.first as! UIScrollView
        scrollView.contentSize = CGSize(width: CGFloat(images.count) * frame.width, height: frame.height)
        for (index, imageView) in bannerImageViews.enumerated() {
            let x = CGFloat(index) * frame.width
            imageView.frame = CGRect(x: x, y: 0, width: frame.width - 40, height: frame.height)
            scrollView.addSubview(imageView)
        }
        
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
    }
    
    private func setupViews() {
        let scrollView = UIScrollView(frame: bounds)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        addSubview(scrollView)
        
        pageControl = UIPageControl(frame: CGRect(x: 0, y: bounds.height - 30, width: bounds.width, height: 30))
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        addSubview(pageControl)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let scrollView = subviews.first as! UIScrollView
        scrollView.frame = bounds
        scrollView.contentSize = CGSize(width: CGFloat(bannerImageViews.count) * bounds.width, height: bounds.height)
        
        for (index, imageView) in bannerImageViews.enumerated() {
            let x = CGFloat(index) * bounds.width
            imageView.frame = CGRect(x: x, y: 0, width: bounds.width, height: bounds.height)
        }
        
        pageControl.frame = CGRect(x: 0, y: bounds.height - 30, width: bounds.width, height: 30)
    }
    
    deinit {
        stopAutoSlide()
    }
    
    private func startAutoSlide() {
        stopAutoSlide()
        autoSlideTimer = Timer.scheduledTimer(withTimeInterval: autoSlideInterval, repeats: true, block: { [weak self] (_) in
            self?.slideToNextItem()
        })
    }
    
    private func stopAutoSlide() {
        autoSlideTimer?.invalidate()
        autoSlideTimer = nil
    }
    
    private func slideToNextItem() {
        let scrollView = subviews.first as! UIScrollView
        let currentOffset = scrollView.contentOffset.x
        let targetOffset = currentOffset + scrollView.bounds.width
        
        if targetOffset == scrollView.contentSize.width {
            // We've reached the end of the content, so loop back to the beginning
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        } else {
            scrollView.setContentOffset(CGPoint(x: targetOffset, y: 0), animated: true)
        }
    }
}

// MARK: UIScrollViewDelegate
extension BannerCarouselView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = pageIndex
    }
}
