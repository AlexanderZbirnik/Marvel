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
            VStack {
                ScrollView {
                    VStack(spacing: 4.0) {
                        ForEachStore(
                            self.store.scope(
                                state: \.seriesItems,
                                action: {
                                    .seriesItem(id: $0, action: $1)
                                }))
                        { store in
                            SeriesItemView(store: store)
                        }
                    }
                }
            }
            .onAppear{
                viewStore.send(.onAppear)
            }
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
