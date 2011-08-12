package fr.atma.spatule.main.model.vo
{
	import mx.collections.ArrayCollection;
	
	import qs.utils.DateUtils;

	public class CalendarData
	{
		public var projectName:String;
		
		[ArrayElementType("fr.atma.spatule.main.model.vo.Imputation")] 
		public var imputations:ArrayCollection;
		
		public function CalendarData()
		{
			super();
		}
		
		public static function newInstance(projectName:String):CalendarData
		{
			var instance:CalendarData = new CalendarData();
			instance.projectName = projectName;
			
			return instance;
		}
		
		public function getImputation(date:Date):Imputation
		{
			if (!imputations) return null;
			
			for each (var imputation:Imputation in imputations)
			{
				if (imputation.date.getTime() == date.getTime())
				{
					return imputation;
				}
			}
			
			return null;
		}
	}
}