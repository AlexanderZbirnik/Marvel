import SwiftUI
import ComposableArchitecture
import Common

public struct SeriesView: View {
    var store: StoreOf<CharactersReducer>
    
    public init(store: StoreOf<CharactersReducer>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store) { viewStore in
            Text("Characters")
        }
    }
}

public struct Series_Previews: PreviewProvider {
    public static var previews: some View {
        SeriesView(store: Store(
            initialState: CharactersReducer.State(),
            reducer: CharactersReducer())
        )
    }
}
