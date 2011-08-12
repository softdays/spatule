package fr.atma.spatule.main.service
{
	public interface ImputationService
	{
		function loadImputations(userId:uint, date:Date, token:String):void
	}
}