Pod::Spec.new do |s|
  s.name         = "BYLBadgeView"
  s.version      = "1.0.2"
  s.summary      = "An animatable, TextKit based view to display badges."
  s.description  = <<-DESC
                   BYLBadgeView is a UIView subclass that draws a configurable, animatable badge.

		   This is useful if you want the badge to do some animation, such as a quick flash, 
		   when it's badge value changes. You can also have it animate up to a particular badge,
		   or animate down.  Updated by Matt KAntor to accept String over Integer.
                   DESC

  s.homepage     = "https://github.com/scondoo/BYLBadgeView"
  s.license      = 'MIT'
  s.author       = { "James Richard" => "ketzu@icloud.com" }
  s.platform     = :ios, '7.0'
  s.source       = { :git => "https://github.com/scondoo/BYLBadgeView.git", :tag => "v1.0.2" }
  s.source_files  = 'Sources'
  s.requires_arc = true
end
