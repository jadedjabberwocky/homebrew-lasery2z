# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Lasery2z < Formula
  desc "Tool to modify Snapmaker laser GCode for a rotary module to include z movements"
  homepage "https://github.com/jadedjabberwocky/lasery2z"
  url "https://github.com/jadedjabberwocky/lasery2z/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "a619c852528a3e30bb32f8e321f757d8ba07c0f34967eb4124ec62ed2ad62e13"
  license "MIT"

  depends_on "go"

  def install
    ENV["GOPATH"] = buildpath
    ENV["PATH"] = "#{ENV["PATH"]}:#{buildpath}/bin"
    ENV["GO111MODULE"] = "on"
    (buildpath/"src/github.com/jadedjabberwocky/lasery2z").install buildpath.children
    cd "src/github.com/jadedjabberwocky/lasery2z" do
      system "pwd"
      system "find", "."
      system "go", "build", "-o", bin/"lasery2z", "."
    end
  end

  test do
    assert_match /Usage: lasery2z/, shell_output("#{bin/lasery2z} --help", 0)
  end
end
