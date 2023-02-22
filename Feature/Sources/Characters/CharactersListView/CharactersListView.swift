import SwiftUI
import ComposableArchitecture
import Common

public struct CharactersListView: View {
    var store: StoreOf<CharactersListReducer>
    
    public init(store: StoreOf<CharactersListReducer>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store) { viewStore in
            Text("Characters")
                .onAppear {
                    viewStore.send(.onAppear)
                }
        }
    }
}

public struct CharactersListView_Previews: PreviewProvider {
    public static var previews: some View {
        CharactersListView(store: Store(
            initialState: CharactersListReducer.State(),
            reducer: CharactersListReducer())
        )
    }
}
