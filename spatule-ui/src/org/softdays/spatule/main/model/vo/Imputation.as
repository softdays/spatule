package org.softdays.spatule.main.model.vo
{
	public class Imputation
	{
		
		public static const NONE:Number= 0;
		public static const HALF:Number = 0.5;
		public static const WHOLE:Number = 1;
		
		public var date:Date;
		public var quota:Number = NONE;
		
		public function Imputation()
		{
			super();
		}
	}
}