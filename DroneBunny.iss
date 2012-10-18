/*

ComBot  Copyright © 2012  Tehtsuo and Vendan

This file is part of ComBot.

ComBot is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

ComBot is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with ComBot.  If not, see <http://www.gnu.org/licenses/>.

*/

objectdef obj_DroneBunnyConfig inherits obj_Base_Configuration
{
	method Initialize()
	{
		This[parent]:Initialize["DroneBunny"]
	}

Setting(string, Master, SetMaster)
Setting(string, DroneType, SetDroneType)

}

objectdef obj_DroneBunny inherits obj_State
{
	variable obj_DroneBunnyConfig Config
	
	method Initialize()
	{
		This[parent]:Initialize
		This.NonGameTiedPulse:Set[TRUE]
		PulseFrequency:Set[500]
		DynamicAddMiniMode("DroneBunny", "DroneBunny")
		LavishScript:RegisterEvent["Combot_DroneBunny_SetMaster"]
		Event[Combot_DroneBunny_SetMaster]:AttachAtom[This:SetMasterEvent]
	}
	
	method Start()
	{
		ui -load "${Dynamic.MiniModes.Element[DroneBunny].ConfigPath}/DroneBunny_Interface.xml"
		
	}
	
	method Stop()
	{
		ui -unload "${Dynamic.MiniModes.Element[DroneBunny].ConfigPath}/DroneBunny_Interface"
		This:Clear
	}
	
	method SetMaster()
	{
		relay all "Event[CombotDroneBunny_SetMaster]:Execute[${Me.CharID}]"
	}
	
	method SetMasterEvent(int64 Master)
	{
		Config:SetMaster[${Master}]
	}
}