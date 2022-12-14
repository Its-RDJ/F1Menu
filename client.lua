local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX             				 = nil

local cardOpen 					= false
local playerData 				= {}
local windowavg					= false
local windowavd					= false
local windowarg					= false
local windoward					= false
local window 					= false
local engineOn 					= true
local speedkm 					= 0


-- Server callback
RegisterNetEvent('Insert-legitimation:open')
AddEventHandler('Insert-legitimation:open', function(playerData)
	cardOpen = true
	SendNUIMessage({
		action = "open",
		array = playerData
	})
end)

Citizen.CreateThread(function()
  while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('Insertscripting:openportofoon')
AddEventHandler('Insertscripting:openportofoon', function(connectedPlayers)
	ExecuteCommand("radio")
end)

--ID Menu

function OpenShowGiveID()

ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'id_card_menu',
	{
    title    = _U('id_menu'),
    align    = 'top-left',
		elements = {
			{label = _U('check_id'), value = 'check'},
			{label = _U('show_id'), value = 'show'}
		}
	},
	function(data2, menu2)
		if data2.current.value == 'check' then
			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
		elseif data2.current.value == 'show' then
			local player, distance = ESX.Game.GetClosestPlayer()

			if distance ~= -1 and distance <= 3.0 then
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
      else
        TriggerEvent("pNotify:SendNotification", {text = _U('nobody_near'), type = "error", queue = "vehiclemenu", timeout = 3000, layout = "bottomLeft"})
			end
		end
	end,
	function(data2, menu2)
		menu2.close()
		OpenShowGiveInsert()
	end
)

end
----------------------------------------------
function OpenShowGiveDL()

ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'id_card_menu',
	{
    title    = _U('Insert ID Menu'),
    align    = 'top-left',
		elements = {
			{label = _U('check_id2'), value = 'check'},
			{label = _U('show_id2'), value = 'show'}
		}
	},
	function(data2, menu2)
		if data2.current.value == 'check' then
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
		elseif data2.current.value == 'show' then
			local player, distance = ESX.Game.GetClosestPlayer()

			if distance ~= -1 and distance <= 3.0 then
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
			else
				TriggerEvent("pNotify:SendNotification", {text = _U('nobody_near'), type = "error", queue = "vehiclemenu", timeout = 3000, layout = "bottomLeft"})
			end
		end
	end,
	function(data2, menu2)
		menu2.close()
		OpenShowGiveInsert()
	end
)

end
----------------------------------------------
function OpenShowGiveInsert()

ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'civilian_actions',
	{
    title    = 'Insert ID Menu',
    align    = 'top-left',
		elements = {
            {label = _U('id_card'), value = 'id_short'},
			{label = _U('id_card2'), value = 'id_short2'},
  --  		{label = _U('id_card3'), value = 'id_short3'},
	--		{label = _U('check_id2'), value = 'check'},
	--		{label = _U('show_id2'), value = 'show'}
		}
	},
	function(data2, menu2)
        if data.current.value == 'id_short' then
      	OpenShowGiveID()
      end
	  
	  if data.current.value == 'id_short2' then
      	OpenShowGiveDL()
      end
            
      if data.current.value == 'id_short2' then
      	OpenShowGiveDL()
      end
            
		if data2.current.value == 'check' then
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
		elseif data2.current.value == 'show' then
			local player, distance = ESX.Game.GetClosestPlayer()

			if distance ~= -1 and distance <= 3.0 then
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
			else
				TriggerEvent("pNotify:SendNotification", {text = _U('nobody_near'), type = "error", queue = "vehiclemenu", timeout = 3000, layout = "bottomLeft"})
			end
		end
	end,
	function(data2, menu2)
		menu2.close()
		OpenCivilianActionsMenu()
	end
)

end
----------------------------------------------
function OpenShowGiveGL()

ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'id_card_menu',
	{
    title    = _U('Insert ID Menu'),
    align    = 'top-left',
		elements = {
			{label = _U('check_id3'), value = 'check'},
			{label = _U('show_id3'), value = 'show'}
		}
	},
	function(data2, menu2)
		if data2.current.value == 'check' then
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
		elseif data2.current.value == 'show' then
			local player, distance = ESX.Game.GetClosestPlayer()

			if distance ~= -1 and distance <= 3.0 then
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'weapon')
                 exports['mythic_notify']:SendAlert('inform', 'You have shown your weapon certificate')
			else
				exports['mythic_notify']:SendAlert('inform', 'Theres no one around')
			end
		end
	end,
	function(data2, menu2)
		menu2.close()
		OpenShowGiveInsert()
	end
)

