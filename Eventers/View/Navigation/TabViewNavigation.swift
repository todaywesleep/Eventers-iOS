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
    
//    @Published var isTransactionInProgress: Bool = globalTransaction
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
        print("[TEST] Current selected = \(currentView?.id)")
    }
    
    private func lockNestedContent() {
//        if !NavigationStack.globalTransaction {
//            NavigationStack.globalTransaction = true
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
//                NavigationStack.globalTransaction = false
//            }
//        }
    }
}

 struct TabNavigationView: View {
    @ObservedObject private var navViewModel: TabNavigationStack

    init(views: [AnyView], stack: inout TabNavigationStack, activeItem: Int = 0) {
        var viewElements = [ViewElement]()
        
        for index in 0..<views.count {
            viewElements.append(ViewElement(id: index.description, wrappedElement: views[index]))
        }
        
        self.navViewModel = .init(by: viewElements, activeItem: activeItem)
        stack = self.navViewModel
    }

     var body: some View {
        print("[Test] Current id: \(navViewModel.currentView!.id)")
        
        return navViewModel.currentView!.wrappedElement
            .id(navViewModel.currentView!.id)
            .environmentObject(navViewModel)
//            .animation(.default)
//            .disabled(navViewModel.isTransactionInProgress)
    }
}
