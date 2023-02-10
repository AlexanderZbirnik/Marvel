import SwiftUI
import ComposableArchitecture
import Common

public struct SeriesItemView: View {
    var store: StoreOf<SeriesItemReducer>
    
    public init(store: StoreOf<SeriesItemReducer>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store) { viewStore in
            Text(viewStore.title)
                .foregroundColor(Palette.red)
                .fontWeight(.medium)
        }
    }
}

public struct SeriesItemView_Previews: PreviewProvider {
    public static var previews: some View {
        SeriesItemView(store: Store(
            initialState: SeriesItemReducer.State(),
            reducer: SeriesItemReducer())
        )
    }
}
