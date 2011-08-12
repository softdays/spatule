package fr.atma.spatule.main.controller
{
	import flash.events.IEventDispatcher;
	
	import fr.atma.spatule.main.model.CalendarModel;
	import fr.atma.spatule.main.model.events.ApplicationEvent;
	import fr.atma.spatule.main.model.events.ImputationEvent;
	import fr.atma.spatule.main.service.ImputationService;
	
	import mx.collections.IList;

	public class MainController
	{
		[Dispatcher]
		public var dispatcher:IEventDispatcher;	
		
		[Inject]
		public var imputationsSvc:ImputationService;
		
		[Inject]
		public var calendarModel:CalendarModel;
		
		public function MainController()
		{
			super();
		}
		
		[EventHandler(event="ApplicationEvent.START")]
		public function handleApplicationStartEvent(event:ApplicationEvent):void
		{
			calendarModel.currentDate = new Date();
			imputationsSvc.loadImputations(0, calendarModel.currentDate, "foofoofoo"); 
		}
		
		[EventHandler(event="ImputationEvent.IMPUTATIONS_LOADED", properties="data")]
		public function handleImputationsLoadedEvent(data:IList):void
		{
			calendarModel.calendarData = data;
		}
	}
}