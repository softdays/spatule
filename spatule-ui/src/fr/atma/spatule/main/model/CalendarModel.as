package fr.atma.spatule.main.model
{
	import fr.atma.spatule.main.model.vo.CalendarData;
	import fr.atma.spatule.main.model.vo.Imputation;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;

	[Bindable]
	public class CalendarModel
	{
		public static const LAYOUT_FULL_MONTH:String = "LAYOUT_FULL_MONTH";
		
		public static const LAYOUT_WORKING_WEEKS:String = "LAYOUT_WORKING_WEEKS";
		
		private var _currentDate:Date = null;

		public var currentLayout:Object = null;
		
		[ArrayElementType("fr.atma.spatule.main.model.vo.CalendarData")]
		public var calendarData:IList;
		
		public function CalendarModel()
		{
			super();
			currentDate = new Date();
			currentLayout = LAYOUT_WORKING_WEEKS;
		}
		
		public function get currentDate():Date
		{
			return _currentDate;
		}
		
		public function set currentDate(value:Date):void
		{
			_currentDate = value;
		}

		public function get currentMonth():Number
		{
			return _currentDate.month;
		}

		public function get currentYear():Number
		{
			return _currentDate.fullYear;
		}
		
		public function set currentMonth(month:Number):void
		{
			_currentDate.month = month;
		}
		
		public function set currentYear(year:Number):void
		{
			_currentDate.fullYear = year;
		}
		
		public function getCalendarData(imputation:Imputation):CalendarData
		{
			for each(var data:CalendarData in calendarData)
			{
				var imputations:IList = data.imputations;
				if (imputations)
				{
					var index:int = imputations.getItemIndex(imputation);
					if (index >= 0)
					{
						return data;
					}
				}
			}
			
			return null;
		}
		
		public function removeImputation(imputation:Imputation):CalendarData
		{
			for each(var data:CalendarData in calendarData)
			{
				var imputations:IList = data.imputations;
				if (imputations)
				{
					var index:int = imputations.getItemIndex(imputation);
					if (index >= 0)
					{
						data.imputations.removeItemAt(index);
						
						return data;
					}
				}
			}
			
			return null;
		}
		
		public function isDateLocked(date:Date):Boolean
		{
			var imputationsAtDate:IList = getImputations(date);
			var status:Number = Imputation.NONE;
			for each (var imputation:Imputation in imputationsAtDate)
			{
				status+= imputation.quota;
			}
			
			return status == Imputation.WHOLE;
		}
		
		public function getStatusForDate(date:Date):Number
		{
			var imputationsAtDate:IList = getImputations(date);
			var status:Number = Imputation.NONE;
			for each (var imputation:Imputation in imputationsAtDate)
			{
				status+= imputation.quota;
			}
			
			return status;
		}
		
		private function getImputations(date:Date):IList
		{
			var imputations:IList = new ArrayCollection();
			for each (var calData:CalendarData in calendarData)
			{
				var imputation:Imputation = calData.getImputation(date);
				if (imputation)
				{
					imputations.addItem(imputation);
				}
			}
			
			return imputations;
		}

	}
}