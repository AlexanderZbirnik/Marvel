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
                        HStack {
                            Spacer()
                            Text(viewStore.copyright)
                            Spacer()
                        }
                    }
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: .zero))
            }
            .background(Palette.darkGray)
            .listStyle(.plain)
            .scrollIndicators(.hidden)
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
