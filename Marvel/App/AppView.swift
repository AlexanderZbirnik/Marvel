import SwiftUI
import ComposableArchitecture
import Common
import Series
import Characters
import Comics

struct AppView: View {
    var store: StoreOf<AppReducer>
    
    init(store: StoreOf<AppReducer>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            ZStack {
                Palette.darkGray
                    .ignoresSafeArea()
                tabsView
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
    var tabsView: some View {
        WithViewStore(self.store) { viewStore in
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
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(store: Store(initialState: AppReducer.State(),
                             reducer: AppReducer()))
    }
}

