class FusionauthApp < Formula
  desc "FusionAuth App"
  homepage "https://fusionauth.io"
  url "https://files.fusionauth.io/products/fusionauth/1.45.4/fusionauth-app-1.45.4.zip"
  sha256 "8960c0475915180e110e9e69862d2ec1f0f7960f71d870030a84aff8515ff1db"

  def install
    prefix.install "fusionauth-app"
    etc.install "config" => "fusionauth" unless File.exists? etc / "fusionauth"
    prefix.install_symlink etc / "fusionauth" => "config"
    (var / "fusionauth/java").mkpath unless File.exists? var / "fusionauth/java"
    prefix.install_symlink var / "fusionauth/java"
    (var / "log/fusionauth").mkpath unless File.exists? var / "log/fusionauth"
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

  # http://www.manpagez.com/man/5/launchd.plist/
  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>KeepAlive</key>
        <true/>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>sh</string>
          <string>start.sh</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>WorkingDirectory</key>
        <string>#{prefix}/fusionauth-app/bin</string>
        <key>StandardOutPath</key>
        <string>#{var}/log/fusionauth/fusionauth-app.log</string>
        <key>StandardErrorPath</key>
        <string>#{var}/log/fusionauth/fusionauth-app.log</string>
      </dict>
      </plist>
    EOS
  end
end
