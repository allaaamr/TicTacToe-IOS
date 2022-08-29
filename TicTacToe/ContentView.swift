//
//  ContentView.swift
//  TicTacToe
//
//  Created by Alaa Amr Abdelazeem on 23/08/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var moves = ["","","","","","","","",""]
    @State private var count = 0
    @State private var title = "TicTacOrange"
    @State private var endGameText = ""
    @State private var gameEnded = false
    private var ranges = [(0..<3),(3..<6),(6..<9)]
    
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
         VStack {
             Text(title)
                 .foregroundColor(.orange)
                 .font(.system(size: 30))
                 .alert(endGameText, isPresented: $gameEnded) {
                     Button("Reset", role: .destructive, action: resetGame)
                 }
             Spacer()
             ForEach(ranges, id: \.self) { range in
                 HStack {
                     ForEach(range, id: \.self) { i in
                         XOButton(letter: $moves[i])
                             .simultaneousGesture(
                                 TapGesture()
                                     .onEnded { _ in
                                         print("Tap: \(i)")
                                         playerTap(index: i)
                                     }
                             )
                     }
                 }
             }
             Spacer()
             Button("Reset") {
                 resetGame()
             }
         }
        }
     }
    func resetGame() {
            title = "TicTacOrange"
            moves = ["","","","","","","","",""]
    }
        
    func playerTap(index: Int) {
        count += 1
        if moves[index] == ""{
            moves[index] = "X"
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // Change `2.0` to the desired number of seconds.
                botMove()
            }
        }

        if checkWinner(list: moves, letter: "X") {
                endGameText = "YOU WON!"
                print(endGameText)
                gameEnded = true
        }
        
        
        
    }

    func botMove(){
        count += 1
        var availableMoves: [Int] = []
        var movesLeft = 0
                
        // Check the available moves left
        for move in moves {
            if move == "" {
                availableMoves.append(movesLeft)
            }
            movesLeft += 1
        }
        
        // Make sure there are moves left before bot moves
        if availableMoves.count != 0 {
            moves[availableMoves.randomElement()!] = "O"
        }
        if checkWinner(list: moves, letter: "O") {
            endGameText = "You Lost!"
        }
        else if availableMoves.count == 0{
            endGameText = "It's a tie!"
            print("Tie")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
