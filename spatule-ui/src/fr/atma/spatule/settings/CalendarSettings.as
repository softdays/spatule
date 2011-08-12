package fr.atma.spatule.settings
{
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.collections.IList;
	import mx.utils.ArrayUtil;
	
	import spark.components.Group;

	[Bindable]
	public class CalendarSettings
	{
		public static const WEEK_END_DAY_1:uint = 6;
		public static const SUNDAY:uint = 0;
		public static const MONTH_1_HEADER_WORKING_DAY_BGD_COLOR:uint = 0xffa800;
		public static const MONTH_2_HEADER_WORKING_DAY_BGD_COLOR:uint = 0x4bd209;
		
		public const firstDayOfWeek:uint = 1;
		
		[ArrayElementType("String")]
		public var months:IList = new ArrayList(
			["Janvier",
			"Février",
			"Mars",
			"Avril",
			"Mai",
			"Juin",
			"Juillet",
			"Août",
			"Septembre",
			"Octobre",
			"Novembre",
			"Décembre"]);

	}
}