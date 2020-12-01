# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Surmagic < Formula
  desc "🚀 The better way to deal with Binary Frameworks on iOS, macOS, tvOS, watchOS. Create XCFrameworks with ease."
  homepage "https://github.com/gurhub/surmagic"
  url "https://github.com/gurhub/surmagic/archive/1.2.0.tar.gz"
  sha256 "0ae4d3e954bfac94269beb80a874e2ffbb34f657d334697014bc4506e105698b"
  license "MIT"

  def install
    bin.install("bin/surmagic")
  end
end
