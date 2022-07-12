
import SwiftUI


struct SaveImageView: View
{
    
    let image = UIImage(named: "cake")!
    
    var body: some View
    {
        VStack {
            Text("Sticky Toffee Cake")
            
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 250, height: 220, alignment: .center)
                .clipped()

            Spacer().frame(height:100)
            
            Button
            {
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            } label: {
                HStack {
                    Image(systemName: "photo.on.rectangle.angled")
                    Text("Add to Photos")
                }
                .font(.title)
                .foregroundColor(.purple)
            }
            Spacer()
        }
    }
}

