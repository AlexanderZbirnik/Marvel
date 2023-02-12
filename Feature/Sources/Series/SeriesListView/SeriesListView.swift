import SwiftUI
import ComposableArchitecture
import Common

public struct SeriesListView: View {
    var store: StoreOf<SeriesListReducer>
    
    public init(store: StoreOf<SeriesListReducer>) {
        self.store = store
        
    }
    
    public var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                ZStack {
                    Palette.darkGray
                        .ignoresSafeArea()
                    if viewStore.seriesItems.isEmpty {
                        DotsActivityView(color: Palette.red)
                    } else {
                        listView
                    }
                }
                .navigationTitle("Series")
                .onAppear {
                    viewStore.send(.onAppear)
                }
            }            
        }
    }
    
    var listView: some View {
        WithViewStore(self.store) { viewStore in
            List {
                Section {
                    ForEachStore(
                        self.store.scope(
                            state: \.seriesItems,
                            action: {
                                .seriesItem(id: $0, action: $1)
                            }))
                    { store in
                        SeriesItemView(store: store)
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

public struct SeriesListView_Previews: PreviewProvider {
    public static var previews: some View {
        SeriesListView(store: Store(
            initialState: SeriesListReducer.State(),
            reducer: SeriesListReducer())
        )
    }
}
