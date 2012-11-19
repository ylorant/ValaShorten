using Gtk;

namespace ValaShorten
{
	public class ShortenWindow : Window
	{
		private Entry url_entry;
		private Button button;
		
		public string url {
			set
			{
				this.url_entry.set_text(value);
			}
			get
			{
				return this.url_entry.get_text();
			}
		}
		
		public signal void validate(string url);
		
		public ShortenWindow()
		{
			this.title = "ValaShorten";
			this.url_entry = new Entry();
			this.button = new Button.with_label("Shorten");
			Box main_box = new Box(Orientation.VERTICAL, 0);
			
			main_box.homogeneous = false;
			this.url_entry.placeholder_text = "Paste URL here";
			
			this.button.clicked.connect(this.on_validate);
			this.url_entry.activate.connect(this.on_validate);
			
			main_box.pack_start(new Label("Enter the URL to shorten:"), false, false);
			main_box.pack_start(this.url_entry, true, true);
			main_box.pack_start(this.button, false, false);
			this.add(main_box);
			
			this.delete_event.connect(this.hide_on_delete);
		}
		
		public void on_destroy()
		{
			
		}
		
		public void on_validate()
		{
			this.validate(this.url_entry.get_text());
		}
		
		public void update_url(string url)
		{
			this.url_entry.set_text(url);
		}
		
		public void disable()
		{
			this.url_entry.sensitive = false;
			this.button.sensitive = false;
		}
		
		public void enable()
		{
			this.url_entry.sensitive = true;
			this.button.sensitive = true;
		}
	}
}
