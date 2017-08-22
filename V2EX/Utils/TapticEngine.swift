//
//  TapticEngine.swift
//  V2EX
//
//  Created by Kyle on 22/8/17.
//  Copyright © 2017年 com.Kyle. All rights reserved.
//

import UIKit

open class TapticEngine {
    
    public static let impact: Impact = Impact()
    public static let selection: Selection = Selection()
    public static let notification: Notification = Notification()
    public static var isEnable = true
    
    /// Wrapper of `UIImpactFeedbackGenerator`
    open class Impact: TapticEngineResponseable {
        
        /// Impact feedback styles
        ///
        /// - light: A impact feedback between small, light user interface elements.
        /// - medium: A impact feedback between moderately sized user interface elements.
        /// - heavy: A impact feedback between large, heavy user interface elements.
        public enum ImpactStyle {
            case light, medium, heavy
        }
        
        private var style: ImpactStyle = .light
        private var generator: Any? = Impact.makeGenerator(.light)
        
        private static func makeGenerator(_ style: ImpactStyle) -> Any? {
            guard #available(iOS 10.0, *) else { return nil }
            
            let feedbackStyle: UIImpactFeedbackStyle
            switch style {
            case .light:
                feedbackStyle = .light
            case .medium:
                feedbackStyle = .medium
            case .heavy:
                feedbackStyle = .heavy
            }
            let generator: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: feedbackStyle)
            generator.prepare()
            return generator
        }
        
        private func updateGeneratorIfNeeded(_ style: ImpactStyle) {
            guard self.style != style else { return }
            
            generator = Impact.makeGenerator(style)
            self.style = style
        }
        
        public func feedback(_ style: ImpactStyle) {
            guard #available(iOS 10.0, *), self.canResponse else { return }
            
            updateGeneratorIfNeeded(style)
            
            guard let generator = generator as? UIImpactFeedbackGenerator else { return }
            
            generator.impactOccurred()
            generator.prepare()
        }
        
        public func prepare(_ style: ImpactStyle) {
            guard #available(iOS 10.0, *) else { return }
            
            updateGeneratorIfNeeded(style)
            
            guard let generator = generator as? UIImpactFeedbackGenerator else { return }
            
            generator.prepare()
        }
    }
    
    
    /// Wrapper of `UISelectionFeedbackGenerator`
    open class Selection: TapticEngineResponseable {
        
        private var generator: Any? = {
            guard #available(iOS 10.0, *) else { return nil }
            
            let generator: UISelectionFeedbackGenerator = UISelectionFeedbackGenerator()
            generator.prepare()
            return generator
        }()
        
        public func feedback() {
            guard #available(iOS 10.0, *), self.canResponse else { return }
            guard let generator = generator as? UISelectionFeedbackGenerator else { return }
            
            generator.selectionChanged()
            generator.prepare()
        }
        
        public func prepare() {
            guard #available(iOS 10.0, *) else { return }
            guard let generator = generator as? UISelectionFeedbackGenerator else { return }
            
            generator.prepare()
        }
    }
    
    
    /// Wrapper of `UINotificationFeedbackGenerator`
    open class Notification: TapticEngineResponseable {
        
        /// Notification feedback types
        ///
        /// - success: A notification feedback, indicating that a task has completed successfully.
        /// - warning: A notification feedback, indicating that a task has produced a warning.
        /// - error: A notification feedback, indicating that a task has failed.
        public enum NotificationType {
            case success, warning, error
        }
        
        private var generator: Any? = {
            guard #available(iOS 10.0, *) else { return nil }
            
            let generator: UINotificationFeedbackGenerator = UINotificationFeedbackGenerator()
            generator.prepare()
            return generator
        }()
        
        public func feedback(_ type: NotificationType) {
            guard #available(iOS 10.0, *), self.canResponse else { return }
            guard let generator = generator as? UINotificationFeedbackGenerator else { return }
            
            let feedbackType: UINotificationFeedbackType
            switch type {
            case .success:
                feedbackType = .success
            case .warning:
                feedbackType = .warning
            case .error:
                feedbackType = .error
            }
            generator.notificationOccurred(feedbackType)
            generator.prepare()
        }
        
        public func prepare() {
            guard #available(iOS 10.0, *) else { return }
            guard let generator = generator as? UINotificationFeedbackGenerator else { return }
            
            generator.prepare()
        }
    }
}

protocol TapticEngineResponseable {
    var canResponse: Bool { get }
}

extension TapticEngineResponseable {
    
    var canResponse: Bool {
        return TapticEngine.isEnable
    }
    
}