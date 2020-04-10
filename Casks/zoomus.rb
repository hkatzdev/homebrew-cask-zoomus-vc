cask 'zoomus' do
  # zoomus 4.6.8 was the last version to include the disable-library-validation entitlement needed for virtual cameras
  # please note that this reduces zoomus' security - see nvd.nist.gov/vuln/detail/CVE-2020-11470 for details
  version '4.6.19178.0323'
  sha256 'c270ac7d529ab4fe28b3ec0a2d8861855fd76cb07dec664833c3577edc5fecd8'

  # d11yldzmag5yn.cloudfront.net was verified as official when first introduced to the cask
  url "https://d11yldzmag5yn.cloudfront.net/prod/#{version}/Zoom.pkg"
  appcast "https://macupdater.net/cgi-bin/check_urls/check_url_redirect.cgi?url=https://zoom.us/client/#{version}/Zoom.pkg"
  name 'Zoom.us'
  homepage 'https://www.zoom.us/'

  auto_updates true

  pkg 'Zoom.pkg'

  postflight do
    set_ownership '~/Library/Application Support/zoom.us'
  end

  uninstall quit:       'us.zoom.ZoomOpener',
            signal:     [
                          ['KILL', 'us.zoom.xos'],
                        ],
            pkgutil:    'us.zoom.pkg.videmeeting',
            login_item: 'ZoomOpener',
            delete:     [
                          '/Applications/zoom.us.app',
                          '~/.zoomus/ZoomOpener.app',
                          '~/Library/Internet Plug-Ins/ZoomUsPlugIn.plugin',
                        ]

  zap trash: [
               '~/.zoomus',
               '~/Desktop/Zoom',
               '~/Documents/Zoom',
               '~/Library/Application Support/zoom.us',
               '~/Library/Caches/us.zoom.xos',
               '~/Library/Cookies/us.zoom.xos.binarycookies',
               '~/Library/Logs/zoom.us',
               '~/Library/Logs/zoominstall.log',
               '~/Library/Preferences/ZoomChat.plist',
               '~/Library/Preferences/us.zoom.xos.plist',
               '~/Library/Safari/PerSiteZoomPreferences.plist',
               '~/Library/SafariTechnologyPreview/PerSiteZoomPreferences.plist',
               '~/Library/Saved Application State/us.zoom.xos.savedState',
             ]
end
