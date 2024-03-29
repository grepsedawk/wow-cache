WCH8             9,  �c��V���Y  �8X(*  6        Y       {  �        :    �2c  �  �2  �%  "&        7.0 Artifacts - Rogue - Combat - Acquisition - Pre-Scenario - Ship Leaves - Init - GJC fadeToBlack = 964
scene:ApplyScreenEffect(fadeToBlack)
--Wait(1)
scene:SetFadeRegion(100, true)
scene:AddFadeRegionExcludedGameObject(246406)

boatID = "world\\expansion06\\doodads\\artifact\\pirateship_doodad.m2"
--boatID = "world\\expansion04\\doodads\\alliance\\boat\\transport_alliance_battleship.m2"
boatPath01 = 16045
boat = SpawnModelActor(boatID, -14323.8, 534.642, 7.72398, 80.4455, 1, false)
local tethysbunnyCreatureID = 76657
tethys = SpawnActor( tethysbunnyCreatureID, -14323.8, 534.642, 7.72398, 80.4455, 1, false ) 
FadeOut(boat, 0)
boat:SetFacingToAbs(Vector:New(-14336.1, 492.78, -0.465782) )
boat:SetSnapToGround ( false )
--boat:SetHoverHeight( 80.4455 )
--Wait(0.75)
FadeIn(boat, 0)
--scene:ClearScreenEffect(fadeToBlack)
SendTrigger("Smooth Phase Complete")				 Main 
----------------------------------------------
-- Main
----------------------------------------------

   
scene:ApplyScreenEffect( 827 )
scene:SetFadeRegion(55, true)
scene:WaitTimer(1)
isLoaded("all")
scene:WaitTimer(0)

-- WoWEdit Actors
AddWowEditItemsCoroutine()

scene:WaitTimer(0)
  
for i,v in ipairs(envActors) do
--print(v:GetPosition())
	table.insert(allActors, v)
end
--scene:SetRelativeCoords(true)
--envActors2 = scene:CreateActorsAndWaitForLoad(ExportedActorDataRelative, .01)
--scene:WaitTimer(0.1)
--thisAssetGroup = createAssetGroups()
--- Spawn fake WMO Actor
AddActorsCoroutine()
scene:WaitTimer(0.1)
--WMOActor = createWMOAsset(WMOPOS[1], WMOPOS[2])





 

--scene:SetCamera(0, 0, nil, nil)
--scene:SetCamera(368, 0, nil, nil)
--scene:ApplyScreenEffect( 827 )
--Wait(23)
--scene:EndScene()

scene:WaitTimer(1)
playMusic()

--scene:ClearScreenEffect(827)

--addSubtitle()
createM2Camera()
scene:ClearScreenEffect(827)
--createPointCam(CameraTransforms)
--attachToCamera(genericActorGroup)
sceneComplete = AddTrackCameraCoroutine()


afterXSeconds = 6
playTitle(afterXSeconds) Blackrock Train Depot - Leave the Grimrail - Storyboard scene:SetFadeRegion(100,true)
genericFOV90 = 368
SceneModels = {
	Steam = "World\\Expansion05\\Doodads\\Ashrand\\Doodads\\6AR_Steam_C02.m2",
	Rug = "WORLD\\EXPANSION05\\DOODADS\\IRONHORDE\\6IH_IRONHORDE_Rug01.M2",
	Fire = "WORLD\\EXPANSION05\\DOODADS\\FX\\6FX_Bonfire_Wind_withSmoke_doodad.M2",
	Explosion = "SPELLS\\EXPLOSION_FIRE_IMPACT_ROTATEME.M2",
	Plume = "SPELLS\\Vertical_Plume_Explosion.M2",
	Invis = "SPELLS\\INVISIBLE.m2",
}
party = SpawnPlayerGroupAtPoints(12731, 1, true)
cannon = SpawnActor(80918,1646.77,2053.75,121.562,180,1,false)
music = cannon:PlayMusic(49071) -- Music
local dummyPath = scene:LoadPath(12762).nodes[1].pos
cannonFacingDummy = SpawnActor(89184,dummyPath.x,dummyPath.y,dummyPath.z,0,1,false)
cannon:SetFacingToTarget(cannonFacingDummy,Vector:New())
dummyPath = nil
SpawnModelActor(SceneModels.Rug,1646.72, 2122.47, 121.797, 122.11,1,false)
wheelSet1,wheelSet2 = {},{}
cannon:PlaySoundKit(14951,true)
local wheels = SpawnActorsAtPoints(89181,12751,false)
for i=1,4 do
	if i>1 and i<4 then
		table.insert(wheelSet2,wheels[i])
	else
		table.insert(wheelSet1,wheels[i])
	end
end
for _,wheel in pairs(wheelSet1) do
	wheel:PlayLoopingAnimKit(4397)
end
regulator = SpawnActor(89182,1646.55,2109.86,123.455,89.9026,1,false)
engines = SpawnActorsAtPoints(89183,12759,false)

function Actor:ResetActorOnTrigger(event,fastAnim)
	WaitForTrigger(event)
	if not fastAnim then
		self:PlayOneShotFullBodyAnim(Animations.None)
	end
	self:ClearHeadFacing()
	self:ClearFacing()
	self:SetFacingTurnRate(5)
end

--Shot 1: Players approach main car
do	
	--Camera Control
	MoveCameraToPathStart(genericFOV90,0,12701,12711)
	SetCameraFollowPath(genericFOV90,0,12701,12711,3)
	
	--Player Movement
	local move1 = scene:LoadPath(12735)
	for k,player in pairs(party) do
		player:MoveToAbs(move1.nodes[k].pos,2.5)
	end
	
	Wait(2.1)
end

--Shot 2: Players move / interact with explosives
do
	SendTrigger("Shot2")
	
	--Camera Control
	MoveCameraToPathStart(genericFOV90,0,12718,12721)
	SetCameraFollowPath(genericFOV90,0,12718,12721,4)
	
	Wait(3.5)
	SendTrigger("Shot2Stop")
end

--Shot 3: Players rush to cover, explosions
bombList = nil
bombTickingSound = nil
do
	bombList = SpawnActorsAtPoints(89180,12722,false)
	for k,bomb in pairs(bombList) do
		bomb:PlayOneShotAnimKit(7651)
		bomb:SetFacingToAbs(Vector:New(1646.82, 2003.39, 107.765))
	end
	bombTickingSound = bombList[1]:PlaySoundKit(48826,false)
	local move3 = scene:LoadPath(12743)
	local look3 = scene:LoadPath(12750)
	for k,player in pairs(party) do
		player:MoveToAbs(move3.nodes[k].pos,0)
		player:SetFacingToAbs(look3.nodes[1].pos)
		player:PlayLoopingAnimKit(7652)
	end
	SendTrigger("Shot3")
	
	--Camera Control
	MoveCameraToPathStart(genericFOV90,0,12724,12726)
	SetCameraFollowPath(genericFOV90,0,12724,12726,2)
	
	Wait(2)
	SendTrigger("Shot3Stop")
end

--Shot 4: Quick Explosion
do
	SendTrigger("Shot4")
	--Camera Control
	MoveCameraToPathStart(genericFOV90,0,12747,12749)
	
	Wait(0.75)
	bombList[1]:PlaySpellCastVisual(41692)
	bombTickingSound:Stop()
	local shake1 = scene:AddCameraEffect(40,bombList[3]:GetPosition(), nil, 1)
	Wait(0.5)
	bombList[3]:PlaySpellCastVisual(41692)
	Wait(0.65)
	bombList[2]:PlaySpellCastVisual(41692)
	Wait(2)
	scene:RemoveCameraEffect(shake1)
	scene:ApplyScreenEffect(827)
	Wait(1)
	SendTrigger("Shot4Stop")	
end

--Shot 5: Players move to control panel, seen through window
do
	local move5 = scene:LoadPath(12752)
	local look5 = scene:LoadPath(12753)
	for k,player in pairs(party) do
		player:SetSnapToGround(false)
		player:MoveToAbs(move5.nodes[k].pos,0)
		player:SetFacingToAbs(look5.nodes[k].pos)
	end
	
	--Camera Control
	MoveCameraToPathStart(genericFOV90,0,12717,12716)
	scene:ClearScreenEffect(827)
	Wait(0.5)
	SendTrigger("Shot5")
	 [1] Blackrock Train Depot - Leave the Grimrail - Storyboard SetCameraFollowPath(genericFOV90,0,12717,12716,3.5)
	
	Wait(3.5)
	SendTrigger("Shot5Stop")
end

--Shot 6: Players use console, seen from behind
do
	local move6 = scene:LoadPath(12757)
	local look6 = scene:LoadPath(12758)
	for k,player in pairs(party) do
		player:SetSnapToGround(false)
		player:MoveToAbs(move6.nodes[k].pos,0)
		player:SetFacingToAbs(look6.nodes[k].pos)
	end
	SendTrigger("Shot6")
	
	--Camera Control
	MoveCameraToPathStart(genericFOV90,0,12727,12728)
	SetCameraFollowPath(genericFOV90,0,12727,12728,4)
	local soundDummies = SpawnModelActorsAtPoints(SceneModels.Invis,12760,false,1)
	cannon:PlaySoundKit(49029,true)
	soundDummies[1]:PlaySoundKit(48882,true)
	Wait(0.3)
	for _,wheel in pairs(wheelSet2) do
		wheel:PlayLoopingAnimKit(7653)
	end
	Wait(0.3)
	soundDummies[2]:PlaySoundKit(48882,true)
	for _,wheel in pairs(wheelSet1) do
		wheel:PlayLoopingAnimKit(7653)
	end
	Wait(0.2)
	for _,engine in pairs(engines) do
		engine:PlayLoopingAnimKit(7655)
	end
	Wait(0.8)
	soundDummies[1]:PlaySoundKit(48882,true)
	for _,engine in pairs(engines) do
		engine:PlayLoopingAnimKit(7656)
	end
	SteamVents = SpawnModelActorsAtPoints(SceneModels.Steam,12760,false,1)
	Wait(0.8)
	local Fires = SpawnModelActorsAtPoints(SceneModels.Fire,12761,false,1)
	for _,engine in pairs(engines) do
		engine:PlayLoopingAnimKit(7657)
	end
	Wait(1.6)
	for _,fire in pairs(Fires) do
		fire:Fade(0,0)
		fire:Despawn()
	end
end

--Shot 7: Player jump out window, gun rotates, fade out
do
	local Explosions = {}
	for _,wheel in pairs(wheelSet1) do
		wheel:PlayLoopingAnimKit(7660)
	end
	for _,wheel in pairs(wheelSet2) do
		wheel:PlayLoopingAnimKit(7660)
	end
	local jump7 = 12770
	local move7 = scene:LoadPath(12769)
	local look7 = scene:LoadPath(jump7)
	for k,player in pairs(party) do
		player:SetSnapToGround(false)
		player:MoveToAbs(move7.nodes[k].pos,0)
		player:SetFacingToAbs(look7.nodes[k].pos)
	end
	SendTrigger("Shot7")
	
	--Camera Control
	MoveCameraToPathStart(genericFOV90,0,12729,12730)
	SetCameraFollowPath(genericFOV90,0,12729,12730,6)
	
	Wait(0.5)
	Explosions[1] = SpawnModelActorsAtPoints(SceneModels.Explosion,12764,false,1)[1]
	Explosions[1]:PlaySoundKit(49033,true)
	regulator:PlayOneShotAnimKit(6741)
	cannonFacingDummy:FollowPath(12762,1.5)
	local dummyPath = scene:LoadPath(12768).nodes[1].pos
	SpawnActor(89184,dummyPath.x,dummyPath.y,dummyPath.z,0,1,false):PlaySoundKit(49049,true)
	Wait(0.5)
	Explosions[2] = SpawnModelActorsAtPoints(SceneModels.Explosion,12772,false,1)[1]
	Explosions[2]:PlaySoundKit(49033,true)
	cannon:PlayAnimKit(7658,true,Animations.None)
	local Fires = SpawnModelActorsAtPoints(SceneModels.Fire,12761,false,1)
	Wait(0.5)
	Explosions[1]:Fade(0,0)
	Wait(0.5)
	Explosions[2]:Fade(0,0)
	local Plumes = SpawnModelActorsAtPoints(SceneModels.Plume,12771,false,3)[1]
	Explosions[3] = SpawnModelActorsAtPoints(SceneModels.Explosion,12773,false,1)[1]
	Explosions[3]:PlaySoundKit(49033,true)
	Wait(0.5)
	Explosions[4] = SpawnModelActorsAtPoints(SceneModels.Explosion,12774,false,1.5)[1]
	Explosions[4]:PlaySoundKit(49033,true)
	Wait(0.5)
	Explosions[3]:Fade(0,0)
	local shake2 = scene:AddCameraEffect(69,cannon:GetPosition(), nil, 1)
	Wait(0.5)
	Explosions[4]:Fade(0,0)
	Explosions[5] = SpawnModelActorsAtPoints(SceneModels.Explosion,12771,false,3)[1]
	Wait(0.5)
	SpawnModelActorsAtPoints(SceneModels.Explosion,12762,false,3)
	scene:ApplyScreenEffect(1115)
	music:Stop() --Music
	Wait(1)
	Plumes:Fade(0,0)
	Explosions[5]:Fade(0,0)
end
	
Wait(5)
print("Scene Ended normally.")
scene:EndScene()
SendTrigger("normalPhase")
--178494 Garrosh Raid - Corrupted Vale Intro - Main 	scene:ApplyScreenEffect(827)

	genericFOV90 		= 368

	goblins = SpawnActorsAtPoints( 71718, 6661)

	for k,v in pairs(goblins) do
		v:PlayLoopingFullBodyAnim(Animations.EmoteWorkNoSheathe)
	end
	playerSpawnPoints = scene:LoadPath(6670).nodes
	raid = {}
	for k,v in pairs(playerSpawnPoints) do
		table.insert(raid, SpawnPlayerCloneActorByToken( "raid"..(k), v.pos.x, v.pos.y, v.pos.z, v.rot.z, 1, true ))
	end

	door1 = SpawnModelActorAtPoint( "World\\EXPANSION04\\DOODADS\\MOGU\\Mogu_Ancient_Doorway03.M2", 6665, false, 1.5569)
	door2 = SpawnModelActorAtPoint( "World\\EXPANSION04\\DOODADS\\MOGU\\Mogu_TitanVault_Door_01.M2", 6655, false, .391)
	Wait(2)
	scene:ClearScreenEffect(827)
	MoveCameraToPathStart( genericFOV90, 0, 6667, 6669)
	door1:PlayLoopingAnimKit(2452)
	Wait(3)
	scene:ApplyScreenEffect(827)
	Wait(1)

	SetCameraFollowPath( genericFOV90, 0, 6650, 6652, 20)
	scene:ClearScreenEffect(827)
	Wait(16)
	door2:PlayLoopingAnimKit(2452)
	Wait(6.5)
	shabreath = SpawnModelActorAtPoint("SPELLS\\Sha_Breath_02.M2", 6656, false, 2)
	Wait(1)
	scene:ApplyScreenEffect(1010)
	Wait(1)
	shabreath:Despawn()
	scene:TriggerServerEvent("normalPhase")
	for k,v in pairs(goblins) do
		v:StopLoopingFullBodyAnim()
		v:PlaySpellStateVisual(33282)
	end
	shredderActive = false
	zeal = SpawnActorAtPoint(72661,6660)

	Wait(2)
	scene:ClearScreenEffect(1010)
	Wait(2)
	SetCameraFollowReversePath(genericFOV90, 0, 6650, 6652, 20)
	Wait(16.5)
	zeal:WaitPlayOneShotFullBodyAnim(Animations.Emerge)
	Wait(2)
	scene:EndScene() 6  �3  �2  �2  (*  