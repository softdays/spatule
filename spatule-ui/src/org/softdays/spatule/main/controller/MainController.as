/*   
 *  Copyright 2011, Softdays.org
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
package org.softdays.spatule.main.controller
{
	import flash.events.IEventDispatcher;
	
	import org.softdays.spatule.main.model.CalendarModel;
	import org.softdays.spatule.main.model.events.ApplicationEvent;
	import org.softdays.spatule.main.model.events.ImputationEvent;
	import org.softdays.spatule.main.model.vo.CalendarData;
	import org.softdays.spatule.main.model.vo.Imputation;
	import org.softdays.spatule.main.service.ImputationService;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	
	import spark.components.gridClasses.GridColumn;

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
		
		[EventHandler(event="ImputationEvent.IMPUTATION_CREATE", properties="data, details")]
		public function handleImputationCreateEvent(data:CalendarData, details:Date):void
		{
			var status:Number = calendarModel.getStatusForDate(details);
			if (status == Imputation.WHOLE) return;
			
			if (status == Imputation.HALF)
			{
				data.addImputation(details, Imputation.HALF);
			}
			else
			{
				data.addImputation(details);
			}			
			calendarModel.calendarData.itemUpdated(data);
		}
		
		[EventHandler(event="ImputationEvent.IMPUTATION_UPDATE", properties="data")]
		public function handleImputationUpdateEvent(data:Imputation):void
		{
			switch(data.quota)
			{
				case Imputation.HALF:
				{
					var calendarData:CalendarData = calendarModel.removeImputation(data);
					calendarModel.calendarData.itemUpdated(calendarData);
					break;
				}
					
				case Imputation.WHOLE:
				{
					data.quota = Imputation.HALF;
					var calData:CalendarData = calendarModel.getCalendarData(data);
					calendarModel.calendarData.itemUpdated(calData);
					break;
				}
					
				default:
				{
					break;
				}
			}
		}
	}
}