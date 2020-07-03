//
//  StreamView.swift
//  F1TV
//
//  Created by Ken Pham on 7/2/20.
//  Copyright © 2020 Phez Technologies. All rights reserved.
//

import AVKit
import SwiftUI

struct StreamView: View {
	var channel: ChannelResponse
	@State var player: AVPlayer?
	
	/// - TODO: figure out how to keep stream time the same when switching between streams (once we get to that)
	
    var body: some View {
		Optional($player.wrappedValue) { player in
			AVPlayerControllerRepresentable(player: player)
		}.onAppear(perform: load)
    }
	
	private func load () {
		guard self.player == nil else { return }
		Skylark.shared.loadStream(from: channel.key) { result in
			switch result {
			case .success(let response):
				DispatchQueue.main.async {
					self.player = AVPlayer(url: response.url)
				}
			default: ()
			}
		}
	}
}
