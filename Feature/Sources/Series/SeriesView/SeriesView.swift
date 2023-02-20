import SwiftUI
import ComposableArchitecture
import Common
import MarvelService

public struct SeriesView: View {
    var store: StoreOf<SeriesReducer>
    
    public init(store: StoreOf<SeriesReducer>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store) { viewStore in
            ZStack {
                Palette.darkGray
                    .ignoresSafeArea()
                ScrollView(.vertical) {
                    imageView
                    if !viewStore.detail.isEmpty {
                        detailView
                    }
                    if let characters = viewStore.characters {
                        charactersView(characters)
                    }
                    if let creators = viewStore.creators {
                        creatorsView(creators)
                    }
                    Spacer()
                }
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
            .navigationTitle(viewStore.title)
        }
    }
    
    var imageView: some View {
        WithViewStore(self.store) { viewStore in
            AsyncImage(url: viewStore.imageUrl) { image in
                image
                    .resizable()
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
            }
            .aspectRatio(
                CGSize(width: 300.0,height: 450.0),
                contentMode: .fit)
            .cornerRadius(8.0)
            .shadow(color: Palette.red, radius: 8.0)
            .padding([.leading, .trailing], 64.0)
            .padding([.top, .bottom], 16.0)
        }
    }
    
    var detailView: some View {
        WithViewStore(self.store) { viewStore in
            Text(viewStore.detail)
                .font(.body)
                .foregroundColor(Palette.white)
                .padding([.leading, .trailing], 16.0)
                .padding([.top], 24.0)
        }
    }
    
    func charactersView(_ characters: SeriesCharactersList) -> some View {
        VStack(spacing: .zero) {
            HStack {
                Text(characters.name)
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(Palette.gray)
                    .padding([.leading, .trailing], 16.0)
                    .padding(.top, 8.0)
                Spacer()
            }
            HStack {
                Text(characters.list)
                    .font(.headline)
                    .fontWeight(.regular)
                    .italic()
                    .foregroundColor(Palette.white)
                    .padding([.leading, .trailing], 16.0)
                    .padding(.top, 4.0)
                Spacer()
            }
        }
    }
    
    func creatorsView(_ creators: SeriesCreatorsList) -> some View {
        VStack(spacing: .zero) {
            HStack {
                Text(creators.name)
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(Palette.gray)
                    .padding([.leading, .trailing], 16.0)
                    .padding(.top, 4.0)
                Spacer()
            }
            ForEach(creators.list, id: \.self) { role in
                HStack {
                    Text(role.title + ":")
                        .font(.title3)
                        .fontWeight(.regular)
                        .foregroundColor(Palette.gray)
                        .padding([.leading, .trailing], 16.0)
                        .padding(.top, 8.0)
                    Spacer()
                }
                HStack {
                    Text(role.names)
                        .font(.headline)
                        .fontWeight(.regular)
                        .italic()
                        .foregroundColor(Palette.white)
                        .padding([.leading, .trailing], 16.0)
                        .padding(.top, 4.0)
                    Spacer()
                }
            }
        }
    }
}

public struct SeriesView_Previews: PreviewProvider {
    public static var previews: some View {
        ZStack {
            Color.gray
            NavigationStack {
                SeriesView(store: Store(
                    initialState: SeriesReducer.State(.mock),
                    reducer: SeriesReducer())
                )
            }
        }
    }
}
