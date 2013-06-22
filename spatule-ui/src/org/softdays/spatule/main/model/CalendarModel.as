package org.softdays.spatule.main.model
{
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	
	import org.softdays.spatule.main.model.vo.CalendarData;
	import org.softdays.spatule.main.model.vo.Imputation;
	
	import qs.utils.DateRange;

	[Bindable]
	public class CalendarModel
	{
		[Inject]
		public var calendarBean:CalendarBean;
		
		public static const LAYOUT_FULL_MONTH:String = "LAYOUT_FULL_MONTH";
		
		public static const LAYOUT_WORKING_WEEKS:String = "LAYOUT_WORKING_WEEKS";
		
		private var _currentDate:Date = null;

		public var currentLayout:Object = null;
		
		[ArrayElementType("org.softdays.spatule.main.model.vo.CalendarData")]
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
		
		private function getProjectCalendarData(projectName:String):CalendarData
		{
			for each (var calData:CalendarData in calendarData)
			{
				if (calData.projectName == projectName) 
				{
					return calData;
				}
			}
			
			return null;
		}
		
		/**
		 * Fait la somme de toutes les imputations du projet indiqué pour le mois courant.
		 */
		public function getMonthImputationsCount(projectName:String):Number
		{
			var count:Number = 0;
			
			var calData:CalendarData = getProjectCalendarData(projectName);
			
			if (calData && calData.imputations)
			{
				var range:DateRange = calendarBean.getWorkingWeeksRange(currentDate);
				for each (var i:Imputation in calData.imputations)
				{
					if (range.contains(i.date)) 
					{
						count+= i.quota;
					}
				}
			}
			
			return count;
		}

	}
}