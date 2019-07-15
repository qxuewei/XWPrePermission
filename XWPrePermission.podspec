Pod::Spec.new do |spec|
s.name         = 'XWPrePermission'
s.version      = '0.0.1'
s.summary      = 'iOS permissions'
s.homepage     = 'https://github.com/qxuewei/XWPrePermission'
s.license      = 'MIT'
s.authors      = {'qiuxuewei' => 'qxuewei@yeah.net'}
s.platform     = :ios, '8.0'
s.source       = {:git => 'https://github.com/qxuewei/XWPrePermission.git', :tag => s.version}
s.requires_arc = true
s.default_subspec = 'All'

s.subspec 'All' do |all|
all.source_files = 'XWPrePermissions/*.{h,m}'
end

s.subspec 'Base' do |base|
base.source_files = 'XWPrePermissions/XWPrePermissionSetting.{h,m}','XWPrePermissions/XWPrePermission.{h,m}'
end

s.subspec 'Camera' do |camera|
camera.source_files = 'XWPrePermissions/XWPrePermissionCamera.{h,m}'
end

s.subspec 'Photo' do |photo|
photo.source_files = 'XWPrePermissions/XWPrePermissionPhotos.{h,m}'
end

s.subspec 'Location' do |location|
location.source_files = 'XWPrePermissions/XWPrePermissionLocation.{h,m}'
end

s.subspec 'Microphone' do |microphone|
microphone.source_files = 'XWPrePermissions/XWPrePermissionMicrophone.{h,m}'
end


end
