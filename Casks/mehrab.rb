# Cask template. scripts/release-macos.sh fills in VERSION, BUILD and SHA256
# and pushes it to the tap (dev-ahmedhany/homebrew-mehrab). The same file, in
# official style, is what goes to Homebrew/homebrew-cask as Casks/m/mehrab.rb;
# once it is there, Homebrew's autobump bot follows new releases via livecheck.
cask "mehrab" do
  version "26.10.17,1021"
  sha256 "087605c911b486fcb667f36b7398647874b707d9bcf4379f2d17c57fdd44e9d1"

  url "https://github.com/dev-ahmedhany/homebrew-mehrab/releases/download/v#{version.csv.first}-#{version.csv.second}/Mehrab-#{version.csv.first}-#{version.csv.second}.zip",
      verified: "github.com/dev-ahmedhany/homebrew-mehrab/"
  name "Mehrab"
  name "محراب القرآن"
  desc "Quran tutoring with live teachers"
  homepage "https://app.mehrab-alquran.com/"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+)-(\d+)$/i)
    strategy :github_latest do |json, regex|
      match = json["tag_name"]&.match(regex)
      next if match.blank?

      "#{match[1]},#{match[2]}"
    end
  end

  depends_on macos: :ventura

  app "Mehrab.app"

  zap trash: [
    "~/Library/Application Support/com.shady.mehrab",
    "~/Library/Caches/com.shady.mehrab",
    "~/Library/Containers/com.shady.mehrab",
    "~/Library/Preferences/com.shady.mehrab.plist",
    "~/Library/Saved Application State/com.shady.mehrab.savedState",
  ]
end
