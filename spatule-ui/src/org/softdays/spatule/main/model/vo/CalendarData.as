package org.softdays.spatule.main.model.vo
{
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	
	import qs.utils.DateUtils;

	public class CalendarData
	{
		public var projectName:String;
		
		[ArrayElementType("org.softdays.spatule.main.model.vo.Imputation")] 
		public var imputations:IList;
		
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
		
		public function addImputation(date:Date, quota:Number=Imputation.WHOLE):Imputation
		{
			var imputation:Imputation = new Imputation();
			imputation.date = date;
			imputation.quota = quota;
			if (imputations == null)
			{
				imputations = new ArrayCollection();
			}
			imputations.addItem(imputation);
			
			return imputation;
		}
		
		public function getWeekImputationsCount(date:Date):Number
		{
			var count:Number = 0;
			if (imputations)
			{
				for each (var i:Imputation in imputations)
				{
					if (i.date > date) return count;
					
					var startDate:Date = new Date(date.fullYear, date.month, date.date-7);
					
					if (i.date < startDate) continue;
					
					count+= i.quota;
					
				}
			}
			
			return count;
		}

	}
}