import SwiftUI
import ComposableArchitecture
import Common
import Series
import Characters

struct AppView: View {
    var store: StoreOf<AppReducer>
    
    init(store: StoreOf<AppReducer>) {
        self.store = store
//        UITabBar.appearance().barTintColor =
//        UIColor(Palette.darkGray)
    }
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            ZStack {
                Palette.red
//                Palette.dark
//                    .ignoresSafeArea()
                tabsView
            }
            .onAppear {
                viewStore.send(.onAppear)
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
                SeriesListView(
                    store: self.store.scope(
                        state: \.series,
                        action: AppReducer.Action.series
                    )
                )
                .tabItem {
                    Label("Series", systemImage: "magazine")
                }
                .tag(AppReducer.TabItem.series.rawValue)

                CharactersView(
                    store: self.store.scope(
                        state: \.characters,
                        action: AppReducer.Action.characters
                    )
                )
                .tabItem {
                    Label("Characters", systemImage: "person.3")
                }
                .tag(AppReducer.TabItem.characters.rawValue)
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

