# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Surmagic < Formula
  desc "🚀 The better way to deal with Binary Frameworks on iOS, macOS, tvOS, watchOS. Create XCFrameworks with ease."
  homepage "https://github.com/gurhub/surmagic"
  url "https://github.com/gurhub/surmagic/archive/v1.0.2.tar.gz"
  sha256 "bb1e9bf9597d1c5c9091601fe7b55198750d7ec3c75c4daaa22c822161909875"
  license "GPL-3.0"

  def install
    bin.install("bin/surmagic")
  end
end