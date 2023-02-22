import SwiftUI
import ComposableArchitecture
import Common

public struct CharactersView: View {
    var store: StoreOf<CharactersReducer>
    
    public init(store: StoreOf<CharactersReducer>) {
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

public struct CharactersView_Previews: PreviewProvider {
    public static var previews: some View {
        CharactersView(store: Store(
            initialState: CharactersReducer.State(),
            reducer: CharactersReducer())
        )
    }
}
