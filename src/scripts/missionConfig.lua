-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Mission configuration file for the VEAF framework
-- see https://github.com/VEAF/VEAF-Mission-Creation-Tools
--
-- This configuration is tailored for the Syria OpenTraining mission
-- see https://github.com/VEAF/VEAF-Open-Training-Mission-Syria
-------------------------------------------------------------------------------------------------------------------------------------------------------------
veaf.config.MISSION_NAME = "OpenTraining_Syria"
veaf.config.MISSION_EXPORT_PATH = nil -- use default folder

-- play the radio beacons (for the public OT mission)
--TODO (Zip)
veafBeacons = false

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- initialize QRA
-------------------------------------------------------------------------------------------------------------------------------------------------------------
VeafQRA.ToggleAllSilence(false) --this will set all QRA messages ON if the argument is "true" and all QRA messages to OFF is the argument is "false".

if veaf then
    VeafQRA.new()
    :setName("QRA_Palmyra")
	:setTriggerZone("QRA_Palmyra")
    :setZoneRadius(30000)
    :addGroup("QRA_Palmyra")
    
        --NOTE 1 : Remember that only one aircraft group at a time is deployed for each QRA

    --:setQRAcount(QRAcount) --Superior or equal to -1 : Current number of aircraft groups available for deployement. By default this is set to -1 meaning an infinite amount of groups are available, no warehousing is done. -> This is you master arm for the rest of these options.
    --:setQRAmaxCount(maxQRAcount) --Superior or equal to -1 : Maximum number of aircraft groups deployable at any time for the QRA. By default this is set to -1 meaning an infinite amount of aircrafts can be accumulated for deployement. -> Example: a QRA has 2 out of 6 groups ready for deployement, 6 is your maxQRAcount, 2 is your current QRAcount.
    --:setQRAmaxResupplyCount(maxResupplyCount) --Superior or equal to -1 : Total number of aircraft groups which can be resupplied to the QRA. By default this is set to -1 meaning an infinite amount of stock is available. 0 means no stock is available, no resupplies will occur, this is your master arm for resupplies  -> Take the previous example : We are missing 4 groups but only have 3 in stock to resupply the QRA, 3 is your QRAmaxResupplyCount
    --:setQRAminCountforResupply(minCountforResupply) --Equal to -1 or superior to 0 : Number of aircraft groups which the QRA needs to have at all times, otherwise a resupply will be started. By default this is set at -1 which means that a resupply will be started as soon as an aircraft group is lost. -> Take the previous example : This minimum number of deployable groups we desire at all times for our QRA is 1, but we have 2, so no resupply will happen for now. 1 is your minCountforResupply.
    --:setResupplyAmount(resupplyAmount) --Superior or equal to 1 : Number of aircraf groups that will be resupplied to the QRA when a resupply happens. By default it is equal to 1. -> Take the previous example : We just lost both of our groups meaning we only have none left, this will trigger a resupply, a resupply the desired amount of aircraft groups or of however many aircrafts we have in stock if this amount is less. The resupply will also be constrained by the maximum number of groups we can have ready for deployement at once.
    --:setQRAresupplyDelay(resupplyDelay) --Superior or equal to 0 : Time that a resupply will need in order to happen.
    :setQRAcount(1)
    :setQRAmaxCount(2)
    :setQRAminCountforResupply(1)
    :setResupplyAmount(2) 
    :setQRAresupplyDelay(3600)


        --NOTE 2 : only one resupply can happen at a time, they may be scheduled at every possible occasion but will happen one at a time.
        --NOTE 3 : QRA groups that have just arrived from the supply chain will need to be rearmed (see associated delay and constraints)

    --:setAirportLink(airbase_name) --Unit name of the airbase in between " " : QRA will be linked to this airport and will stop operating if the airport is lost (This can be a FARP (use the FARP's unit name), a Ship (use the ship's unit name), an airfield or a building (oil rigs etc.))
    --:setAirportMinLifePercent(value) --Ranges from 0 to 1 : minimum life percentage of the linked airport for the QRA to operate. Airports (runways) and Ships only should lose life when bombed, this needs manual testing to know what works best. Not currently functional due to a DCS bug.
    :setAirportLink("Palmyra")

        --NOTE 1 : QRA that are just being recomissioned after an airbase is retaken will need to be rearmed (see associated delay and constraints)

    --:setDelayBeforeRearming(value) --Delay between the death of a QRA and it being ready for action
    --:setNoNeedToLeaveZoneBeforeRearming() --QRA will be rearmed (and later deployed) even though players are still in the area
    --:setResetWhenLeavingZone() --The QRA will be despawned (and ready-ed up again immediatly) when all players leave the zone. Otherwise the QRA will patrol until they RTB at which point they will despawn on landing and be ready immediatly.
    --:setDelayBeforeActivating(value) --activation delay between units entering the QRA zone and the QRA actually deploying
    :setDelayBeforeRearming(120)
    :setDelayBeforeActivating(60)
    :setNoNeedToLeaveZoneBeforeRearming()

    :setCoalition(coalition.side.RED)
    :addEnnemyCoalition(coalition.side.BLUE)
    :setReactOnHelicopters()
--  :setSilent() --mutes this QRA only, VeafQRA.AllSilence has to be false for this to have an effect
    :start()

    VeafQRA.new()
    :setName("QRA_Bassel")
	:setTriggerZone("QRA_Bassel")
    :setZoneRadius(30000)
    :addGroup("QRA_Bassel")
    :setQRAcount(2)
    :setQRAmaxCount(2)
    :setQRAminCountforResupply(2)
    :setQRAresupplyDelay(3600)
    :setAirportLink("Bassel Al-Assad")
    :setDelayBeforeRearming(120)
    :setDelayBeforeActivating(60)
    :setNoNeedToLeaveZoneBeforeRearming()
    :setCoalition(coalition.side.RED)
    :addEnnemyCoalition(coalition.side.BLUE)
    :setReactOnHelicopters()
    :start()
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- initialize all the scripts
-------------------------------------------------------------------------------------------------------------------------------------------------------------
if veafRadio then
    veaf.loggers.get(veaf.Id):info("init - veafRadio")
    veafRadio.initialize(true)

    if veafBeacons then
        -- add the beacons
        -- veafRadio.startBeacon("Bienvenue-blue", 15, 120, "251.0,124.0,121.5,30.0", "am,am,am,fm", nil, "bienvenue-veaf-fr.mp3", 1.0, 2)
    end
