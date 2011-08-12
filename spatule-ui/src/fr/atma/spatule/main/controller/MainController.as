/*   
 *  Copyright 2011, Remi Patriarche.
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *  
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *  
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package fr.atma.spatule.main.controller
{
	import flash.events.IEventDispatcher;
	
	import fr.atma.spatule.main.model.CalendarModel;
	import fr.atma.spatule.main.model.events.ApplicationEvent;
	import fr.atma.spatule.main.model.events.ImputationEvent;
	import fr.atma.spatule.main.service.ImputationService;
	
	import mx.collections.IList;

	public class MainController
	{
		[Dispatcher]
		public var dispatcher:IEventDispatcher;	
		
		[Inject]
		public var imputationsSvc:ImputationService;
		
		[Inject]
		public var calendarModel:CalendarModel;
		
		public function MainController()
		{
			super();
		}
		
		[EventHandler(event="ApplicationEvent.START")]
		public function handleApplicationStartEvent(event:ApplicationEvent):void
		{
			calendarModel.currentDate = new Date();
			imputationsSvc.loadImputations(0, calendarModel.currentDate, "foofoofoo"); 
		}
		
		[EventHandler(event="ImputationEvent.IMPUTATIONS_LOADED", properties="data")]
		public function handleImputationsLoadedEvent(data:IList):void
		{
			calendarModel.calendarData = data;
		}
	}
}