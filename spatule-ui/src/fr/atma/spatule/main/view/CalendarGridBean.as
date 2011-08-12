package fr.atma.spatule.main.view
{
	import fr.atma.spatule.main.model.CalendarBean;
	import fr.atma.spatule.main.model.CalendarModel;
	import fr.atma.spatule.settings.CalendarSettings;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.core.ClassFactory;
	import mx.core.IFactory;
	
	import qs.utils.DateRange;
	import qs.utils.TimeZone;
	
	import spark.components.gridClasses.GridColumn;

	public class CalendarGridBean
	{
		[Inject]
		public var calendarModel:CalendarModel;
		
		[Inject]
		public var calendarSettings:CalendarSettings;
		
		[Inject]
		public var calendarBean:CalendarBean;
		
		private static const _tz:TimeZone = TimeZone.localTimeZone;
		
		public static const DATE_COL_WIDTH:uint = 22;
		public static const TOTAL_COL_WIDTH:uint = 45;
		
		private static var _workingDayHeaderRenderer:IFactory = new ClassFactory(WorkingDayHeaderRenderer);
		private static var _dayOffHeaderRenderer:IFactory = new ClassFactory(DayOffHeaderRenderer);
		private static var _disabledDayHeaderRenderer:IFactory = new ClassFactory(DisabledDayHeaderRenderer);
		private static var _cellItemRenderer:IFactory = new ClassFactory(CalendarGridCellRenderer);
		
		public function getWorkingWeeksColumns(range:DateRange):IList
		{
			var newColumns:IList = new ArrayCollection();
			var projectColumn:GridColumn = new GridColumn();
			projectColumn.dataField = "projectName";
			projectColumn.headerText = "Projet";
			newColumns.addItem(projectColumn);
			
			var rangeDayCount:uint = _tz.rangeDaySpan(range);
			var d:Date = new Date(range.start.fullYear, range.start.month, range.start.date);
			var month:Number = d.month;
			for (var i:uint=0; i<rangeDayCount; ++i)
			{
				if (d.day == CalendarSettings.WEEK_END_DAY_1) 
				{
					d.date = d.date+1;
					continue;
				}
				
				var col:CalendarGridColumn = new CalendarGridColumn();
				col.date = clone(d);
				col.isNextMonth = month != d.month;
				col.width = DATE_COL_WIDTH;	
				col.itemRenderer = _cellItemRenderer;
				if (d.day == CalendarSettings.SUNDAY)
				{
					col.headerRenderer = _dayOffHeaderRenderer;
				}
				else 
				{
					var dateLabel:String = d.date>9 ? d.date.toString() : "0"+d.date.toString();
					col.headerText = dateLabel;
					col.headerRenderer = _workingDayHeaderRenderer;
				}					
				newColumns.addItem(col);
				
				d.date = d.date+1;
			}
			
			var totalColumn:GridColumn = new GridColumn();
			totalColumn.headerText = "Total";
			totalColumn.width = TOTAL_COL_WIDTH;
			newColumns.addItem(totalColumn);
			
			return newColumns;
		}
		
		public function getMonthColumns(range:DateRange):IList
		{
			var newColumns:IList = new ArrayCollection();
			var projectColumn:GridColumn = new GridColumn();
			projectColumn.dataField = "projectName";
			projectColumn.headerText = "Projet";
			newColumns.addItem(projectColumn);
			
			for (var i:uint=1; i <= _tz.rangeDaySpan(range); ++i)
			{
				var date:String = i>9 ? i.toString() : "0"+i.toString();
				var col:CalendarGridColumn = new CalendarGridColumn();
				col.width = DATE_COL_WIDTH;	
				var d:Date = new Date();
				d.date = i;
				d.month = calendarModel.currentDate.month;
				d.fullYear = calendarModel.currentDate.fullYear;
				col.headerRenderer = calendarBean.isWorkingDay(d) ? _workingDayHeaderRenderer : _disabledDayHeaderRenderer;
				col.headerText = date;
				col.date = d;
				newColumns.addItem(col);
			}
			
			return newColumns;
		}
		
		public function clone(d:Date):Date
		{
			return new Date(d.fullYear, d.month, d.date);
		}
	}
}