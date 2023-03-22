import SwiftUI
import ComposableArchitecture
import Common

extension ComicsListView {
    struct ViewState: Equatable {
        let comicsItems: IdentifiedArrayOf<ComicsItemReducer.State>
        let copyright: AttributedString
        let showFooter: Bool
        
        init(state: ComicsListReducer.State) {
            self.comicsItems = state.comicsItems
            self.copyright = state.copyright
            self.showFooter = state.showFooter
        }
    }
}

public struct ComicsListView: View {
    var store: StoreOf<ComicsListReducer>
    
    public init(store: StoreOf<ComicsListReducer>) {
        self.store = store
        
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: ViewState.init) { viewStore in
            NavigationStack {
                ZStack {
                    Palette.darkGray
                        .ignoresSafeArea()
                    if viewStore.comicsItems.isEmpty {
                        DotsActivityView(color: Palette.red)
                    } else {
                        listView()
                    }
                }
                .navigationTitle("Comics")
                .onAppear {
                    viewStore.send(.onAppear)
                }
            }
        }
    }
    
    func listView() -> some View {
        WithViewStore(self.store, observe: ViewState.init) { viewStore in
            List {
                Section {
                    ForEachStore(
                        self.store.scope(
                            state: \.comicsItems,
                            action: {
                                .comicsItem(id: $0, action: $1)
                            }))
                    { store in
                        ComicsItemView(store: store)
                            .frame(height: 88.0)
                    }
                } footer: {
                    ZStack {
                        Palette.darkGray
                        if viewStore.showFooter {
                            ListFooterView(
                                link: viewStore.copyright,
                                color: Palette.red
                            )
                        }
                    }
                    .frame(height: 48.0)
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(.zero))
            }
            .background(Palette.darkGray)
            .listStyle(.plain)
            .scrollIndicators(.hidden)
        }
    }
}

public struct ComicsListView_Previews: PreviewProvider {
    public static var previews: some View {
        ComicsListView(store: Store(
            initialState: ComicsListReducer.State(),
            reducer: ComicsListReducer())
        )
    }
}
