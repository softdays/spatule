package fr.atma.spatule.main.model
{
	import mx.collections.IList;

	[Bindable]
	public class CalendarModel
	{
		public static const LAYOUT_FULL_MONTH:String = "LAYOUT_FULL_MONTH";
		
		public static const LAYOUT_WORKING_WEEKS:String = "LAYOUT_WORKING_WEEKS";
		
		private var _currentDate:Date = null;

		public var currentLayout:Object = null;
		
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

	}
}