package org.softdays.spatule.main.view
{
	import spark.components.gridClasses.GridColumn;
	
	public class CalendarGridColumn extends GridColumn
	{
		
		public var date:Date = null;
		public var isNextMonth:Boolean = false;
		
		public function CalendarGridColumn(columnName:String=null)
		{
			super(columnName);
		}
	}
}