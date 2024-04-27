

util.AddNetworkString( "SelectWeapon" )
util.AddNetworkString( "SelectEquipment" )
util.AddNetworkString( "SelectEquipment2" )

local PLY = FindMetaTable( "Player" )

function PLY:SetEquipment( equip )
	self.Equipment[ 1 ] = equip
	print( type( equip ) )
	self:SetNWString( "Equipment1", equip )
end

function PLY:SetEquipment2( equip )
	self.Equipment[ 2 ] = equip
	print( type( equip ) )
	self:SetNWString( "Equipment2", equip )
end
 
function PLY:SetSelectedWeapon( wep )
	self.SelectedWeapon = wep
end

function PLY:GetSelectedWeapon()
	return self.SelectedWeapon 
end

function PLY:SetUpLoadout()
	self.Equipment = {}
	self:SetEquipment( tostring( table.Random( LDT.Equipment ) ), tostring( table.Random( LDT.Equipment2 ) ) )
	self:SetSelectedWeapon( tostring( table.Random( LDT.Weapons ) ) )
	self.Data = {}
end

function PLY:ApplyLoadOut()
	hook.Call( "OnLoadoutGiven", GAMEMODE, self, self:GetSelectedWeapon()  )
end

net.Receive( "SelectWeapon", function( len, ply ) 
	ply:SetSelectedWeapon( net.ReadString() )
end)

net.Receive( "SelectEquipment", function( len, ply )
	ply.TempEquipment1 = net.ReadString()
end)

net.Receive( "SelectEquipment2", function( len, ply )
	ply.TempEquipment2 = net.ReadString()
end)