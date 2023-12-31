import SpriteKit

public enum SIFloatingNodeState {
    case normal
    case selected
    case removing
}

open class SIFloatingNode: SKShapeNode {
    
    private(set) var previousState: SIFloatingNodeState = .normal
    var data: DataItem?
    
    public var onTap: ((String) -> Void)?
    
    public var state: SIFloatingNodeState = .normal {
        didSet {
            if state != oldValue {
                previousState = oldValue
                stateChanged()
            }
        }
    }
    
    private static let removingKey = "action.removing"
    private static let selectingKey = "action.selecting"
    private static let normalizeKey = "action.normalize"
    
    private func stateChanged() {
        var action: SKAction?
        var actionKey: String?
        
        switch state {
        case .normal:
            action = normalizeAnimation()
            actionKey = SIFloatingNode.normalizeKey
        case .selected:
            if let title = data?.title {
                onTap?(title)
            }
            action = selectingAnimation()
            actionKey = SIFloatingNode.selectingKey
        case .removing:
            action = removingAnimation()
            actionKey = SIFloatingNode.removingKey
        }
        
        if let action = action, let actionKey = actionKey {
            removeAction(forKey: actionKey)
            run(action, withKey: actionKey)
        }
    }
    
    override open func removeFromParent() {
        if let action = removeAnimation() {
            run(action) {
                super.removeFromParent()
            }
        } else {
            super.removeFromParent()
        }
    }
    
    // MARK: -
    // MARK: Animations
    open func selectingAnimation() -> SKAction? {return nil}
    open func normalizeAnimation() -> SKAction? {return nil}
    open func removeAnimation() -> SKAction? {return nil}
    open func removingAnimation() -> SKAction? {return nil}
}
