using Soup;

namespace ValaShorten
{
	public abstract class Shortener
	{
		public string long_url;
		public string short_url;
		public string error;
		public bool success;
		protected SessionAsync session;
		
		public Shortener()
		{
			this.long_url = "";
			this.short_url = "";
			this.session = new SessionAsync();
		}
		
		public Shortener.with_url(string url)
		{
			this();
			this.long_url = url;
		}
		
		public abstract bool shorten();
	}
}
