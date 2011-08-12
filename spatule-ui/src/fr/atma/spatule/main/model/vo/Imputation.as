package fr.atma.spatule.main.model.vo
{
	public class Imputation
	{
		
		public static const NOTHING:Number= 0;
		public static const HALF:Number = 0.5;
		public static const WHOLE:Number = 1;
		
		public var date:Date;
		public var quota:Number = NOTHING;
		
		public function Imputation()
		{
			super();
		}
	}
}