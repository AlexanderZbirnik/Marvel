import SwiftUI
import ComposableArchitecture
import Common

extension CharactersListView {
    struct ViewState: Equatable {
        let charactersItems: IdentifiedArrayOf<CharacterItemReducer.State>
        let copyright: AttributedString
        let showFooter: Bool
        
        init(state: CharactersListReducer.State) {
            self.charactersItems = state.charactersItems
            self.copyright = state.copyright
            self.showFooter = state.showFooter
        }
    }
}

public struct CharactersListView: View {
    let store: StoreOf<CharactersListReducer>
    
    public init(store: StoreOf<CharactersListReducer>) {
        self.store = store
        
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: ViewState.init) { viewStore in
            NavigationStack {
                ZStack {
                    Palette.darkGray
                        .ignoresSafeArea()
                    if viewStore.charactersItems.isEmpty {
                        DotsActivityView(color: Palette.red)
                    } else {
                        listView
                    }
                }
                .navigationTitle("Characters")
                .onAppear {
                    viewStore.send(.onAppear)
                }
            }
        }
    }
    
    var listView: some View {
        WithViewStore(self.store, observe: ViewState.init) { viewStore in
            List {
                Section {
                    ForEachStore(
                        self.store.scope(
                            state: \.charactersItems,
                            action: {
                                .characterItem(id: $0, action: $1)
                            }))
                    { store in
                        CharacterItemView(store: store)
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

public struct CharactersListView_Previews: PreviewProvider {
    public static var previews: some View {
        CharactersListView(store: Store(
            initialState: CharactersListReducer.State(),
            reducer: CharactersListReducer())
        )
    }
}