end
if veafSpawn then
    veaf.loggers.get(veaf.Id):info("init - veafSpawn")
    veafSpawn.initialize()
end
if veafGrass then
    veaf.loggers.get(veaf.Id):info("init - veafGrass")
    veafGrass.initialize()
end
if veafCasMission then
    veaf.loggers.get(veaf.Id):info("init - veafCasMission")
    veafCasMission.initialize()
end
if veafTransportMission then
    veaf.loggers.get(veaf.Id):info("init - veafTransportMission")
    veafTransportMission.initialize()
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- change some default parameters
-------------------------------------------------------------------------------------------------------------------------------------------------------------
veaf.DEFAULT_GROUND_SPEED_KPH = 25

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- initialize SHORTCUTS
-------------------------------------------------------------------------------------------------------------------------------------------------------------
if veafShortcuts then
    veaf.loggers.get(veaf.Id):info("init - veafShortcuts")
    veafShortcuts.initialize()

    -- you can add all the shortcuts you want here. Shortcuts can be any VEAF command, as entered in a map marker.
    -- here are some examples :

    -- veafShortcuts.AddAlias(
    --     VeafAlias.new()
    --         :setName("-sa11")
    --         :setDescription("SA-11 Gadfly (9K37 Buk) battery")
    --         :setVeafCommand("_spawn group, name sa11")
    --         :setBypassSecurity(true)
    -- )
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- configure ASSETS
-------------------------------------------------------------------------------------------------------------------------------------------------------------

if veafAssets then
    veaf.loggers.get(veaf.Id):info("Loading configuration")
    veafAssets.Assets = {
		-- list the assets in the mission below
		{sort=1, name="A1-Magic", description="Magic (E-2D)", information="U282.20 (15)", linked="A1-Magic escort"},  
		{sort=2, name="A2-Focus", description="Focus (E-3A)", information="U281.10 (16)", linked="A2-Focus escort"},  
        
        {sort=3, name="CSG-71 Roosevelt", description="Roosevelt (CVN)", information="Tacan 12X RHR\nICLS 11\nU227 (12)\nLink4 227MHz\nACLS available"},  
		{sort=4, name="CSG-74 Stennis", description="Stennis (CVN)", information="Tacan 13X STS\nICLS 13\nU226 (13)\nLink4 226MHz\nACLS available"},  
		{sort=5, name="CSG-01 Tarawa", description="Tarawa (LHA)", information="Tacan 14X TAA\nU225 (14)"},  
        {sort=6, name="CSG Kuznetsov", description="Kuznetsov (CV)", information="V121.5"},
		
        {sort=7, name="T1-Texaco-N", description="Texaco-N (KC-135 MPRS)", information="Tacan 60Y\nU290.10 (17)\nZone NORD", linked="T1-Texaco-N escort"},  
		{sort=8, name="T2-Texaco-S", description="Texaco-S (KC-135 MPRS)", information="Tacan 61Y\nU290.30 (18)\nZone SUD", linked="T2-Texaco-S escort"},  
		{sort=9, name="S1-Shell-N", description="Shell-N (KC-135)", information="Tacan 62Y\nU290.40 (19)\nZone NORD", linked="S1-Shell-N escort"},  
		{sort=10, name="S2-Shell-S", description="Shell-S (KC-135)", information="Tacan 63Y\nU290.50 (20)\nZone SUD", linked="S2-Shell-S escort"},  
        
		{sort=11, name="CVN-74 Stennis S3B-Tanker", description="Texaco-7 (S3-B)", information="Tacan 74X\nU290.70\nZone PA"},  
		{sort=12, name="CVN-71 Roosevelt S3B-Tanker", description="Texaco-8 (S3-B)", information="Tacan 71X\nU290.80\nZone PA"},  
        
		{sort=13, name="Overlordsky", description="100 (A-50, RED)", information="U282.2 (15)", linked="Overlordsky escort"}, 
        {sort=14, name="P1-Petrolsky", description="900 (IL-78M, RED)", information="U290.1 (17)", linked="P1-Petrolsky escort"},  
    }

    veaf.loggers.get(veaf.Id):info("init - veafAssets")
    veafAssets.initialize()
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- configure MOVE
-------------------------------------------------------------------------------------------------------------------------------------------------------------
if veafMove then
    veaf.loggers.get(veaf.Id):info("Setting move tanker radio menus")
    -- keeping the veafMove.Tankers table empty will force veafMove.initialize() to browse the units, and find the tankers
    veaf.loggers.get(veaf.Id):info("init - veafMove")
    veafMove.initialize()
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- configure COMBAT MISSION
-------------------------------------------------------------------------------------------------------------------------------------------------------------

