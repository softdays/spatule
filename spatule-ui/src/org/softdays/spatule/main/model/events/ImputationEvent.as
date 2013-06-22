package org.softdays.spatule.main.model.events
{
	import flash.events.Event;
	
	public class ImputationEvent extends Event
	{
		public static const IMPUTATIONS_LOADED:String = "IMPUTATIONS_LOADED";
		public static const IMPUTATION_UPDATE:String = "IMPUTATION_UPDATE";
		public static const IMPUTATION_CREATE:String = "IMPUTATION_CREATE";
		
		public var data:*;	
		public var details:*;	
		
		public function ImputationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}