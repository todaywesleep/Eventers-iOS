import SwiftUI

// MARK: ViewModel
public class TabNavigationStack: ObservableObject {
    /// Customizable easing to apply in pop and push transitions
//    static var globalTransaction = false {
//        didSet {
//            NotificationCenter.default.post(
//                name: .globalTransactionChanged,
//                object: globalTransaction,
//                userInfo: nil
//            )
//        }
//    }
    
    var count: Int {
        viewStack.count
    }
    
    @Published var currentView: ViewElement?
    private var viewStack = ViewStack()
    
    init(by viewElements: [ViewElement], activeItem: Int = 0) {
        viewElements.forEach { viewStack.push($0) }
        
        currentView = viewStack.getView(by: activeItem)
//        NotificationCenter.default.addObserver(
//            forName: .globalTransactionChanged,
//            object: nil,
//            queue: nil) { notification in
//                self.isTransactionInProgress = notification.object as! Bool
//        }
    }
    
    func select(viewIndex: Int) {
        guard let viewElement = viewStack.getView(by: viewIndex) else { return }
        currentView = viewElement
    }
}

 struct TabNavigationView: View {
    private enum Direction: Int {
        case left = -1
        case right = 1
    }
    
    @ObservedObject private var navViewModel: TabNavigationStack
    // Threshold of swipe == 10% of screen size
    private static let swipeThreshold = UIScreen.main.bounds.size.width * 0.1
    private var startedSwipeAnination = false

    init(views: [AnyView], stack: inout TabNavigationStack, activeItem: Int = 0) {
        var viewElements = [ViewElement]()
        
        for index in 0..<views.count {
            viewElements.append(
                ViewElement(
                    id: index.description,
                    wrappedElement: views[index]
                )
            )
        }
        
        self.navViewModel = .init(by: viewElements, activeItem: activeItem)
        stack = self.navViewModel
    }

     var body: some View {
        print("[Test] Current id: \(navViewModel.currentView!.id)")
        
        return navViewModel.currentView!.wrappedElement
            .id(navViewModel.currentView!.id)
            .environmentObject(navViewModel)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        if abs(abs(gesture.startLocation.x) - abs(gesture.location.x)) > TabNavigationView.swipeThreshold && !self.startedSwipeAnination {
                            let direction: Direction = gesture.startLocation.x - gesture.location.x < 0 ? .left : .right
                            
                            let index = (Int(self.navViewModel.currentView?.id ?? "") ?? Int.min) + direction.rawValue
                            guard index > -1, index < self.navViewModel.count else { return }
                            
                            self.navViewModel.select(viewIndex: index)
                        }
                    }
            )
    }
}
