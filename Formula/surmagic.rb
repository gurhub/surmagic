# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Surmagic < Formula
  desc "🚀 The better way to deal with Binary Frameworks on iOS, macOS, tvOS, watchOS. Create XCFrameworks with ease."
  homepage "https://github.com/gurhub/surmagic"
  url "https://github.com/gurhub/surmagic/archive/v1.1.0.tar.gz"
  sha256 "27b54a719d321d7f2a22868319d0461e4a6acef7c2a9420065f8075332135314"
  license "MIT"

  def install
    bin.install("bin/surmagic")
  end
end
