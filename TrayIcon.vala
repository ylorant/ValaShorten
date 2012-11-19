using Gtk;

namespace ValaShorten
{
	public class TrayIcon : StatusIcon
	{
		private Gtk.Menu menu;
		
		public signal void validate();
		public signal void show_window();
		
		public TrayIcon()
		{
			this.set_from_file("icon.png");
			this.title = "ValaShorten";
			this.visible = true;
			
			this.menu = new Gtk.Menu();
			Gtk.MenuItem show = new Gtk.MenuItem.with_label("Show window");
			Gtk.MenuItem clipboard = new Gtk.MenuItem.with_label("Shorten clipboard URL");
			Gtk.MenuItem close = new Gtk.MenuItem.with_label("Close");
			
			this.menu.add(show);
			this.menu.add(clipboard);
			this.menu.add(close);
			
			show.activate.connect(this.on_show_window);
			clipboard.activate.connect(this.on_click);
			close.activate.connect(Gtk.main_quit);
			this.activate.connect(this.on_click);
			this.popup_menu.connect(this.show_menu);
		}
		
		public void show_menu(uint button, uint activate_time)
		{
			this.menu.show_all();
			this.menu.popup(null, null, this.position_menu, button, activate_time);
		}
		
		public void on_show_window()
		{
			this.show_window();
		}
		
		public void on_click()
		{
			this.validate();
		}
	}
}
