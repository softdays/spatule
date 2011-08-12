package fr.atma.spatule.main.service
{
	import flash.events.IEventDispatcher;
	
	import fr.atma.spatule.main.model.events.ImputationEvent;
	import fr.atma.spatule.main.model.vo.CalendarData;
	import fr.atma.spatule.main.model.vo.Imputation;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;

	public class ImputationServiceImpl implements ImputationService
	{
		[ArrayElementType("fr.atma.spatule.main.model.vo.CalendarData")] 
		private var mockData:IList = new ArrayCollection([
			CalendarData.newInstance("LPC2D"),
			CalendarData.newInstance("LPC1D"),
			CalendarData.newInstance("NetSync"),
			CalendarData.newInstance("SconetAdm"),
			CalendarData.newInstance("Absences"),
			CalendarData.newInstance("TS"),
			CalendarData.newInstance("SconetTs"),
			CalendarData.newInstance("Notes")]);
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;	
		
		public function ImputationServiceImpl()
		{
			super();
			var imput1:Imputation = new Imputation();
			imput1.date = new Date(2011, 6, 5);
			imput1.quota = Imputation.WHOLE;
			var imput2:Imputation = new Imputation();
			imput2.date = new Date(2011, 6, 6);
			imput2.quota = Imputation.HALF;
			CalendarData(mockData[1]).imputations = new ArrayCollection(
				[imput1, imput2]
			);
		}
		
		public function loadImputations(userId:uint, date:Date, token:String):void
		{
			var event:ImputationEvent;
			event = new ImputationEvent(ImputationEvent.IMPUTATIONS_LOADED);
			event.data = mockData;
			dispatcher.dispatchEvent(event);
		}
	}
}