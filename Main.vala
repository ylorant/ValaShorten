using Gtk;

namespace ValaShorten
{
	public class Main : Object
	{
		private ShortenWindow win;
		private TrayIcon icon;
		private Clipboard clip;
		private Shortener up;
		
		public Main()
		{
			this.win = new ShortenWindow();
			this.icon = new TrayIcon();
			this.up = new Koinkoin();
			
			this.icon.validate.connect(this.send_clipboard);
			this.icon.show_window.connect(this.show_window);
			this.win.validate.connect(this.on_send);
			
			this.win.show_all();
		}
		
		public void show_window()
		{
			this.win.show_all();
		}
		
		public void send_clipboard()
		{
			Clipboard clip = Clipboard.get_for_display(Gdk.Display.get_default(), Gdk.SELECTION_CLIPBOARD);
			string url = clip.wait_for_text();
			if(url != null)
			{
				this.win.url = url;
				this.win.disable();
				this.send(url, false);
				clip.set_text(this.up.short_url, this.up.short_url.length);
			}
		}
		
		public void on_send(string url)
		{
			this.send(url, true);
		}
		
		public void send(string url, bool show_window = true)
		{
			if(show_window)
				this.win.show_all();
			this.up.long_url = url;
			this.up.shorten();
			this.win.enable();
			if(this.up.success)
				this.win.update_url(this.up.short_url);
			else
				this.win.update_url(this.up.error);
		}
		
		public void run()
		{
			Gtk.main();
		}
		
		public static void main(string[] args)
		{
			Gtk.init (ref args);
			Main main = new Main();
			
			main.run();
		}
	}
}
