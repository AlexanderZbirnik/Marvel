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
            Text("Series")
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
