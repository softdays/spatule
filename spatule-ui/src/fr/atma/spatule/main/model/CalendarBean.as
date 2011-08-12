package fr.atma.spatule.main.model
{
	import fr.atma.spatule.settings.CalendarSettings;
	
	import qs.utils.DateRange;
	import qs.utils.TimeZone;

	public class CalendarBean
	{
		[Inject]
		public var calendarSettings:CalendarSettings;
		
		public static const TZ:TimeZone = TimeZone.localTimeZone;

		public function isWorkingDay(date:Date):Boolean
		{
			return date.day != 0 && date.day != 6;
		}
		
		public function getWorkingWeeksRange(date:Date):DateRange
		{
			
			return new DateRange(
				getFirstMondayOfTheMonth(date),
				getNextSunday(date));
		}
		
		public function next(date:Date):Date
		{
			return new Date(date.fullYear, date.month, date.date+1);
		}
		
		public function getFirstMondayOfTheMonth(date:Date):Date
		{
			var d:Date = TZ.startOfMonth(date);
			while (d.day != calendarSettings.firstDayOfWeek) 
			{
				d.date = d.date + 1;
			}
			
			return d;
		}
		
		public function getNextSunday(date:Date):Date
		{
			var d:Date = TZ.endOfMonth(date);
			
			while (d.day != CalendarSettings.SUNDAY) 
			{
				d.date = d.date + 1;
			}
			
			return d;
		}
	}
}