end
--Settings Menu
function OpenShowGivesettings()

ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'id_card_menu',
	{
    title    = 'Insert Menu',
    align    = 'top-left',
		elements = {
			{label = 'Disable chat', value = 'dchat'},
			{label = 'Empty chat', value = 'chat'},
            {label = 'Ids above head', value = 'ids'}
		}
	},
	function(data2, menu2)
		if data2.current.value == 'dchat' then
				ExecuteCommand("toggle")
		elseif data2.current.value == 'chat' then
                ExecuteCommand("clear")
        elseif data2.current.value == 'ids' then
                ExecuteCommand("id")
		end
	end,
	function(data2, menu2)
		menu2.close()
		OpenCivilianActionsMenu()
	end
)

end
--Clothing Menu
function OpenShowGiveesclothing()

ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'id_card_menu',
	{
    title    = 'Insert clothing',
    align    = 'top-left',
		elements = {
			{label = 'Police', value = 'pol'},
			{label = 'SWAT', value = 'swat'},
            {label = 'Enforcement', value = 'enf'},
            {label = 'Ambulance', value = 'amb'},
            {label = 'mechanic', value = 'mech'},
            {label = 'Police women', value = 'polw'},
			{label = 'SWAT Women', value = 'swatw'},
            {label = 'Enforcement women', value = 'enfw'},
            {label = 'Ambulance women', value = 'ambw'},
            {label = 'mechanic women', value = 'mechw'},
		}
	},
	function(data2, menu2)
		if data2.current.value == 'pol' then
				ExecuteCommand("euppolitie")
                menu2.close()
                ESX.UI.Menu.CloseAll()
		elseif data2.current.value == 'swat' then
                ExecuteCommand("youre clothing command")
                menu2.close()
                ESX.UI.Menu.CloseAll()
        elseif data2.current.value == 'enf' then
                ExecuteCommand("youre clothing command")
                menu2.close()
                ESX.UI.Menu.CloseAll()
        elseif data2.current.value == 'amb' then
                ExecuteCommand("youre clothing command")
                menu2.close()
                ESX.UI.Menu.CloseAll()
        elseif data2.current.value == 'mech' then
                ExecuteCommand("youre clothing command")
                menu2.close()
                ESX.UI.Menu.CloseAll()
        elseif data2.current.value == 'polw' then
                ExecuteCommand("youre clothing command")
                menu2.close()
                ESX.UI.Menu.CloseAll()
		elseif data2.current.value == 'swatw' then
                ExecuteCommand("youre clothing command")
                menu2.close()
                ESX.UI.Menu.CloseAll()
        elseif data2.current.value == 'enfw' then
                ExecuteCommand("youre clothing command")
                menu2.close()
                ESX.UI.Menu.CloseAll()
        elseif data2.current.value == 'ambw' then
                 ExecuteCommand("youre clothing command")
                menu2.close()
                ESX.UI.Menu.CloseAll()
        elseif data2.current.value == 'mechw' then
                ExecuteCommand("youre clothing command")
                menu2.close()
                ESX.UI.Menu.CloseAll()
		end
	end,
	function(data2, menu2)
		menu2.close()
		OpenCivilianActionsMenu()
	end
)

end
--Main Menu

