#
# Be sure to run `pod lib lint LFAdTableViewController.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "LFAdTableViewController"
  s.version          = "1.0.0.0"
  s.summary          = "LFAdTableViewController is UITableViewController with AdView."
  s.description      = <<-DESC
                       LFAdTableViewController is UITableViewController with AdView.

                       * Insert AdView in the bottom of UITableView by Method Swizzling.
                       * Import Header in UITableViewController.
                       * Call "setAdView:" and "setAdIsShown:"
                       DESC
  s.homepage         = "https://github.com/leak4mk0/LFAdTableViewController"
  s.screenshots      = "https://raw.github.com/leak4mk0/LFAdTableViewController/1.0.0.0/screenshots_1.png",
                       "https://raw.github.com/leak4mk0/LFAdTableViewController/1.0.0.0/screenshots_2.png"
  s.license          = 'MIT'
  s.author           = { "leak4mk0" => "leak4mk0[at]gmail.com" }
  s.source           = { :git => "https://github.com/leak4mk0/LFAdTableViewController.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/leak4mk0'

  s.platform     = :ios, '5.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
end