if veafCombatMission then 
	veaf.loggers.get(veaf.Id):info("Loading configuration")

    -- veafCombatMission.addCapMission("CAP-DEF-Kuznetsov-Easy", "CAP over Kuznetzov", "Kill the fighters defending the russian fleet.", true, true)
    veafCombatMission.addCapMission("CAP-Aleppo-Mig21-Fox1", "CAP from Aleppo over Hatay Fox1", "Kill all the ennemy fighters.", true, true)
    veafCombatMission.addCapMission("CAP-Aleppo-Mig29S-Fox3", "CAP from Aleppo over Hatay Fox3", "Kill all the ennemy fighters.", true, true)
    veafCombatMission.addCapMission("CAP-Kuznetsov-Su33-Fox1-Easy", "CAP over Kuznetzov Fox1 Easy", "Kill the fighters defending the russian fleet.", true, true)
    veafCombatMission.addCapMission("CAP-Kuznetsov-Su33-Fox1-Medium", "CAP over Kuznetzov Fox1 Medium", "Kill the fighters defending the russian fleet.", true, true)
    veafCombatMission.addCapMission("CAP-Tabqa-Su27-Fox1", "CAP from Tabqa over CU05 (Scud factory) Fox1", "Kill all the ennemy fighters.", true, true)
    veafCombatMission.addCapMission("CAP-Tabqa-Mig29S-Fox3", "CAP from Tabqa over CU05 (Scud factory) Fox3", "Kill all the ennemy fighters.", true, true)
    veafCombatMission.addCapMission("CAP-Palmyra-Mig21-Fox1", "CAP from Palmyra over CT44 (Desert camp) Fox1", "Kill all the ennemy fighters.", true, true)
    veafCombatMission.addCapMission("CAP-Palmyra-F14A-Fox3", "CAP from Palmyra over CT44 (Desert camp) Fox3 (F14A)", "Kill all the ennemy fighters.", true, true)
    veafCombatMission.addCapMission("CAP-Palmyra-F14B-Fox3", "CAP from Palmyra over CT44 (Desert camp) Fox3 (F14B)", "Kill all the ennemy fighters.", true, true)

    veafCombatMission.AddMission(
		VeafCombatMission.new()
		:setName("ELINT-Mission-West")
		:setFriendlyName("ELINT gathering over the West zone")
		:setBriefing([[
ATIS on 282.125, SAM CONTROL on 282.225
A C-130 pair will fly reciprocical headings, trying to pinpoint enemy SAMS.
Don't let them be destroyed by the enemy !]])
		:addElement(
			VeafCombatMissionElement.new()
			:setName("ELINT-W")
			:setGroups({
				"ELINT-C-130-W-1",
				"ELINT-C-130-W-2"
            })
			:setSkill("Good")
		)
        :setSecured(true)
		:initialize()
	)

    veafCombatMission.AddMission(
		VeafCombatMission.new()
		:setName("ELINT-Mission-East")
		:setFriendlyName("ELINT gathering over the East zone")
		:setBriefing([[
ATIS on 282.125, SAM CONTROL on 282.225
A C-130 pair will fly reciprocical headings, trying to pinpoint enemy SAMS.
Don't let them be destroyed by the enemy !]])
		:addElement(
			VeafCombatMissionElement.new()
			:setName("ELINT-E")
			:setGroups({
				"ELINT-C-130-E-1",
				"ELINT-C-130-E-2"
            })
			:setSkill("Good")
		)
        :setSecured(true)
		:initialize()
	)

    veaf.loggers.get(veaf.Id):info("init - veafCombatMission")
    veafCombatMission.initialize()
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- configure COMBAT ZONE
-------------------------------------------------------------------------------------------------------------------------------------------------------------
if veafCombatZone then 
    veaf.loggers.get(veaf.Id):info("Loading configuration")

	veafCombatZone.AddZone(
		VeafCombatZone.new()
			:setMissionEditorZoneName("combatZone_desertRangeEasy")
			:setFriendlyName("Training at KhalKhalah Desert RANGE")
			:setBriefing("The KhalKhalah RANGE is located 35 nm east of the KhalKhalah airbase, in the desert")
            :setTraining(true)
	)

    veafCombatZone.AddZone(
		VeafCombatZone.new()
			:setMissionEditorZoneName("combatZone_Camp")
			:setFriendlyName("Camp militaire")
			:setBriefing(
[[Nos services de renseignements on localisé un camp Syrien aux coordonnés N33°46’423 E37°19’659 // 37S CT 45146 38323 qui sert de camp d’entrainement aux TALIBAN pour déstabiliser nos défenses par des actions kamikazes. 
Il est impératif de neutraliser ce camp avant que les premiers Djihadistes aient fini leur formation.
Les photos prises par les Mirages F1 de la ER 2/33 montre quelques ZU-23, mais il y a une grande possibilité de présence de MANPADS]])
    )

	veafCombatZone.AddZone(
		VeafCombatZone.new()
			:setMissionEditorZoneName("combatZone_SCUD_Factory")
			:setFriendlyName("combatZone_SCUD_Factory")
			:setBriefing("TBD briefing for combatZone_SCUD_Factory")
	)

	veafCombatZone.AddZone(
		VeafCombatZone.new()
			:setMissionEditorZoneName("combatZone_antakya")
			:setFriendlyName("Antakya Urban Operations")
            :setBriefing("Destroy the road block located on the West of Antakya City\nNeutralize streets patrols.\nNo fly zone on North-East (Manpads)!")
            :setTraining(true)
	)

    veafCombatZone.AddZone(
		VeafCombatZone.new()
			:setMissionEditorZoneName("combatZone_rangeKiryatEasy")
			:setFriendlyName("Kiryat RANGE - easy")
			:setBriefing("The Kiryat RANGE (located 7 nm south of Kiryat airbase) is set-up for training with defenseless targets")
            :setTraining(true)
	)

	veafCombatZone.AddZone(
		VeafCombatZone.new()
			:setMissionEditorZoneName("combatZone_rangeKiryatMedium")
			:setFriendlyName("Kiryat RANGE - medium")
            :setBriefing("The Kiryat RANGE (located 7 nm south of Kiryat airbase) is set-up for training with some defense")
            :setTraining(true)
	)

    veafCombatZone.AddZone(
		VeafCombatZone.new()
			:setMissionEditorZoneName("combatzone_ProtectHama")
			:setFriendlyName("Protect HAMA")
			:setBriefing(
[[Les alliés protègent des archéologues occupés à étudier les ruines proches du stade de HAMA.
On nous a averti qu'un convoi d'artillerie autotractée était en cours d'acheminement (ETA 30 minutes).
Ce sont nos cibles principales !
La zone de rassemblement du convoi est protégée par des blindés et de la défense anti-aérienne (cibles secondaires)
]])
    )

    veaf.loggers.get(veaf.Id):info("init - veafCombatZone")
    veafCombatZone.initialize()

end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- configure WW2 settings based on loaded theatre
-------------------------------------------------------------------------------------------------------------------------------------------------------------
local theatre = string.lower(env.mission.theatre)
veaf.loggers.get(veaf.Id):info(string.format("theatre is %s", theatre))
veaf.config.ww2 = false
if theatre == "thechannel" then
    veaf.config.ww2 = true
elseif theatre == "normandy" then
    veaf.config.ww2 = true
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- configure NAMEDPOINTS
-------------------------------------------------------------------------------------------------------------------------------------------------------------
if veafNamedPoints then

    veaf.loggers.get(veaf.Id):info("Loading configuration")

    veaf.loggers.get(veaf.Id):info("init - veafNamedPoints")
    if theatre == "syria" then
        veafNamedPoints.Points = {
            -- Turkish Airports
            {name="INCIRLIK AB", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("37.001944", "35.425833"), {atc=true, tower="V129.40, U360.10", tacan="21X", runways={{name="05", hdg=50, ils="109.30"}, {name="23", hdg=230, ils="111.70"}}})},
            {name="ADANA SAKIRPASA INTL", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("36.981944", "35.280278"), {atc=true, tower="V121.10, U251.00", runways={{name="05", hdg=51, ils="108.70"}, {name="23", hdg=231}}})},
            {name="HATAY AIRPORT", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("36.360278", "36.285000"), {atc=true, tower="V128.50, U250.25", runways={{name="04", hdg=40, ils="108.90"}, {name="22", hdg=220, ils="108.15"}}})},
            {name="GANZIANTEP",point=veafNamedPoints.addDataToPoint(coord.LLtoLO("36.947057", "37.478579"), {atc=true, tower="V120.10, U250.05", runways={{name="10", hdg=100}, {name="28", hdg=280, ils="109.10"}}})},

            -- Syrian Airports
            {name="MINAKH HELIPT", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("36.521944", "37.041111"), {atc=true, tower="V120.60, U250.80", runways={{name="10", hdg=97}, {name="28", hdg=277}}})},
            {name="ALEPPO INTL", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("36.180556", "37.224167"), {atc=true, tower="V119.10, U250.85", runways={{name="09", hdg=93}, {name="27", hdg=273}}})},
            {name="KUWEIRES AB", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("36.186944", "37.583056"), {atc=true, tower="V120.50, U251.10", runways={{name="10", hdg=97}, {name="28", hdg=277}}})},
            {name="JIRAH AB", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("36.097500", "37.940278"), {atc=true, tower="V118.10, U250.30", runways={{name="10", hdg=96}, {name="28", hdg=276}}})},
            {name="TAFTANAZ HELIPT", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("35.972222", "36.783056"), {atc=true, tower="V122.80, U251.45", runways={{name="10", hdg=100}, {name="28", hdg=280}}})},
            {name="ABU AL DUHUR AB", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("35.732778", "37.101667"), {atc=true, tower="V122.20, U250.45", runways={{name="09", hdg=89}, {name="27", hdg=269}}})},
            {name="TABQA AB", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("35.754444", "38.566667"), {atc=true, tower="V118.50, U251.40", runways={{name="09", hdg=88}, {name="27", hdg=268}}})}, 
            {name="BASSEL AL ASSAD (KHMEIMIM)", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("35.400833", "35.948611"), {atc=true, tower="V118.10, U250.55", runways={{name="17R", hdg=174, ils="109.10"}, {name="17L", hdg=174}, {name="35R", hdg=354}, {name="35L", hdg=354}}})}, 
            {name="HAMA AB", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("35.118056", "36.711111"), {atc=true, tower="V118.05, U250.20", runways={{name="09", hdg=96}, {name="27", hdg=276}}})},
            {name="AL QUSAYR AB", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("34.570833", "36.571944"),  {atc=true, tower="V119.20, U251.55", runways={{name="10", hdg=98}, {name="28", hdg=278}}})}, 
            {name="PALYMYRA AIRPORT", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("34.557222", "38.316667"), {atc=true, tower="V121.90, U250.90", runways={{name="08", hdg=80}, {name="26", hdg=260}}})}, 
            {name="AN NASIRIYAH AB", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("33.918889", "36.866389"), {atc=true, tower="V122.30, U251.65", runways={{name="04", hdg=41}, {name="22", hdg=221}}})},
            {name="AL DUMAYR AB", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("33.609444", "36.748889"), {atc=true, tower="V120.30, U251.95", runways={{name="06", hdg=62}, {name="24", hdg=242}}})}, 
            {name="MEZZEH AB", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("33.477500", "36.223333"), {atc=true, tower="V120.70, U250.75", runways={{name="06", hdg=57}, {name="24", hdg=237}}})}, 
            {name="MARJ AS SULTAN NTH HELIPT", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("33.500278", "36.466944"), {atc=true, tower="V122.70, U250.60", runways={{name="08", hdg=80}, {name="26", hdg=260}}})}, 
            {name="MARJ AS SULTAN STH HELIPT", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("33.486944", "36.475278"), {atc=true, tower="V122.90, U251.90", runways={{name="09", hdg=90}, {name="27", hdg=270}}})}, 
            {name="QABR AS SITT HELIPT", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("33.458611", "36.357500"), {atc=true, tower="V122.60, U250.95", runways={{name="05", hdg=50}, {name="23", hdg=230}}})},
            {name="DAMASCUS INTL", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("33.415000", "36.519444"), {atc=true, tower="V118.50, U251.85", runways={{name="05R", hdg=46}, {name="05L", hdg=46}, {name="23R", hdg=226, ils="109.90"}, {name="23L", hdg=226}}})},
            {name="MARJ RUHAYYIL AB", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("33.286389", "36.457222"), {atc=true, tower="V120.80, U250.65", runways={{name="06", hdg=59}, {name="24", hdg=239}}})},
            {name="KHALKHALAH AB", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("33.077222", "36.558056"), {atc=true, tower="V122.50, U250.35", runways={{name="07", hdg=72}, {name="15", hdg=147}, {name="25", hdg=252}, {name="33", hdg=327}}})},
            {name="SAYQUAL AB",point=veafNamedPoints.addDataToPoint(coord.LLtoLO("33.679816", "37.218204"), {atc=true, tower="V120.40, U251.30", runways={{name="08", hdg=80}, {name="26", hdg=260}}})},
            {name="SHAYRAT AB",point=veafNamedPoints.addDataToPoint(coord.LLtoLO("34.494819", "36.903173"), {atc=true, tower="V120.20, U251.35", runways={{name="11", hdg=110}, {name="29", hdg=290}}})},
            {name="TIYAS AB",point=veafNamedPoints.addDataToPoint(coord.LLtoLO("34.522645", "37.627498"), {atc=true, tower="V120.50, U251.50", runways={{name="09", hdg=90}, {name="27", hdg=270}}})},

            -- Lebanese Airports
            {name="RENE MOUAWAD AB", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("34.589444", "36.011389"), {atc=true, tower="V121.00, U251.20", runways={{name="06", hdg=59}, {name="24", hdg=239}}})},
            {name="HAJAR AB", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("34.283333", "35.680278"),  {atc=true, tower="V121.50, U251.60", runways={{name="02", hdg=25}, {name="20", hdg=205}}})},
            {name="BEIRUT INTL", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("33.821111", "35.488333"), {atc=true, tower="V118.90, U251.80", runways={{name="03", hdg=30, ils="110.70"}, {name="16", hdg=164, ils="110.10"}, {name="17", hdg=175, ils="109.50"}, {name="21", hdg=210}, {name="34", hdg=344}, {name="35", hdg=355}}})},
            {name="RAYAK AB", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("33.852222", "35.990278"),  {atc=true, tower="V124.40, U251.15", runways={{name="04", hdg=42}, {name="22", hdg=222}}})},
            {name="NAQOURA HELIPT",point=veafNamedPoints.addDataToPoint(coord.LLtoLO("33.107877", "35.127728"), {atc=true, tower="V122.00, U251.70"})},

            -- Israeli Airports
            {name="KIRYAT SHMONA AIRPORT", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("33.216667", "35.596667"), {atc=true, tower="V118.40, U250.50", runways={{name="03", hdg=34}, {name="21", hdg=214}}})},
            {name="HAIFA INTL", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("32.809167", "35.043056"), {atc=true, tower="V127.80, U250.15", runways={{name="16", hdg=158}, {name="34", hdg=338}}})},
            {name="RAMAT DAVID INTL", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("32.665000", "35.179444"), {atc=true, tower="V118.60, U251.05", runways={{name="09", hdg=85}, {name="11", hdg=107}, {name="15", hdg=143}, {name="27", hdg=265}, {name="29", hdg=287}, {name="33", hdg=323}}})}, 
            {name="MEGIDDO AIRFIELD", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("32.597222", "35.228611"), {atc=true, tower="V119.90, U250.70", runways={{name="09", hdg=89}, {name="27", hdg=269}}})}, 
            {name="EYN SHEMER AIRFIELD", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("32.440556", "35.007500"), {atc=true, tower="V123.40, U250.00", runways={{name="09", hdg=96}, {name="27", hdg=276}}})}, 

            -- Jordan Airports
            {name="KING HUSSEIN AIR COLLEGE", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("32.356389", "36.259167"), {atc=true, tower="V118.30, U250.40", runways={{name="13", hdg=128}, {name="31", hdg=308}}})},
            {name="H4",point=veafNamedPoints.addDataToPoint(coord.LLtoLO("32.539122", "38.195841"), {atc=true, tower="V122.60, U250.10", runways={{name="10", hdg=100}, {name="28", hdg=280}}})}, 
        }
        veafNamedPoints.addAllSyriaCities()
    elseif theatre == "caucasus" then
        veafNamedPoints.Points = {
            -- airbases in Georgia
            {name="AIRBASE Batumi",  point={x=-356437,y=0,z=618211, atc=true, tower="V131, U260", tacan="16X BTM", runways={{name="13", hdg=125, ils="110.30"}, {name="31", hdg=305}}}},
            {name="AIRBASE Gudauta", point={x=-196850,y=0,z=516496, atc=true, tower="V130, U259", runways={ {name="15", hdg=150}, {name="33", hdg=330}}}},
            {name="AIRBASE Kobuleti",point={x=-318000,y=0,z=636620, atc=true, tower="V133, U262", tacan="67X KBL", runways={ {name="07", hdg=69, ils="111.50"}}}},
            {name="AIRBASE Kutaisi", point={x=-284860,y=0,z=683839, atc=true, tower="V134, U264", tacan="44X KTS", runways={ {name="08", hdg=74, ils="109.75"}, {name="26", hdg=254}}}},
            {name="AIRBASE Senaki",  point={x=-281903,y=0,z=648379, atc=true, tower="V132, U261", tacan="31X TSK", runways={ {name="09", hdg=94, ils="108.90"}, {name="27", hdg=274}}}},
            {name="AIRBASE Sukhumi", point={x=-221382,y=0,z=565909, atc=true, tower="V129, U258", runways={{name="12", hdg=116}, {name="30", hdg=296}}}},
            {name="AIRBASE Tbilisi", point={x=-314926,y=0,z=895724, atc=true, tower="V138, U267", tacan="25X GTB", runways={{name="13", hdg=127, ils="110.30"},{name="31", hdg=307, ils="108.90"}}}},
            {name="AIRBASE Vaziani", point={x=-319000,y=0,z=903271, atc=true, tower="V140, U269", tacan="22X VAS", runways={ {name="13", hdg=135, ils="108.75"}, {name="31", hdg=315, ils="108.75"}}}},
            -- airbases in Russia
            {name="AIRBASE Anapa - Vityazevo",   point={x=-004448,y=0,z=244022, atc=true, tower="V121, U250" , runways={ {name="22", hdg=220}, {name="04", hdg=40}}}},
            {name="AIRBASE Beslan",              point={x=-148472,y=0,z=842252, atc=true, tower="V141, U270", runways={ {name="10", hdg=93, ils="110.50"}, {name="28", hdg=273}}}},
            {name="AIRBASE Krymsk",              point={x=-007349,y=0,z=293712, atc=true, tower="V124, U253", runways={ {name="04", hdg=39}, {name="22", hdg=219}}}},
            {name="AIRBASE Krasnodar-Pashkovsky",point={x=-008707,y=0,z=388986, atc=true, tower="V128, U257", runways={ {name="23", hdg=227}, {name="05", hdg=47}}}},
            {name="AIRBASE Krasnodar-Center",    point={x=-011653,y=0,z=366766, atc=true, tower="V122, U251", runways={ {name="09", hdg=86}, {name="27", hdg=266}}}},
            {name="AIRBASE Gelendzhik",          point={x=-050996,y=0,z=297849, atc=true, tower="V126, U255", runways={ {hdg=40}, {hdg=220}}}},
            {name="AIRBASE Maykop",              point={x=-027626,y=0,z=457048, atc=true, tower="V125, U254", runways={ {name="04", hdg=40}, {name="22", hdg=220}}}},
            {name="AIRBASE Mineralnye Vody",     point={x=-052090,y=0,z=707418, atc=true, tower="V135, U264", runways={ {name="12", hdg=115, ils="111.70"}, {name="30", hdg=295, ils="109.30"}}}},
            {name="AIRBASE Mozdok",              point={x=-083330,y=0,z=835635, atc=true, tower="V137, U266", runways={ {name="08", hdg=82}, {name="26", hdg=262}}}},
            {name="AIRBASE Nalchik",             point={x=-125500,y=0,z=759543, atc=true, tower="V136, U265", runways={ {name="06", hdg=55}, {name="24", hdg=235, ils="110.50"}}}},
            {name="AIRBASE Novorossiysk",        point={x=-040299,y=0,z=279854, atc=true, tower="V123, U252", runways={ {name="04", hdg=40}, {name="22", hdg=220}}}},
            {name="AIRBASE Sochi",               point={x=-165163,y=0,z=460902, atc=true, tower="V127, U256", runways={ {name="06", hdg=62, ils="111.10"}, {name="24", hdg=242}}}},
        }
        veafNamedPoints.addAllCaucasusCities()
    elseif theatre == "persiangulf" then
        veafNamedPoints.Points = {
        }
        veafNamedPoints.addAllPersianGulfCities()
    elseif theatre == "thechannel" then
        veafNamedPoints.Points = {
        }
        veafNamedPoints.addAllTheChannelCities()
    elseif theatre == "marianaislands" then
        veafNamedPoints.Points = {
            -- airbases in Blue Island
            {name="AIRBASE Andersen AFB",  point={x=-010688,y=0,z=014822, atc=true, tower="V126.2, U250.1", tacan="54X", runways={{name="06", hdg=66}, {name="24", hdg=246}}}},
            {name="AIRBASE Antonio B. Won Pat Intl", point={x=-000068,y=0,z=-000109, atc=true, tower="V118.1, U340.2", runways={ {name="6", hdg=65, ils="110.30"}, {name="24", hdg=245}}}},
            {name="AIRBASE Olf Orote",point={x=-005047,y=0,z=-016913, atc=false}},
            {name="AIRBASE Santa Rita",point={x=-013576,y=0,z=-009925, atc=false}},
            
            -- airbases in Neutral Island
            {name="AIRBASE Rota Intl", point={x=-075886,y=0,z=048612, atc=true, tower="V123.6, U250", tacan="44X KTS", runways={ {name="09", hdg=92, ils="109.75"}, {name="27", hdg=272}}}},
            
            -- airbases in Red Island
            {name="AIRBASE Tinian Intl",  point={x=-166865,y=0,z=090027, atc=true, tower="V123.65, U250.05", tacan="31X TSK", runways={ {name="0", hdg=94, ils="108.90"}, {name="27", hdg=274}}}},
            {name="AIRBASE Saipan Intl", point={x=180074,y=0,z=101921, atc=true, tower="V125.7, U256.9", runways={{name="07", hdg=68, ils="109.90"}, {name="25", hdg=248}}}},
        }
        veafNamedPoints.addAllMarianasIslandsCities()
    else
        veaf.loggers.get(veaf.Id):warn(string.format("theatre %s is not yet supported by veafNamedPoints", theatre))
    end
    -- points of interest
    table.insert(veafNamedPoints.Points,
        {name="RANGE KhalKhalah",point=coord.LLtoLO("33.036180", "37.196608")}
    )
    veafNamedPoints.initialize()
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- configure SECURITY
-------------------------------------------------------------------------------------------------------------------------------------------------------------
if veafSecurity then
    veafSecurity.password_L9["6ade6629f9219d87a011e7b8fbf8ef9584f2786d"] = true -- set the L9 password (the lowest possible security)
    veaf.loggers.get(veaf.Id):info("Loading configuration")
    veaf.loggers.get(veaf.Id):info("init - veafSecurity")
    veafSecurity.initialize()

    -- force security in order to test it when dynamic loading is in place (change to TRUE)
    if (false) then
        veaf.SecurityDisabled = false
        veafSecurity.authenticated = false
    end
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- configure CARRIER OPERATIONS
-------------------------------------------------------------------------------------------------------------------------------------------------------------
if veafCarrierOperations then
    veaf.loggers.get(veaf.Id):info("init - veafCarrierOperations")
    veafCarrierOperations.initialize(true)
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- initialize the remote interface
-------------------------------------------------------------------------------------------------------------------------------------------------------------
if veafRemote then
    veaf.loggers.get(veaf.Id):info("init - veafRemote")
    veafRemote.initialize()
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- initialize Skynet-IADS
-------------------------------------------------------------------------------------------------------------------------------------------------------------
if veafSkynet then
    veaf.loggers.get(veaf.Id):info("init - veafSkynet")
    veafSkynet.initialize(
        false, --includeRedInRadio=true
        false, --debugRed
        false, --includeBlueInRadio
        false --debugBlue
    )
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- initialize the interpreter
-------------------------------------------------------------------------------------------------------------------------------------------------------------
if veafInterpreter then
    veaf.loggers.get(veaf.Id):info("init - veafInterpreter")
    veafInterpreter.initialize()
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- initialize veafSanctuary
-------------------------------------------------------------------------------------------------------------------------------------------------------------
if veafSanctuary then
    veafSanctuary.initialize()
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- initialize Hound Elint
-------------------------------------------------------------------------------------------------------------------------------------------------------------
if veafHoundElint and false then -- don't use Hound Elint
    veaf.loggers.get(veaf.Id):info("init - veafHoundElint")
    veafHoundElint.initialize(
        "ELINT", -- prefix
        { -- red
            --global parameters
            markers = true, --enables or disables markers on the map for detected radars
            disableBDA = false, --disables notifications that a radar has dropped off scope
            platformPositionErrors = true, --enables INS drift / GPS errors for ELINT platforms
            NATOmessages = false, --provides positions relative to the bullseye
            NATO_SectorCallsigns = false, --uses a different pool for sector callsigns
            ATISinterval = 180, --refresh delay of the ATIS, beware that this has an impact on performance
            preBriefedContacts = {
                --"Stuff",
                --"Thing",
            }, --contains the name of units placed in the ME which will be designated as pre-briefed (exact location) and who's position will be indicated exactly by Hound until the unit moved 100m away
            debug = false, --set this to true to make sure your configuration is correct and working as intended
        },
        { -- blue
            sectors = {
                --Global sector, mandatory inclusion if you want a global ATIS/controller etc., encompasses the whole map so it'll be very crowded in terms of comms
                [veafHoundElint.globalSectorName] = {
                    callsign = "Global Sector", --defines a specific callsign for the sector which will be used by the ATIS etc., if absent or nil Hound will assign it a callsign automatically, NATO format of regular Hound format. If true, callsign will be equal to the sector name
                    atis = {
                        freq = 282.175,
                        speed = 1,
                        --additional params
                        reportEWR = false --enables or disables the ATIS announcing EWRs as threats instead of it giving a very short message for such radars
                    },
                    controller = {
                        freq = 282.225,
                        --additional params
                        voiceEnabled = true --enables or disables voice for the controller which will otherwise be text only
                    },
                    notifier = {
                        freq = 282.2,
                        --additional params
                    },
                    disableAlerts = false, --disables alerts on the ATIS/Controller when a new radar is detected or destroyed
                    transmitterUnit = nil, --use the Unit/Pilot name to set who the transmitter is for the ATIS etc. This can be a static, and aircraft or a vehicule/ship
                    disableTTS = false,
                },
                --sector named "Latakia", will be geofenced to the mission editor polygon drawing (free or rect.) called "Latakia" (case sensitive)
                ["Latakia"] = {
                    callsign = true, --defines a specific callsign for the sector which will be used by the ATIS etc., if absent or nil Hound will assign it a callsign automatically, NATO format of regular Hound format. If true, callsign will be equal to the sector name
                    atis = {
                        freq = 281.075,
                        speed = 1,
                        --additional params
                        reportEWR = false --enables or disables the ATIS announcing EWRs as threats instead of it giving a very short message for such radars
                    },
                    controller = {
                        freq = 281.125,
                        --additional params
                        voiceEnabled = true --enables or disables voice for the controller which will otherwise be text only
                    },
                    notifier = {
                        freq = 281.1,
                        --additional params
                    },
                    disableAlerts = false, --disables alerts on the ATIS/Controller when a new radar is detected or destroyed
                    transmitterUnit = nil, --use the Unit/Pilot name to set who the transmitter is for the ATIS etc. This can be a static, and aircraft or a vehicule/ship
                    disableTTS = false,
                },
            },
            --global parameters
            markers = true, --enables or disables markers on the map for detected radars
            disableBDA = false, --disables notifications that a radar has dropped off scope
            platformPositionErrors = true, --enables INS drift / GPS errors for ELINT platforms
            NATOmessages= true, --provides positions relative to the bullseye
            NATO_SectorCallsigns = true, --uses a different pool for sector callsigns
            ATISinterval = 180, --refresh delay of the ATIS, beware that this has an impact on performance
            preBriefedContacts = {
                --"Stuff",
                --"Thing",
            }, --contains the name of units or groups placed in the ME which will be designated as pre-briefed (exact location) and who's position will be indicated exactly by Hound until the unit moved 100m away. If multiple radars are within a specified group, they'll all be added as pre-briefed targets
            debug = false, --set this to true to make sure your configuration is correct and working as intended
        }
        --this is the entire range of possible entries for the notifier, the controller and the ATIS settings
        -- args = {
        --     freq = 250.000,
        --     modulation = "AM",
        --     volume = "1.0",
        --     speed = <speed> -- number default is 0/1 for controller/atis. range is -10 to +10 on windows TTS. for google it's 0.25 to 4.0
        --     gender = "male"|"female",
        --     culture = "en-US"|"en-UK" -- (any installed on your system)
        --     isGoogle = true/false -- use google TTS (requires additional STTS config)
        --     voiceEnabled = true/false (for the controller only) -- to set if the controllers uses text or TTS
        --     reportEWR = true/false (for ATIS only) -- set to tell the ATIS to report EWRs as threats
        --     enableBDA = true/false (true by default) -- set to enable BDA/emissions drop on radars
        -- }
    )

    -- automatically start the two ELINT missions
    veafCombatMission.ActivateMission("ELINT-Mission-East", true)
    veafCombatMission.ActivateMission("ELINT-Mission-West", true)
