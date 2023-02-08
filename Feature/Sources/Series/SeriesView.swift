import SwiftUI
import ComposableArchitecture
import Common

public struct SeriesView: View {
    var store: StoreOf<SeriesReducer>
    
    public init(store: StoreOf<SeriesReducer>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                Text("series")
                ForEach(viewStore.series, content: { series in
                    Text(series.title ?? "")
                })
            }
            .onAppear{
                viewStore.send(.onAppear)
            }
        }
    }
}

public struct Series_Previews: PreviewProvider {
    public static var previews: some View {
        SeriesView(store: Store(
            initialState: SeriesReducer.State(),
            reducer: SeriesReducer())
        )
    }
}
