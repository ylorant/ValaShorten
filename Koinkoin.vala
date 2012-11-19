using Soup;
using Json;

namespace ValaShorten
{
	public class Koinkoin : Shortener
	{
		private const string QUERY_URL = "http://koinko.in/shorten";
		
		public override bool shorten()
		{
			string post_data = "url=" + this.long_url;
			Parser json = new Parser();
			
			Message msg = new Message("POST", Koinkoin.QUERY_URL);
			msg.set_request("application/x-www-form-urlencoded", MemoryUse.COPY, post_data.data);
			
			this.session.send_message(msg);
			
			try
			{
				json.load_from_data((string) msg.response_body.data);
			}
			catch(Error e)
			{
				this.error = "The server sent an invalid response";
				return false;
			}
			
			if(json.get_root().get_object().get_boolean_member("result") == true)
			{
				this.short_url = json.get_root().get_object().get_string_member("url");
				this.success = true;
				return true;
			}
			else
			{
				this.error = json.get_root().get_object().get_string_member("message");
				this.success = false;
				return false;
			}
		}
	}
}