end

-- Silence ATC on all the airdromes
veaf.silenceAtcOnAllAirbases()

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Mission S001 - Défense de Wujha Al Hajar - https://github.com/VEAF/VEAF-Open-Training-Mission-Syria/wiki/Mission-S001
-------------------------------------------------------------------------------------------------------------------------------------------------------------
veafShortcuts.AddAlias(
    VeafAlias:new()
        :setName("-s001-1")
        :setDescription("Mission S001 - 1 - before mission start")
        :setBatchAliases({
            "-armor#u36SYC4652696450, side blue, radius 10",
            "-point#u36SYC4652696450 C001-Wujha",
        })
        :setPassword("4190b6cb3eae1a1affe99114accccc36a9f1be4d") -- briefingsyria21
)

veafShortcuts.AddAlias(
    VeafAlias:new()
        :setName("-s001-2")
        :setDescription("Mission S001 - 2 - before takeoff")
        :setBatchAliases({
            "-convoy#U36SYC5520894925, side red, defense 3, armor 3, spacing 0.5, dest C001-Wujha",
        })
        :setPassword("4190b6cb3eae1a1affe99114accccc36a9f1be4d") -- briefingsyria21
)

veafShortcuts.AddAlias(
    VeafAlias:new()
        :setName("-s001-3")
        :setDescription("Mission S001 - 3 - optional (more defenses)")
        :setBatchAliases({
            "-sa8#U36SYC5015196779, side red, radius 0",
            "-sa15#U36SYC5019896649, side red, radius 0",            
        })
        :setPassword("4190b6cb3eae1a1affe99114accccc36a9f1be4d") -- briefingsyria21
)

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Mission S002 - Attaque de l'usine de SCUD - https://github.com/VEAF/VEAF-Open-Training-Mission-Syria/wiki/Mission-S002
-------------------------------------------------------------------------------------------------------------------------------------------------------------
veafShortcuts.AddAlias(
    VeafAlias:new()
        :setName("-s002-1")
        :setDescription("Mission S002 - 1 - before mission start")
        :setBatchAliases({
            "-zonestart combatZone_SCUD_Factory",
            "-point#U37SCU0477856197 SCUD",
            "-convoy#U37SCU0150289523!120, side red, size 5, defense 4, armor 3, dest SCUD, name TIGER",           
        })
        :setPassword("4190b6cb3eae1a1affe99114accccc36a9f1be4d") -- briefingsyria21
)

