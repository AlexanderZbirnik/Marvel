import SwiftUI
import ComposableArchitecture
import Common
import Series
import Characters
import Comics

extension AppView {
    struct ViewState: Equatable {
        var tab: AppReducer.TabItem
        let series: SeriesListReducer.State
        let characters: CharactersListReducer.State
        let comics: ComicsListReducer.State
        let showLaunch: Bool
        
        init(state: AppReducer.State) {
            self.tab = state.tab
            self.series = state.series
            self.characters = state.characters
            self.comics = state.comics
            self.showLaunch = state.showLaunch
        }
    }
}

struct AppView: View {
    var store: StoreOf<AppReducer>
    
    init(store: StoreOf<AppReducer>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(self.store, observe: ViewState.init) { viewStore in
            ZStack {
                Palette.darkGray
                    .ignoresSafeArea()
                tabsView(viewStore)
                if viewStore.showLaunch {
                    LaunchView()
                        .ignoresSafeArea()
                }
            }
            .onAppear {
                viewStore.send(.onAppear)
                viewStore.send(.onAppearLaunch)
            }
        }
    }
    
    @ViewBuilder
    func tabsView(_ viewStore: ViewStore<AppView.ViewState, AppReducer.Action>) -> some View {
        TabView(
            selection: viewStore.binding(
                get: \.tab.rawValue,
                send: { rawValue in
                    AppReducer.Action.tabSelected(
                        AppReducer.TabItem(rawValue: rawValue) ?? .series
                    )
                }
            )
        ) {
            ComicsListView(
                store: self.store.scope(
                    state: \.comics,
                    action: AppReducer.Action.comics
                )
            )
            .tabItem {
                Label("Comics", systemImage: "magazine")
            }
            .tag(AppReducer.TabItem.comics.rawValue)
            
            CharactersListView(
                store: self.store.scope(
                    state: \.characters,
                    action: AppReducer.Action.characters
                )
            )
            .tabItem {
                Label("Characters", systemImage: "person.3")
            }
            .tag(AppReducer.TabItem.characters.rawValue)
            
            SeriesListView(
                store: self.store.scope(
                    state: \.series,
                    action: AppReducer.Action.series
                )
            )
            .tabItem {
                Label("Series", systemImage: "books.vertical")
            }
            .tag(AppReducer.TabItem.series.rawValue)
        }
        .accentColor(Palette.red)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(store: Store(initialState: AppReducer.State(),
                             reducer: AppReducer()))
    }
}

