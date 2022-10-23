//
//  IsometricView.swift
//  UI- 777
//
//  Created by nyannyan0328 on 2022/10/23.
//

import SwiftUI

struct IsometricView<Content : View,Bottom : View,Side : View>: View {
    
    var content : Content
    var bottom : Bottom
    var side : Side
    var depath : CGFloat
    
    init(depath : CGFloat,@ViewBuilder content : @escaping()->Content,@ViewBuilder bottom : @escaping()->Bottom,@ViewBuilder side : @escaping()->Side) {
        self.content = content()
        self.bottom = bottom()
        self.side = side()
        self.depath = depath
    }
    var body: some View {
        Color.clear
            .overlay {
                
                GeometryReader{
                    
                    let size = $0.size
                    
                    ZStack{
                        
                        content
                        
                        bottom
                            .scaleEffect(y:depath,anchor: .bottom)
                            .frame(height: depath,alignment: .bottom)
                            .overlay {
                                Rectangle()
                                    .fill(.black.opacity(0.25))
                                    .blur(radius: 2.5)
                            }
                            .clipped()
                            .projectionEffect(.init(.init(1, 0, 1, 1, 0, 0)))
                            .offset(y:depath)
                          .frame(maxHeight: .infinity,alignment: .bottom)
                        
                        side
                             .scaleEffect(x:depath,anchor: .trailing)
                             .frame(width: depath,alignment: .trailing)
                             .overlay {
                                 Rectangle()
                                     .fill(.black.opacity(0.25))
                                     .blur(radius: 2.5)
                             }
                             .clipped()
                             .projectionEffect(.init(.init(1, 1, 0, 1, 0, 0)))
                             .offset(x:depath)
                         .frame(maxWidth: .infinity,alignment: .trailing)
                        
                    }
                    .frame(width: size.width,height: size.height)
                    
                }
                
            }
    }
}

struct IsometricView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CustomProjection : GeometryEffect{

    
    
    var value : CGFloat
    
    var animatableData: CGFloat{
        
        get{
            
            return value
            
            
        }
        set{
            
            value = newValue
        }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        
        var transform = CATransform3DIdentity
        transform.m11 = (value == 0 ? 0.0001 : value)
        
        return .init(transform)
    }
}