veafShortcuts.AddAlias(
    VeafAlias:new()
        :setName("-s002-2")
        :setDescription("Mission S002 - 2 - before takeoff (CAP)")
        :setBatchAliases({
            --"-airstart CAP-Tabqa-Su27-Fox1/Excellent/1, silent",
            "-cap#u37sdv133260 su27-fox1, skill excellent, dist 110, capradius 80, hdg 238",
        })
        :setPassword("4190b6cb3eae1a1affe99114accccc36a9f1be4d") -- briefingsyria21
)

veafShortcuts.AddAlias(
    VeafAlias:new()
        :setName("-s002-3")
        :setDescription("Mission S002 - 3 - optional (more CAP)")
        :setBatchAliases({
            --"-airstart CAP-Tabqa-Mig29S-Fox3/Excellent/2, silent",        
            "-cap#u37sdv133260 Mig29S-fox3, skill excellent, dist 110, capradius 80, hdg 238, multiplier 2",
        })
        :setPassword("4190b6cb3eae1a1affe99114accccc36a9f1be4d") -- briefingsyria21
)

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Mission S501 - Escorte / CAS - https://github.com/VEAF/VEAF-Open-Training-Mission-Syria/wiki/Mission-S501
-------------------------------------------------------------------------------------------------------------------------------------------------------------
veafShortcuts.AddAlias(
    VeafAlias:new()
        :setName("-s501-1")
        :setDescription("Mission S501 - 1 - before mission start")
        :setBatchAliases({

            -- Alliés
            "-point#U37SBT44561200 PALAIS",
            "-infantry#U37SBT44561200, side blue, radius 50",
            
            -- Héliport Qabr as Sitt
            "-infantry#U37SBT5442105271, side red, defense 0, armor 0, multiplier 2",
            
            -- CP1 - infantry
            "-infantry#U37SBT51460900, side red, defense 0, armor 0, multiplier 2, radius 50, spacing 2",
            "-point#U37SBT51460900 W3",
            
            -- CP2 - infantry
            "-infantry#U37SBT50571054, side red, defense 0, armor 0, multiplier 4, radius 50, spacing 2",
            "-point#U37SBT50571054 W4",
            
            -- CP3 - infantry & light armor
            "-infantry#U37SBT47031156, side red, defense 0, armor 2, multiplier 2, radius 50, spacing 2",
            "-point#U37SBT47031156 W5",
            
            -- armor (uniquement si flight CAS disponible)
            "-armor#U37SBT558031, side red, defense 0, radius 50, spacing 3",
            "-armor#U37SBT591012, side red, defense 0, radius 50, spacing 3",
            "-armor#U37SBT446113, side red, defense 2, radius 50, spacing 3",

        })
        :setPassword("4190b6cb3eae1a1affe99114accccc36a9f1be4d") -- briefingsyria21
)

