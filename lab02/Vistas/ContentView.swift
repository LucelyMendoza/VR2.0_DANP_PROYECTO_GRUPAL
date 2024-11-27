import SwiftUI

struct ContentView: View {
    @Binding var isLoggedin: Bool
    @State private var selectedTab = 0
    @State private var paintings: [Painting] = []
    private let paintingService = PaintingsService()
//Yoset*1998
    var body: some View {
        ZStack {
            Color(red: 247/255, green: 236/255, blue: 216/255, opacity: 1)
                .ignoresSafeArea()

            TabView(selection: $selectedTab) {
                // Home Tab (con lista de pinturas)
                NavigationView {
                    List(paintings) { paint in
                        NavigationLink(destination: PaintingDetailView(painting: paint)) {
                            HStack {
                                AsyncImage(url: URL(string: paint.image)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                } placeholder: {
                                    ProgressView()
                                }
                                VStack(alignment: .leading) {
                                    Text("\(paint.painting) by \(paint.artist)")
                                        .font(.headline)
                                    Text("\(paint.dateOfSale)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    .navigationTitle("Paintings")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Logout") {
                                isLoggedin = false
                            }
                            .foregroundColor(.blue)
                        }
                    }
                    .onAppear {
                        fetchPaintings()
                    }
                }
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)

                // Pinturas Tab
                NavigationView {
                    PinturasView()
                }
                .tabItem {
                    Label("Busqueda", systemImage: "magnifyingglass")
                }
                .tag(1)

                // QR Tab
                NavigationView {
                    QRView()
                }
                .tabItem {
                    Label("QR", systemImage: "qrcode")
                }
                .tag(2)

                // Mapa Tab
                NavigationView {
                    MapaView()
                }
                .tabItem {
                    Label("Mapa", systemImage: "map.fill")
                }
                .tag(3)
            }
            .accentColor(Color(red: 132/255, green: 3/255, blue: 12/255, opacity: 1)) // Color del ícono seleccionado
            .onAppear {
                // Cambiar el color de los íconos no seleccionados
                UITabBar.appearance().unselectedItemTintColor = UIColor(red: 209/255, green: 170/255, blue: 101/255, alpha: 1)
            }
        }
    }

    private func fetchPaintings() {
        paintingService.fetchPaintings { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let paintingResponse):
                    self.paintings = paintingResponse.data
                case .failure(let error):
                    print("Error fetching paintings: \(error)")
                }
            }
        }
    }
}
