require 'rake/clean'

CLEAN.include('*.desktop', '*.session', 'tmp/')

DEST = "tmp"

task :default => ["write_files"]

def ag_desktop_file
  File.open("awesome-gnome.desktop", "w") do |f|
    awesome_gnome_desktop = %Q[
    [Desktop Entry]
    Name=Awesome GNOME
    Comment=Dynamic window manager
    Exec=gnome-session --session=awesome
    TryExec=awesome
    Type=Application
    X-LightDM-DesktopName=Awesome GNOME
    X-Ubuntu-Gettext-Domain=gnome-session-3.0
    ]
    f.write(awesome_gnome_desktop)
  end
end

def a_session_file
  File.open("awesome.session", "w") do |f|
    awesome_session = %Q[
    [GNOME Session]
    Name=Awesome session
    RequiredComponents=awesome;gnome-settings-daemon;
    DesktopName=Awesome
    ]
    f.write(awesome_session)
  end
end

def a_desktop_file
  File.open("awesome.desktop", "w") do |f|
    awesome_desktop = %Q[
    [Desktop Entry]
    Version=1.0
    Type=Application
    Name=Awesome
    Comment=The awesome launcher!
    TryExec=awesome
    Exec=awesome
    ]
    f.write(awesome_desktop)
  end
end

desc "Write all files"
task :write_files do
  mkdir_p "tmp"
  ag_desktop_file
  a_session_file
  a_desktop_file
  copy_files
end

# hash pairs of files with locations they go
def copy_files
  setup_files = Rake::FileList.new("*.{desktop,session}")
  setup_files.each {|file| mv file, DEST, :verbose => true}
end