function OpenCivilianActionsMenu()

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
  'default', GetCurrentResourceName(), 'civilian_actions',
  {
    title    = 'Insert Menu',
    align    = 'top-left',
    elements = {
    -- {label = _U('id_card'), value = 'id_kort'},
--	{label = _U('id_card2'), value = 'id_kort2'},
 --   {label = _U('id_card3'), value = 'id_kort3'},
    {label = 'ID-Menu', value = 'Insert'},
    {label = 'Vehicles menu', value = 'vehiclemenu'},
    {label = 'Animation menu', value = 'emote'},
    {label = 'Open / close radio', value = 'radio'},
    {label = 'Radio Name Set', value = 'radioname'},
    {label = 'Emergency services Clothing', value = 'esclothing'},
    {label = '?????? | Settings', value = 'settings'},
    }
  },
    
    function(data, menu)

      if data.current.value == 'id_kort' then
      	OpenShowGiveID()
      end 
	  
	  if data.current.value == 'id_kort2' then
      	OpenShowGiveDL()
      end

	  if data.current.value == 'esclothing' then
      	OpenShowGiveesclothing()
      end
            
      if data.current.value == 'id_kort2' then
      	OpenShowGiveDL() 
      end      
            
      if data.current.value == 'settings' then
      	OpenShowGivesettings()
      end  
	  
	  if data.current.value == 'Insert' then
      	OpenShowGiveInsert()
      end
      
      if data.current.value == 'radio' then
      	ExecuteCommand("radio")
        menu.close()
      end
            
       if data.current.value == 'emote' then
      	ExecuteCommand("emotemenu")
      menu.close()
      end
      if data.current.value == 'radioname' then
      	ExecuteCommand("callsign")
      menu.close()
      end
            
      if data.current.value == 'callsign' then
        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Community Service Menu', {
          title = "Radio Name",
        }, function (data2, menu)
          local callsign = tonumber(data2.value)
          
          if callsign == nil then
            ESX.ShowNotification('Nothing Entered')
          else
            ExecuteCommand("setcallsign " .. callsign)
            menu.close()
          end
        end, function (data2, menu)
          menu.close()
        end)
        menu.close()
      end
            
      if data.current.value == 'firecard' then
      	ExecuteCommand("infirecard")
        exports['mythic_notify']:SendAlert('inform', 'You are in the firecard')
      end

      if data.current.value == 'blindfold' then
        local player, distance = ESX.Game.GetClosestPlayer()

      if distance ~= -1 and distance <= 3.0 then
           ESX.TriggerServerCallback('jsfour-blindfold:itemCheck', function( hasItem )
              TriggerServerEvent('jsfour-blindfold', GetPlayerServerId(player), hasItem)
           end)
      else
           ESX.ShowAdvancedNotification('Individual actions ',' ~ b ~ Blindfold', _U('nobody_near'), 'CHAR_DEFAULT', 8)
          end
      end

      if data.current.value == 'vehiclemenu' then
                OpenVehicleMenu()
            end
        

     

     --[[ if data.current.value == 'check' then
            TriggerServerEvent('jsfour-legitimation:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
      elseif data.current.value == 'show' then
           local player, distance = ESX.Game.GetClosestPlayer()

      if distance ~= -1 and distance <= 3.0 then
        TriggerServerEvent('jsfour-legitimation:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
      else
        ESX.ShowAdvancedNotification('Individual actions', '', _U('nobody_near'), 'CHAR_DEFAULT', 8)
      end
    end]]
    end,
    function(data, menu)
      menu.close()
    end
  )
end

--Vehicle Menu

function OpenVehicleMenu()

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'vehicle_actions',
    {
      title    = 'Insert Vehicle Menu',
      align    = 'top-left',
      elements = {
       -- {label = _U('engine'),           value = 'engine'},
        {label = _U('doors'),        value = 'door'},
        {label = _U('window'),         value = 'window'},
        --{label = _U('cruise_control'),   value = 'cruise_control'},
        {label = _U('shuff'),      value = 'changeseat'},
      }
    },
    function(data, menu)
      if data.current.value == 'engine' then
        local playerPed = GetPlayerPed(-1)
          local playerVeh = GetVehiclePedIsIn(playerPed, false)
        if engineOn == true then
                SetVehicleUndriveable(playerVeh, true)
            SetVehicleEngineOn(playerVeh, false, false, false)
            engineOn = false
            TriggerEvent("pNotify:SendNotification", {text = _U('turned_off_engine'), type = "error", queue = "vehiclemenu", timeout = 1000, layout = "bottomLeft"})
        else
          SetVehicleUndriveable(playerVeh, false)
            SetVehicleEngineOn(playerVeh, true, false, false)       
                engineOn = true
            TriggerEvent("pNotify:SendNotification", {text = _U('turned_on_engine'), type = "success", queue = "vehiclemenu", timeout = 1000, layout = "bottomLeft"})
        end
      end

      if data.current.value == 'changeseat' then
        ExecuteCommand("shuff")
      end

      if data.current.value == 'door' then
        ESX.UI.Menu.CloseAll()

        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'door_actions',
          {
            title    = _U('doors'),
            align    = 'top-left',
            elements = {
              {label = _U('hood'),        value = 'hood'},
              {label = _U('trunk'),           value = 'trunk'},
              {label = _U('front_left_door'),   value = 'dooravg'},
              {label = _U('front_right_door'),     value = 'dooravd'},
              {label = _U('back_left_door'),      value = 'doorarg'},
              {label = _U('back_right_door'),      value = 'doorard'},
              {label = _U('close_all'),      value = 'closeall'}
            }
          },
          function(data, menu)
            if data.current.value == 'hood' then
              local playerPed = GetPlayerPed(-1)
                local playerVeh = GetVehiclePedIsIn(playerPed, false)
                if (IsPedSittingInAnyVehicle(playerPed)) then
                  if GetVehicleDoorAngleRatio(playerVeh, 4) > 0.0 then 
                      SetVehicleDoorShut(playerVeh, 4, false)
                      TriggerEvent("pNotify:SendNotification", {text = "Hood closed!", type = "error", queue = "vehiclemenu", timeout = 1000, layout = "bottomLeft"})
                   else
                      SetVehicleDoorOpen(playerVeh, 4, false)
                      frontleft = true
                      TriggerEvent("pNotify:SendNotification", {text = "Hood opened!", type = "success", queue = "vehiclemenu", timeout = 1000, layout = "bottomLeft"})
                    end
                end
            end
            if data.current.value == 'trunk' then
              local playerPed = GetPlayerPed(-1)
                local playerVeh = GetVehiclePedIsIn(playerPed, false)
                if ( IsPedSittingInAnyVehicle( playerPed ) ) then
                   if GetVehicleDoorAngleRatio(playerVeh, 5) > 0.0 then 
                      SetVehicleDoorShut(playerVeh, 5, false)
                      TriggerEvent("pNotify:SendNotification", {text = _U('closed_hood'), type = "error", queue = "vehiclemenu", timeout = 1000, layout = "bottomLeft"})
                    else
                      SetVehicleDoorOpen(playerVeh, 5, false)
                      frontleft = true
                      TriggerEvent("pNotify:SendNotification", {text = _U('opened_hood'), type = "success", queue = "vehiclemenu", timeout = 1000, layout = "bottomLeft"})    
                   end
                end
            end
            if data.current.value == 'dooravg' then
              local playerPed = GetPlayerPed(-1)
                local playerVeh = GetVehiclePedIsIn(playerPed, false)
                if ( IsPedSittingInAnyVehicle( playerPed ) ) then
                   if GetVehicleDoorAngleRatio(playerVeh, 0) > 0.0 then 
                      SetVehicleDoorShut(playerVeh, 0, false)
                      TriggerEvent("pNotify:SendNotification", {text = _U('closed_door'), type = "error", queue = "vehiclemenu", timeout = 1000, layout = "bottomLeft"})
                    else
                      SetVehicleDoorOpen(playerVeh, 0, false)
                      frontleft = true
                      TriggerEvent("pNotify:SendNotification", {text = _U('opened_door'), type = "success", queue = "vehiclemenu", timeout = 1000, layout = "bottomLeft"})
                   end
                end
            end
            if data.current.value == 'dooravd' then
              local playerPed = GetPlayerPed(-1)
                local playerVeh = GetVehiclePedIsIn(playerPed, false)
                if ( IsPedSittingInAnyVehicle( playerPed ) ) then
                   if GetVehicleDoorAngleRatio(playerVeh, 1) > 0.0 then 
                      SetVehicleDoorShut(playerVeh, 1, false)
                      TriggerEvent("pNotify:SendNotification", {text = _U('closed_door'), type = "error", queue = "vehiclemenu", timeout = 1000, layout = "bottomLeft"})
                    else
                      SetVehicleDoorOpen(playerVeh, 1, false)
                      frontleft = true
                      TriggerEvent("pNotify:SendNotification", {text = _U('opened_door'), type = "success", queue = "vehiclemenu", timeout = 1000, layout = "bottomLeft"})  
                   end
                end
            end
            if data.current.value == 'doorarg' then
              local playerPed = GetPlayerPed(-1)
                local playerVeh = GetVehiclePedIsIn(playerPed, false)
                if ( IsPedSittingInAnyVehicle( playerPed ) ) then
                   if GetVehicleDoorAngleRatio(playerVeh, 2) > 0.0 then 
                      SetVehicleDoorShut(playerVeh, 2, false)
                      TriggerEvent("pNotify:SendNotification", {text = _U('closed_door'), type = "error", queue = "vehiclemenu", timeout = 1000, layout = "bottomLeft"})
                    else
                      SetVehicleDoorOpen(playerVeh, 2, false)
                      frontleft = true
                      TriggerEvent("pNotify:SendNotification", {text = _U('opened_door'), type = "success", queue = "vehiclemenu", timeout = 1000, layout = "bottomLeft"})     
                   end
                end
            end
            if data.current.value == 'doorard' then
              local playerPed = GetPlayerPed(-1)
                local playerVeh = GetVehiclePedIsIn(playerPed, false)
                if ( IsPedSittingInAnyVehicle( playerPed ) ) then
                   if GetVehicleDoorAngleRatio(playerVeh, 3) > 0.0 then 
                      SetVehicleDoorShut(playerVeh, 3, false)
                      TriggerEvent("pNotify:SendNotification", {text = _U('closed_door'), type = "error", queue = "vehiclemenu", timeout = 1000, layout = "bottomLeft"})
                    else
                      SetVehicleDoorOpen(playerVeh, 3, false)
                      frontleft = true
                      TriggerEvent("pNotify:SendNotification", {text = _U('opened_door'), type = "success", queue = "vehiclemenu", timeout = 1000, layout = "bottomLeft"})
                   end
                end
            end
            if data.current.value == 'closeall' then
              local playerPed = GetPlayerPed(-1)
                local playerVeh = GetVehiclePedIsIn(playerPed, false)
                if ( IsPedSittingInAnyVehicle( playerPed ) ) then
                   if GetVehicleDoorAngleRatio(playerVeh, 3) > 0.0 then
                      SetVehicleDoorShut(playerVeh, 0, false)
                      SetVehicleDoorShut(playerVeh, 1, false)
                      SetVehicleDoorShut(playerVeh, 2, false) 
                      SetVehicleDoorShut(playerVeh, 3, false)
                      SetVehicleDoorShut(playerVeh, 4, false) 
                      SetVehicleDoorShut(playerVeh, 5, false)
                      TriggerEvent("pNotify:SendNotification", {text = _U('closed_all'), type = "error", queue = "vehiclemenu", timeout = 1000, layout = "bottomLeft"})
                   end
                end
            end
          end,
        function(data, menu)
          menu.close()
          OpenVehicleMenu()
        end
        )
      end
      if data.current.value == 'window' then
        ESX.UI.Menu.CloseAll()

        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'window_actions',
          {
            title    = _U('window_menu'),
            align    = 'top-left',
            elements = {
              {label = _U('front_left_window'),   value = 'windowavga'},
              {label = _U('front_right_window'),   value = 'windowavdr'},
              {label = _U('back_left_window'),   value = 'windowarga'},
              {label = _U('back_right_window'),   value = 'windowardr'}
            }
          },
          function(data, menu)
            if data.current.value == 'windowavga' then
              local playerPed = GetPlayerPed(-1)
                local playerVeh = GetVehiclePedIsIn(playerPed, false)
                if windowavg == false then
                      RollDownWindow(playerVeh, 0)
                      windowavg = true
                      TriggerEvent("pNotify:SendNotification", {text = _U('opened_window'), type = "succes", queue = "vehiclemenu", timeout = 1000, layout = "bottomLeft"})
                else
                  RollUpWindow(playerVeh, 0)
                      windowavg = false
                  TriggerEvent("pNotify:SendNotification", {text = _U('closed_wondow'), type = "error", queue = "vehiclemenu", timeout = 1000, layout = "bottomLeft"})
                end
            end
            if data.current.value == 'windowavdr' then
              local playerPed = GetPlayerPed(-1)
                local playerVeh = GetVehiclePedIsIn(playerPed, false)
                if windowavd == false then
                      RollDownWindow(playerVeh, 1)
                      windowavd = true
                  TriggerEvent("pNotify:SendNotification", {text = _U('opened_window'), type = "success", queue = "vehiclemenu", timeout = 1000, layout = "bottomLeft"})
                else
                  RollUpWindow(playerVeh, 1)
                      windowavd = false
                  TriggerEvent("pNotify:SendNotification", {text = _U('closed_wondow'), type = "error", queue = "vehiclemenu", timeout = 1000, layout = "bottomLeft"})
                end
            end
            if data.current.value == 'windowarga' then
              local playerPed = GetPlayerPed(-1)
                local playerVeh = GetVehiclePedIsIn(playerPed, false)
                if windowarg == false then
                      RollDownWindow(playerVeh, 2)
                      windowarg = true
                  TriggerEvent("pNotify:SendNotification", {text = _U('opened_window'), type = "success", queue = "vehiclemenu", timeout = 1000, layout = "bottomLeft"})
                else
                  RollUpWindow(playerVeh, 2)
                      windowarg = false
                  TriggerEvent("pNotify:SendNotification", {text = _U('closed_wondow'), type = "error", queue = "vehiclemenu", timeout = 1000, layout = "bottomLeft"})
                end
            end
            if data.current.value == 'windowardr' then
              local playerPed = GetPlayerPed(-1)
                local playerVeh = GetVehiclePedIsIn(playerPed, false)
                if windoward == false then
                      RollDownWindow(playerVeh, 3)
                      windoward = true
                  TriggerEvent("pNotify:SendNotification", {text = _U('opened_window'), type = "success", queue = "vehiclemenu", timeout = 1000, layout = "bottomLeft"})
                else
                  RollUpWindow(playerVeh, 3)
                      windoward = false
                  TriggerEvent("pNotify:SendNotification", {text = _U('closed_wondow'), type = "error", queue = "vehiclemenu", timeout = 1000, layout = "bottomLeft"})
                end
            end
          end,
        function(data, menu)
          menu.close()
          OpenVehicleMenu()
        end
        )
      end
      if data.current.value == 'cruise_control' then
        ESX.UI.Menu.CloseAll()

        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'cruise_control_actions',
          {
            title    = _U('cruise_control'),
            align    = 'top-left',
            elements = {
              {label = _U('disabled'),   value = 'none'},
              {label = '30Km/h',    value = '30'},
              {label = '55Km/h',    value = '55'},
              {label = '110Km/h',   value = '110'},
            }
          },
          function(data, menu)
            if data.current.value == 'none' then
              local playerPed = GetPlayerPed(-1)
                local playerVeh = GetVehiclePedIsIn(playerPed, false)
                local modelVeh  = GetEntityModel(playerVeh)
                local maxSpeed  = GetVehicleMaxSpeed(modelVeh)
                SetEntityMaxSpeed(playerVeh, maxSpeed)
                TriggerEvent("pNotify:SendNotification", {text = _U('disabled_cruise_control'), type = "error", queue = "vehiclemenu", timeout = 1000, layout = "bottomLeft"})
            end
            if data.current.value == '30' then
              local speedkm   = 30
              local speed   = speedkm/3.6
              local playerPed = GetPlayerPed(-1)
                local playerVeh = GetVehiclePedIsIn(playerPed, false)
                SetEntityMaxSpeed(playerVeh, speed)
                TriggerEvent("pNotify:SendNotification", {text = "You put the cruise control on 30Km/h", type = "info", queue = "vehiclemenu", timeout = 1000, layout = "bottomLeft"})
            end
            if data.current.value == '55' then
              local speedkm   = 55
              local speed   = speedkm/3.6
              local playerPed = GetPlayerPed(-1)
                local playerVeh = GetVehiclePedIsIn(playerPed, false)
                SetEntityMaxSpeed(playerVeh, speed)
                TriggerEvent("pNotify:SendNotification", {text = "You put the cruise control on 50Km/h", type = "info", queue = "vehiclemenu", timeout = 1000, layout = "bottomLeft"})
            end
            if data.current.value == '110' then
              local speedkm   = 110
              local speed   = speedkm/3.6
              local playerPed = GetPlayerPed(-1)
                local playerVeh = GetVehiclePedIsIn(playerPed, false)
                SetEntityMaxSpeed(playerVeh, speed)
                TriggerEvent("pNotify:SendNotification", {text = "You put the cruise control on 100Km/h", type = "info", queue = "vehiclemenu", timeout = 1000, layout = "bottomLeft"})
            end
          end,
        function(data, menu)
          menu.close()
          OpenVehicleMenu()
        end
        )
      end
    end,
  function(data, menu)
    menu.close()
    OpenCivilianActionsMenu()
  end
  )