veafShortcuts.AddAlias(
    VeafAlias:new()
        :setName("-s501-2")
        :setDescription("Mission S501 - 2 - after arrival at DAMAS")
        :setBatchAliases({
            -- Alliés, démarrer le convoi NEPTUNE à destination du PALAIS
            "-transport#U37SBS685995, side blue, armor 1, defense 0, size 4, dest PALAIS",
        })
        :setPassword("4190b6cb3eae1a1affe99114accccc36a9f1be4d") -- briefingsyria21
)

veafShortcuts.AddAlias(
    VeafAlias:new()
        :setName("-s502")
        :setDescription("Mission S502 - Naqoura")
        :setBatchAliases({
            
        -- checkpoints XB94
        "-infantry#U36SXB9608344273, side red, size 5, defense 0, spacing 0.5, armor 1",
        "-infantry#U36SXB9545447899, side red, size 6, defense 1, spacing 0.5, armor 2",

        -- checkpoints XB95
        "-infantry#U36SXB9623854088, side red, size 8, defense 2, spacing 0.5, armor 3",
        "-infantry#U36SXB9658555153, side red, size 8, defense 2, spacing 0.5, armor 3",

        -- checkpoints XB96
        "-armor#U36SXB9732261900, side red, spacing 0.5",
        "-armor#U36SXB9674163486, side red, spacing 0.5",

        -- Contested Heliport Naqoura XB96
        "-armor#U36SXB9886165320, side red, spacing 0.5",

        -- Optional: SEAD mission Naqoura (XB96)
        "-sa6#U36SXB9903665467, side red, spacing 0.5",

        -- Eglantine - Convoi bleu de Haifa vers Naqoura (CAS)
        "-transport#U36SXB9145429587, side blue, defense 1, dest NAQOURA HELIPT, size 3, armor 1, spacing 0.5"
        })
        :setPassword("4190b6cb3eae1a1affe99114accccc36a9f1be4d") -- briefingsyria21
)

veafShortcuts.AddAlias(
    VeafAlias:new()
        :setName("-s503")
        :setDescription("Mission S503 - Majdal Shams")
        :setBatchAliases({
            
        "-point#N33:15:26E35:45:51 YB58",
        "-point#U36SYB6040388494 ANTENNA",
        "-point#U36SYB5758091493 ANTENNA2",
        "-sa18#N33:16:32E35:48:21",
        "-manpads#N33:18:13E35:47:44, radius 2500",
        "-armor#N33:18:42E35:47:25, dest YB58",
        "-armor#N33:19:53E35:46:04",
        "-transport#N33:19:53E35:46:04, dest YB58"
        })
        :setPassword("4190b6cb3eae1a1affe99114accccc36a9f1be4d") -- briefingsyria21
)
