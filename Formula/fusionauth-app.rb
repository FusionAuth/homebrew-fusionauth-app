class FusionauthApp < Formula
  desc "FusionAuth App"
  homepage "https://fusionauth.io"
  url "https://files.fusionauth.io/products/fusionauth/1.54.0/fusionauth-app-1.54.0.zip"
  sha256 "20ef35959343334cd57ab7fdecbb8423b7474a299fceb2bd5561ef6d06de3359"

  def install
    prefix.install "fusionauth-app"
    etc.install "config" => "fusionauth" unless File.exist? etc / "fusionauth"
    prefix.install_symlink etc / "fusionauth" => "config"
    (var / "fusionauth/java").mkpath unless File.exist? var / "fusionauth/java"
    prefix.install_symlink var / "fusionauth/java"
    (var / "log/fusionauth").mkpath unless File.exist? var / "log/fusionauth"
    prefix.install_symlink var / "log/fusionauth" => "logs"
  end

  def post_install
    #noop
  end

  def caveats
    <<~EOS
      Logs:   #{var}/log/fusionauth/fusionauth-app.log
      Config: #{etc}/fusionauth/fusionauth.properties
    EOS
  end

  service do
    run ["sh", "-x", "start.sh", "--debug"]
    keep_alive true
    working_dir opt_prefix/"fusionauth-app/bin"
    log_path var/"log/fusionauth/fusionauth-app.log"
    error_log_path var/"log/fusionauth/fusionauth-app.log"
  end
end
