all:
	valac --pkg gtk+-3.0 --pkg gio-2.0 --pkg libsoup-2.4 --pkg json-glib-1.0 Main.vala ShortenWindow.vala TrayIcon.vala Shortener.vala Koinkoin.vala