end

-- Close the ID card
-- Key events
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlPressed(0, 322) or IsControlPressed(0, 177) and cardOpen then
			SendNUIMessage({
				action = "close"
			})
			cardOpen = false
		end
	end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if IsControlPressed(0, Keys["F1"]) then
      OpenCivilianActionsMenu()
    end
  end
end)

-- B??lte


local speedBuffer  = {}
local velBuffer    = {}
local beltOn       = false
local wasInCar     = false

IsCar = function(veh)
        local vc = GetVehicleClass(veh)
        return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
        end 

Fwv = function (entity)
        local hr = GetEntityHeading(entity) + 90.0
        if hr < 0.0 then hr = 360.0 + hr end
        hr = hr * 0.0174533
        return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
      end

--[[Citizen.CreateThread(function()
  Citizen.Wait(250)
  while true do
    
    local ped = GetPlayerPed(-1)
    local car = GetVehiclePedIsIn(ped)
    
    if car ~= 0 and (wasInCar or IsCar(car)) then
    
      wasInCar = true
      
      if beltOn then DisableControlAction(0, 75) end

--      if beltOn and IsControlJustReleased(29)
--        TriggerEvent("pNotify:SendNotification", {text = "Du har b??lte p?? dig!", type = "error", queue = "belt", timeout = 1000, layout = "bottomLeft"})
--      end
      
      speedBuffer[2] = speedBuffer[1]
      speedBuffer[1] = GetEntitySpeed(car)
      
      if speedBuffer[2] ~= nil 
         and not beltOn
         and GetEntitySpeedVector(car, true).y > 1.0  
         and speedBuffer[1] > 19.25 
         and (speedBuffer[2] - speedBuffer[1]) > (speedBuffer[1] * 0.255) then
         
        local co = GetEntityCoords(ped)
        local fw = Fwv(ped)
        SetEntityCoords(ped, co.x + fw.x, co.y + fw.y, co.z - 0.47, true, true, true)
        SetEntityVelocity(ped, velBuffer[2].x, velBuffer[2].y, velBuffer[2].z)
        Citizen.Wait(1)
        SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
      end
        
      velBuffer[2] = velBuffer[1]
      velBuffer[1] = GetEntityVelocity(car)
        
      if IsControlJustReleased(0, 29) then
        beltOn = not beltOn         
        if beltOn then  TriggerEvent("pNotify:SendNotification", {text = _U('seatbelt_on'), type = "success", queue = "belt", timeout = 1000, layout = "bottomLeft"})
        else TriggerEvent("pNotify:SendNotification", {text = _U('seatbelt_off'), type = "error", queue = "belt", timeout = 1000, layout = "bottomLeft"}) end
      end
      
    elseif wasInCar then
      wasInCar = false
      beltOn = false
      speedBuffer[1], speedBuffer[2] = 0.0, 0.0
    end
    Citizen.Wait(250)
  end
end)]]--

local disableShuffle = true
function disableSeatShuffle(flag)
  disableShuffle = flag
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(250)
    if IsPedInAnyVehicle(GetPlayerPed(-1), false) and disableShuffle then
      if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
        if GetIsTaskActive(GetPlayerPed(-1), 165) then
          SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
        end
      end
    end
  end
end)

RegisterNetEvent("SeatShuffle")
AddEventHandler("SeatShuffle", function()
  if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
    disableSeatShuffle(false)
    Citizen.Wait(5000)
    disableSeatShuffle(true)
  else
    CancelEvent()
  end
end)

RegisterCommand("shuff", function(source, args, raw) --change command here
    TriggerEvent("SeatShuffle")
end, false)
