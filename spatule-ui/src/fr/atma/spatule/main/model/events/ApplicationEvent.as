package fr.atma.spatule.main.model.events
{
	import flash.events.Event;
	
	public class ApplicationEvent extends Event
	{
		
		public static const START:String = "START";
		
		public function ApplicationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}