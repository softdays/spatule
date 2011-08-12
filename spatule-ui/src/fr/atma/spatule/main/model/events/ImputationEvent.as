package fr.atma.spatule.main.model.events
{
	import flash.events.Event;
	
	import mx.collections.IList;
	
	public class ImputationEvent extends Event
	{
		public static const IMPUTATIONS_LOADED:String = "IMPUTATIONS_LOADED";
		
		public var data:IList;
		
		public function ImputationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}