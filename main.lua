function setBlockSize()
    RESOLUTION = {
        SCREEN_SIZE = {x=love.graphics.getWidth(),y=love.graphics.getHeight()},
        BLOCK_SIZE = {X=50,Y=50}
    }
    BLOCKSIZE = RESOLUTION.BLOCK_SIZE
    BLOCKSIZE.Y = math.floor(RESOLUTION.SCREEN_SIZE.y/13)
    BLOCKSIZE.X = math.floor(((RESOLUTION.SCREEN_SIZE.x/13)*9.5)/13)

    Player.X = BLOCKSIZE.X*6
    Player.Y = BLOCKSIZE.Y*6
    Floor = {}
    for i = 1,13 do
        Plate = {}
        Plate.X = 0
        Plate.Y = BLOCKSIZE.Y*(i-1)
        table.insert(Floor, Plate)
        for v = 1,13 do
            Plate = {}
            Plate.X = BLOCKSIZE.X*(v-1)
            Plate.Y = BLOCKSIZE.Y*(i-1)
            table.insert(Floor, Plate)
        end
    end
    MovementDirections = {["up"]={x=0, y=(-BLOCKSIZE.Y)}, ["down"]={x=0, y=BLOCKSIZE.Y}, ["right"]={x=BLOCKSIZE.X, y=0}, ["left"]={x=(-BLOCKSIZE.X), y=0}}
end
function Decimal(INPUT)
	local ANSWER=((INPUT/10)-math.floor(INPUT/10)+1)*10-10
	return ANSWER
end
function Add(type,x,y)
	local a={X=x*BLOCKSIZE.X,Y=y*BLOCKSIZE.Y}
    table.insert(Workspace[type],a)
end
function love.load()
	love.window.setMode(900,650)
	love.graphics.setFont(love.graphics.newFont(14))
    KONAMI = {"w", "w", "s", "s", "a", "d", "a", "d", "l", "r"}
    KONAMI_INDEX = 1;
    SPEED_FAST = 6;
    SPEED_SLOW = 10;
    IS_FULL_SCREEN = false;
    MUTED = false;
    LOBBY = true;
    HARDCORE = false;
    KexLeft = 0
    Bonus = false;

    Texture = {
        SideBar = {
        	NUMBERS = {
        		[0] = love.graphics.newImage("/Texture/SideBar/NUMBERS/ZERO.png"),
				[1] = love.graphics.newImage("/Texture/SideBar/NUMBERS/ONE.png"),
				[2] = love.graphics.newImage("/Texture/SideBar/NUMBERS/TWO.png"),
				[3] = love.graphics.newImage("/Texture/SideBar/NUMBERS/THREE.png"),
				[4] = love.graphics.newImage("/Texture/SideBar/NUMBERS/FOUR.png"),
				[5] = love.graphics.newImage("/Texture/SideBar/NUMBERS/FIVE.png"),
				[6] = love.graphics.newImage("/Texture/SideBar/NUMBERS/SIX.png"),
				[7] = love.graphics.newImage("/Texture/SideBar/NUMBERS/SEVEN.png"),
				[8] = love.graphics.newImage("/Texture/SideBar/NUMBERS/EIGHT.png"),
				[9] = love.graphics.newImage("/Texture/SideBar/NUMBERS/NINE.png"),
        	},
            MAINFRAME = love.graphics.newImage("/Texture/SideBar/Option.png"),
            LEVEL = love.graphics.newImage("/Texture/SideBar/LEVEL.png"),
            NUM = love.graphics.newImage("/Texture/SideBar/NUM.png"),
            OUTLINE = love.graphics.newImage("/Texture/SideBar/OUTLINE.png"),
            TIME = love.graphics.newImage("/Texture/SideBar/TIME.png"),
            KEXLEFT = love.graphics.newImage("/Texture/SideBar/KEXLEFT.png"),
            WIN = love.graphics.newImage("/Texture/SideBar/WinScreen.png")

    	},
    	Bug = {
    		r = love.graphics.newImage("/Texture/Objects/Bug/r.png"),
    		d = love.graphics.newImage("/Texture/Objects/Bug/d.png"),
    		u = love.graphics.newImage("/Texture/Objects/Bug/u.png"),
    		l = love.graphics.newImage("/Texture/Objects/Bug/l.png")
    	},
    	Glider = {
    		r = love.graphics.newImage("/Texture/Objects/Glider/r.png"),
    		d = love.graphics.newImage("/Texture/Objects/Glider/d.png"),
    		u = love.graphics.newImage("/Texture/Objects/Glider/u.png"),
    		l = love.graphics.newImage("/Texture/Objects/Glider/l.png")
    	},
    	Tank = {
    		r = love.graphics.newImage("/Texture/Objects/Tank/r.png"),
    		d = love.graphics.newImage("/Texture/Objects/Tank/d.png"),
    		u = love.graphics.newImage("/Texture/Objects/Tank/u.png"),
    		l = love.graphics.newImage("/Texture/Objects/Tank/l.png")
    	},
        Portal = love.graphics.newImage("/Texture/Objects/Portal.png"),
        Plate = love.graphics.newImage("/Texture/Objects/Ground.png"),
        Block = love.graphics.newImage("/Texture/Objects/Block.png"),
        Water = love.graphics.newImage("/Texture/Objects/Water.png"),
        Point = love.graphics.newImage("/Texture/Objects/Point.png"),
        KexDoor = love.graphics.newImage("/Texture/Objects/KexDoor.png"),
        Key = love.graphics.newImage("/Texture/Objects/Key.png"),
        PlayerR = love.graphics.newImage("/Texture/Character/PlayerR.png"),
        PlayerL = love.graphics.newImage("/Texture/Character/PlayerL.png"),   
        PlayerD = love.graphics.newImage("Texture/Character/PlayerD.png"),
        PlayerU = love.graphics.newImage("/Texture/Character/PlayerU.png"),
        Player_WR = love.graphics.newImage("/Texture/Character/Player_WR.png"),
        Player_WL = love.graphics.newImage("/Texture/Character/Player_WL.png"),
        Player_WU = love.graphics.newImage("/Texture/Character/Player_WU.png"),
        Player_WD = love.graphics.newImage("/Texture/Character/Player_WD.png"),
        Lose = love.graphics.newImage("/Texture/SideBar/Lose.png"),
        Flippers = love.graphics.newImage("/Texture/Objects/Flipper.png"),
        Lock = love.graphics.newImage("/Texture/Objects/Lock.png"),
        Moveable = love.graphics.newImage("/Texture/Objects/Moveable.png"),
        Thief = love.graphics.newImage("/Texture/Objects/Thief.png"),
        Fire = love.graphics.newImage("/Texture/Objects/Fire.png"),
        Fireshoes = love.graphics.newImage("/Texture/Objects/FireShoes.png"),
        ConR = love.graphics.newImage("/Texture/Objects/ConveyorR.png"),
        ConL = love.graphics.newImage("/Texture/Objects/ConveyorL.png"),
        ConD = love.graphics.newImage("/Texture/Objects/ConveyorD.png"),
        ConU = love.graphics.newImage("/Texture/Objects/ConveyorU.png"),
        ButtonBlock = love.graphics.newImage("/Texture/Objects/Button.png"),
        Teleporter = love.graphics.newImage("/Texture/Objects/Teleporter.png"),
        HoverBoots = love.graphics.newImage("/Texture/Objects/HoverBoots.png"),
        Bomb = love.graphics.newImage("/Texture/Objects/Bomb.png"),
        Pinkball = love.graphics.newImage("/Texture/Objects/BounceBall.png"),
        Hint = love.graphics.newImage("/Texture/Objects/Hint.png"),
        Ice = love.graphics.newImage("/Texture/Objects/Ice.png"),
        DDosKid = love.graphics.newImage("/Texture/Objects/DDOSKID.png"),
        IceSkates = love.graphics.newImage("/Texture/Objects/IceSkates.png"),
        TFButton = love.graphics.newImage("/Texture/Objects/TFButton.png"),
        TFBlock = love.graphics.newImage("/Texture/Objects/TFBlock.png"),
        TeethD = love.graphics.newImage("/Texture/Objects/Teeth/D.png"),
        TeethR = love.graphics.newImage("/Texture/Objects/Teeth/R.png"),
        TeethL = love.graphics.newImage("/Texture/Objects/Teeth/L.png"),
        TeethU = love.graphics.newImage("/Texture/Objects/Teeth/U.png"),
        Gravel = love.graphics.newImage("/Texture/Objects/Gravel.png"),
        Hardcore = love.graphics.newImage("/Texture/Objects/Hardcore.png"),
        T_Button = love.graphics.newImage("/Texture/Objects/T_Button.png"),
        Walker = love.graphics.newImage("/Texture/Objects/Walker.png"),
        Fireball = love.graphics.newImage("/Texture/Objects/Fireball.png"),
        Blob = love.graphics.newImage("/Texture/Objects/Blob.png"),
        BlueWall = love.graphics.newImage("/Texture/Objects/BlueWall.png")
    }
    Sound = {
        Splash = love.audio.newSource("/Sound/Splash.wav","static"),
        Win = love.audio.newSource("/Sound/Win.wav","static"),
        Get = love.audio.newSource("/Sound/get.wav","static"),
        Button = love.audio.newSource("/Sound/Button.wav","static"),
        Wall = love.audio.newSource("/Sound/wall.wav","static"),
        Unlock = love.audio.newSource("/Sound/door.wav","static"),
        Thief = love.audio.newSource("Sound/Thief.wav","static"),
        Burn = love.audio.newSource("Sound/burn.wav","static"),
        get1 = love.audio.newSource("Sound/get1.wav","static"),
        Locked = love.audio.newSource("Sound/Locked.mp3","static")
    }
    Music = {
        Chip01 = love.audio.newSource("/Soundtracks/Chip01.mp3"),
        Chip02 = love.audio.newSource("/Soundtracks/Chip02.mp3"),
    }
    Player = {
    	StartPos = {X=0,Y=0},
        X = 0,
        Y = 0,
        Image = Texture.PlayerR,
        Points = 0,
        Dead = false,
        cooldown = 0,
        Wait = SPEED_SLOW,
        Sliding = false,
        TIMELEFT = 80,
        Inventory = {
            Flippers = false,
            RedKey = false,
            BlueKey = false,
            GreenKey = false,
            YellowKey = false,
            FireShoes = false,
            HoverBoots = false,
            IceSkates = false,
        },
        MoveTo = function (x,y)
       		for _,v in pairs(Workspace)do
    			for _,stuff in pairs(v)do
    				stuff.X = stuff.X - x + Player.X
    			end
    		end
        	for _,v in pairs(Workspace)do
    			for _,stuff in pairs(v)do
    				stuff.Y = stuff.Y - y + Player.Y
    			end
    		end
        end,
        Hint = false,
        moveRight = function()
        	Player.Image = Texture.PlayerR
            gayloop("right")
            check("right")
        end,
        moveLeft = function()
        	Player.Image = Texture.PlayerL
            gayloop("left")
            check("left")
        end,
        moveUp = function()
        	Player.Image = Texture.PlayerU
            gayloop("up")
            check("up")
        end,
        moveDown = function()
        	Player.Image = Texture.PlayerD
            gayloop("down")
            check("down")
        end,
    }
    Workspace = {
        ["Block"] = {},
        ["Water"] = {},
        ["Portal"] = {},
        ["Point"] = {},
        ["KexDoor"] = {},
        ["Flippers"] = {},
        ["RedKey"] = {},
        ["GreenKey"] = {},
        ["BlueKey"] = {},
        ["YellowKey"] = {},
        ["LockR"] = {},
        ["LockG"] = {},
        ["LockB"] = {},
        ["LockY"] = {},
        ["Moveable"] = {},
        ["Thief"] = {},
        ["Fire"] = {},
        ["Fireshoes"] = {},
        ["ConR"] = {},
        ["ConL"] = {},
        ["ConD"] = {},
        ["ConU"] = {},
        ["ButtonBlock"] = {},
        ["Teleporter"] = {},
        ["HoverBoots"] = {},
        ["Dirt"] = {},
        ["Bomb"] = {},
        ["Pinkball"] = {},
        ["Hint"] = {},
        ["DDosKid"] = {},
        ["Ice"] = {},
        ["IceSkates"]= {},
        ["TFButton"] = {},
        ["TFBlock"] = {},
        ["Teeth"] = {},
        ["Bug"] = {},
        ["Gravel"] = {},
        ["Hardcore"] = {},
        ["Glider"]  = {},
        ["Tank"] = {},
        ["T_Button"] = {},
        ["Walker"] = {},
        ["Fireball"] = {},
        ["Blob"] = {},
        ["BlueWall"] = {},
        ["BlueTinged"] = {},
        ["InvisibleWall"] = {},
        ["HiddenWall"] = {}
    }
    Special = {
		Iceway = "Down",
	}
	COOLDOWN = {ice=10,bounce=0,teeth=10,conveyor=0,bug=0,glider=0,tank=0,walker=0,fireball=0,blob=0}
	StageInfo = {
		LevelIndex = {"one","two","three","four","five","six","seven","eight","nine","ten","eleven","twelve","thirteen","fourteen","fifteen","sixteen","seventeen","eightteen","nineteen","twenty","twentyone","twentytwo","twentythree","twentyfour","twentyfive","twentysix","twentyseven","twentyeight","twentynine","thirteen","thirteenone"},
		LevelsInfo = {
			one={hint="Collect all tiger biscuits to\nget past the iron door",NAME="LESSON 1"},
			two={NAME="LESSON 2"},
			three={hint="Use keys to open doors. Green\nkeys does never get destroyed when\nused",NAME="LESSON 3"},
			four={hint="Push blocks into water to make\ndirt. Watch out for monsters.",NAME="LESSON 4"},
			five={hint="Suction boots for force floors. Fire\nboots for fire. Flippers for water.\nSkates for ice",NAME="LESSON 5"},
			six={hint="The blue button controls the tanks.\nThe green button toggles walls.",NAME = "LESSON 6"},
			seven={hint="Blue walls may be fake. Some inv-\nisible walls never appear. There\ncan be extra kex",NAME="LESSON 6"},
			eight={hint="The thief takes your tools. New\nwalls can appear behind you when \nstepped on grey buttons.l",NAME="LESSON 7"},
			nine={hint="Monsters can be stopped by dirt\nand gravel",NAME="Use your brain on this one!"},
			ten={NAME=""},
			eleven={hint="Hint: Press \"R\" on the keyboard to \nrestart the level :-)",NAME=""},
			twelve={NAME="Castle moat"},
			thirteen={NAME="Elementary"},
			fourteen={NAME="Trinity"},
			fifteen={NAME="NUTS AND BOLT",hint="lets put your moving blocks to the\ntest."},
			sixteen={NAME="BURSHFIRE"},
			seventeen={NAME="Elementary"},
			eightteen={NAME="LESSON 8"},
			nineteen={NAME="Hunt"},
			twenty={NAME="NUTS AND BOLT"},
			twentyone={NAME="TEST"},
			twentytwo={NAME="TEST ASWELL"},
			twentythree={NAME="ICE"},
			twentyfour={NAME="Trinity"},
			twentyfive={NAME="test"},
			twentysix={NAME="TEST"},
            twentyseven={NAME="TEST"},
            twentyeight={NAME="TEST"},
            twentynine={NAME="TEST"},
            thirteen={NAME="TEST"},
            thirteenone={NAME="TEST"}
		}
	}
	CurrentStage = 1-1

    BeatStage = false;
    index = {"Chip01","Chip02"}--"Chip03","Chip04","Chip05"
    MusicIndex = index[love.math.random(#index)]
    Music[MusicIndex]:setVolume(0.5) --0.5
    milisec = 20
    trigger={}
    lastObjectPlaced = "#"
    Place = {x=0,y=0}
    setBlockSize()

    function ResetStage(Lnext)
    	Player.Image = Texture.PlayerR
        for i = 1,10 do
            for _,v in pairs(Workspace)do
                for t,i in pairs(v)do
                    table.remove(v,t)
                end
            end
        end
        Player.Points = 0
        Player.X = BLOCKSIZE.X*6
        Player.Y = BLOCKSIZE.Y*6
        Player.image = Texture.PlayerR
        for i,_ in pairs(Player.Inventory)do
            Player.Inventory[i] = false;
        end
        local File = {}
        if Lnext then
        	CurrentStage = CurrentStage + 1
            Player.Sliding = false;
        end
        if CurrentStage == "test"then
       	    for line in love.filesystem.lines("/Levels/TestStage")do
       	        table.insert(File,line)
       	    end
       	else
       		if LOBBY then
       			for line in love.filesystem.lines("/Levels/Lobby")do
       	        	table.insert(File,line)
       	    	end
                Add("Hardcore",12,7)
       		elseif HARDCORE then
       			for line in love.filesystem.lines("/Levels/Hardcore/Stage"..CurrentStage)do
       	        	table.insert(File,line)
       	    	end
       	    else
       	    	for line in love.filesystem.lines("/Levels/Stage"..CurrentStage)do
       	    	    table.insert(File,line)
       	    	end
       	    	love.window.setTitle("Kun'ts Adventure: ".. StageInfo.LevelsInfo[StageInfo.LevelIndex[CurrentStage]].NAME)
       		end
       	end
        for s,v in pairs(File)do
       	    for i = 0,#v,1 do
       	        Text = string.sub(v,i,i)
       	        Place(Text,i,s)
       	    end
        end
        --Player.TIMELEFT = 80
        Player.MoveTo(Player.StartPos.X,Player.StartPos.Y)
        if CurrentStage == 7 then
            KexLeft = 4;
        else
            KexLeft = #Workspace["Point"]
        end
    end
    function gayloop(k)
        for i,v in pairs(Workspace)do
        	local opposite = {["up"]="down",["down"]="up",["left"]="right",["right"]="left"}
            if i == "Water"then
                for _,v in pairs(v)do
                    if (v.Y == Player.Y+MovementDirections[k].y)and(v.X == Player.X+MovementDirections[k].x)then
                        if Player.Inventory.Flippers then
                            Sound.Splash:play()
                            if k=="right"then 
                                Player.Image=Texture.Player_WR 
                            elseif k=="left"then 
                                Player.Image=Texture.Player_WL 
                            elseif k=="up"then
                                Player.Image=Texture.Player_WU
                            elseif k=="down"then
                                Player.Image=Texture.Player_WD
                            end
                        else
                            Sound.Splash:stop()
                            Sound.Splash:play()
                            Player.Dead = true
                        end
                    end
                end
            end
            if i=="Hardcore"then
                for _,v in pairs(v)do
                    if(v.Y == Player.Y+MovementDirections[k].y)and(v.X == Player.X+MovementDirections[k].x)then
                        Sound.Win:play()
                        BeatStage = true
                        HARDCORE = true
                        LOBBY = false;
                    end
                end
            end
            if i=="Block"or i=="InvisibleWall"or i=="HiddenWall" or i=="BlueWall"then
                for c,v in pairs(v)do
                    if (v.Y == Player.Y+MovementDirections[k].y)and(v.X == Player.X+MovementDirections[k].x)then Sound.Wall:play()
                        if i=="HiddenWall"or i =="BlueWall"then
                            if i =="BlueWall"then
                                table.remove(Workspace["BlueWall"],c)
                            else
                                table.remove(Workspace["HiddenWall"],c)
                            end
                            local c={X=v.X,Y=v.Y};table.insert(Workspace["Block"],c)
                        end
                    	for _,v in pairs(Workspace["Ice"])do
                    		if v.X == Player.X and v.Y == Player.Y then 
                    			Special.Iceway = opposite[Special.Iceway]
                    		end
                    	end
                    	return 
                    end
                end
            end
            if i == "KexDoor" then
                for i,v in pairs(v)do
                    if (v.Y == Player.Y+MovementDirections[k].y)and(v.X==Player.X+MovementDirections[k].x)and(KexLeft >= 1) then
                    	Sound.Locked:play()return
                    elseif (v.Y == Player.Y+MovementDirections[k].y)and(v.X==Player.X+MovementDirections[k].x)then
                    	table.remove(Workspace["KexDoor"],i)
                    end
                end
            end
            if i == "LockR"or i=="LockB"or i=="LockG"or i=="LockY"then
                for r,f in pairs(v)do
                    if (f.Y == Player.Y+MovementDirections[k].y)and(f.X==Player.X+MovementDirections[k].x)then
                        local matchingKey = {["LockR"]="RedKey",["LockB"]="BlueKey",["LockG"]="GreenKey";["LockY"]="YellowKey"}
                        if Player.Inventory[matchingKey[i]] == true then 
                            if matchingKey[i] ~= "GreenKey" then
                                Player.Inventory[matchingKey[i]]=false;
                            end
                            table.remove(v,r)
                            Sound.Unlock:play()
                        else Sound.Locked:play()Special.Iceway=opposite[Special.Iceway]return end
                    end
                end
            end
            if i == "Moveable"then
                for z,m in pairs(v)do
                    if m.X==Player.X+MovementDirections[k].x and m.Y==Player.Y+MovementDirections[k].y then
                    	local wx,wy,PlaceDirt = 0,0,false
                        for n,f in pairs(Workspace)do
                            for w,c in pairs(f)do
                                if c.X == m.X+MovementDirections[k].x and c.Y == m.Y+MovementDirections[k].y then
                                    if n=="Water" or n=="Bomb"then
                                    	table.remove(v,z)
                                        table.remove(f,w)
                                        if n=="Water"then
                                        	wx,wy,PlaceDirt=c.X,c.Y,true;
                                            Sound.Splash:play()
                                        else
                                            Sound.Burn:play()
                                        end
                                    elseif n=="TFButton"then
                                       	trigger.TFBlock()
									elseif n =="T_Button"then
										trigger.Tank()
                                    elseif n=="Hint" or n=="ConD" or n=="ConL" or n=="ConR" or n=="ConU"or n=="Gravel"or n=="Ice"then
                                    elseif n=="TFBlock" and c.BOOL==false then
                                    else 
                                    	for _,v in pairs(Workspace["Ice"])do
                    						if v.X == Player.X and v.Y == Player.Y then 
                    							Special.Iceway = opposite[Special.Iceway]
                    						end
                    					end
                                    	Sound.Wall:play()
                                    	return
                                    end
                                end
                            end
                        end
                        for _,ice in pairs(Workspace["Ice"])do
               				if m.X ~= ice.X and m.Y ~= ice.Y then
                   				m.way = string.lower(Special.Iceway);
               		    	end
                		end
                        m.X = m.X+MovementDirections[k].x
                        m.Y = m.Y+MovementDirections[k].y
                        if PlaceDirt then
                        	local c={X=wx,Y=wy}table.insert(Workspace["Dirt"],c)
                        end
                    end
                end
            end
            if i=="Thief"then
                for _,v in pairs(v)do
                    if (v.Y == Player.Y+MovementDirections[k].y)and(v.X == Player.X+MovementDirections[k].x)then 
                        for i,_ in pairs(Player.Inventory)do
                            Player.Inventory[i] = false;
                        end
                        Sound.Thief:stop()
                        Sound.Thief:play()
                    end
                end
            end
            if i == "Fire"then
                for _,f in pairs(v)do
                    if (f.Y==Player.Y+MovementDirections[k].y)and(f.X==Player.X+MovementDirections[k].x)then
                        if Player.Inventory.FireShoes then else
                            Sound.Burn:stop()
                            Sound.Burn:play()
                            Player.Dead = true
                        end
                    end
                end
            end
            if i == "Bomb"then
                for _,f in pairs(v)do
                    if f.X==Player.X+MovementDirections[k].x and f.Y==Player.Y+MovementDirections[k].y then
                        Sound.Burn:play()
                        Player.Dead=true;
                    end
                end
            end
            if i == "DDosKid"then
                for _,f in pairs(v)do
                    if f.X==Player.X+MovementDirections[k].x and f.Y==Player.Y+MovementDirections[k].y then
                        error("Git dddosed kiddo! yo will nao huve to start uver again HUEUEUEUEUe \n\n  xXxDdosMasterKidzxXx was here")
                    end
                end
            end
            if i == "TFButton"then
            	for _,f in pairs(v)do
                    if f.X==Player.X+MovementDirections[k].x and f.Y==Player.Y+MovementDirections[k].y then
						trigger.TFBlock()
                    end
                end
            end
            if i == "TFBlock"then
                for _,v in pairs(v)do
                    if (v.Y == Player.Y+MovementDirections[k].y)and(v.X == Player.X+MovementDirections[k].x)then 
                    	if v.BOOL then
                    		Sound.Wall:play()
                    		for _,v in pairs(Workspace["Ice"])do
                    			if v.X == Player.X and v.Y == Player.Y then 
                    				local opposite = {["up"]="down",["down"]="up",["left"]="right",["right"]="left"}
                    				Special.Iceway = opposite[Special.Iceway]
                    			end
                    		end
                    		return 
                   		end
                    end
                end
            end
            if i == "T_Button"then
                for _,f in pairs(v)do
                    if f.X==Player.X+MovementDirections[k].x and f.Y==Player.Y+MovementDirections[k].y then
                        trigger.Tank()
                    end
                end
            end
            if i=="Teleporter"then
                for i,f in pairs(v)do
                    if f.X==Player.X+MovementDirections[k].x and f.Y==Player.Y+MovementDirections[k].y then
                        for v,f in pairs(Workspace["Teleporter"])do
                            if canMove(f.X+MovementDirections[k].x,f.Y+MovementDirections[k].y)and i~=v then
                                Player.MoveTo(f.X,f.Y)
                                Player["move"..string.upper(string.sub(k,0,1))..string.sub(k,2)]()
                                return
                            end
                        end
                        Player["move"..string.upper(string.sub(opposite[k],0,1))..string.sub(opposite[k],2)]()
                        break
                    end
                end
            end
        end
        for _,v in pairs(Workspace)do
            for _,i in pairs(v)do
                i.X = i.X + (-MovementDirections[k].x)
                i.Y = i.Y + (-MovementDirections[k].y)
            end
        end
    end
    function check(k)
        for e,f in pairs(Workspace)do
            if e == "Portal"and #f>=1 then
                for _,v in pairs(f)do
                    if v.X==Player.X and v.Y==Player.Y then
                        Sound.Win:play()
                        BeatStage = true
                        LOBBY = false;
                    end
                end
            end
            if e=="Point"and #f>=1 then
                for i,v in pairs(f)do
                    if (v.X==Player.X)and(v.Y==Player.Y)then
                        KexLeft = KexLeft - 1
                        Sound.get1:stop()
                        Sound.get1:play()
                        table.remove(Workspace["Point"],i)
                    end
                end
            end
            if e=="Flippers"and#f>=1 then
                for i,v in pairs(f)do
                    if v.X==Player.X and v.Y==Player.Y then
                        Player.Inventory.Flippers=true
                        table.remove(f,i)
                        Sound.Get:stop()
                        Sound.Get:play()
                    end
                end
            end
            if e=="RedKey"and #f>=1 then
                for i,v in pairs(f)do
                    if Player.Y==v.Y and Player.X==v.X then
                        Player.Inventory.RedKey=true;
                        table.remove(f,i)
                        Sound.Get:stop()
                        Sound.Get:play()
                    end
                end
            end
            if e=="GreenKey"and#f>=1 then
                for i,v in pairs(f)do
                    if Player.Y==v.Y and Player.X==v.X then
                        Player.Inventory.GreenKey=true;
                        table.remove(f,i)
                        Sound.Get:stop()
                        Sound.Get:play()
                    end
                end
            end
            if e=="BlueKey"and #f>=1 then
                for i,v in pairs(f)do
                    if Player.Y==v.Y and Player.X==v.X then
                        Player.Inventory.BlueKey=true;
                        table.remove(f,i)
                        Sound.Get:stop()
                        Sound.Get:play()
                    end
                end
            end
            if e=="YellowKey"and #f>=1 then
                for i,v in pairs(f)do
                    if Player.Y==v.Y and Player.X==v.X then
                        Player.Inventory.YellowKey=true;
                        table.remove(f,i)
                        Sound.Get:stop()
                        Sound.Get:play()
                    end
                end
            end
            if e=="Fireshoes"and #f>=1 then
                for i,v in pairs(f)do
                    if Player.Y==v.Y and Player.X==v.X then
                        Player.Inventory.FireShoes=true;
                        table.remove(f,i)
                        Sound.Get:stop()
                        Sound.Get:play()
                    end
                end
            end
            if e=="Water"and #f>=1 then
                for i,v in pairs(f)do
                    if Player.Y==v.Y and Player.X==v.X then
                        if k=="right"then 
                            Player.Image=Texture.Player_WR 
                        elseif k=="left"then 
                            Player.Image=Texture.Player_WL 
                        elseif k=="up"then
                            Player.Image=Texture.Player_WU
                        elseif k=="down"then
                            Player.Image=Texture.Player_WD
                        end
                    end
                end
            end
            if e=="HoverBoots"and#f>=1 then
                for i,v in pairs(f)do
                    if Player.Y==v.Y and Player.X==v.X then
                        Player.Inventory.HoverBoots=true;
                        table.remove(f,i)
                        Sound.Get:stop()
                        Sound.Get:play()
                    end
                end
            end
            if e == "ButtonBlock" then
                for i,z in pairs(f)do
                    if z.Y==Player.Y and z.X==Player.X then
                       	Add("Block",z.X/BLOCKSIZE.X,z.Y/BLOCKSIZE.Y)
                        table.remove(f,i)
                    end
                end
            end
            if e=="Dirt"or e=="BlueTinged"then
                for i,z in pairs(f)do
                    if z.Y == Player.Y and z.X == Player.X then
                        table.remove(f,i)
                    end
                end
            end
            if e=="Hint"and#f>=1 then
                for i,v in pairs(f)do
                    if Player.Y==v.Y and Player.X==v.X then
                        Player.Hint = true;
                    else
                        Player.Hint = false;
                    end
                end
            end
            if e=="IceSkates"and#f>=1 then
                for i,v in pairs(f)do
                    if Player.Y==v.Y and Player.X==v.X then
                        Player.Inventory.IceSkates=true;
                        table.remove(f,i)
                        Sound.Get:stop()
                        Sound.Get:play()
                        Player.Sliding = false
                    end
                end
            end
            if e=="Glider"or e=="Tank"or e=="Bug"or e=="Pinkball"or e=="Walker"or e=="Fireball"or e=="Blob"or e=="Teeth"and#f>=1 then
                for i,v in pairs(f)do
                    if Player.Y==v.Y and Player.X==v.X then
                       Player.Dead = true;
                    end
                end
            end
        end
    end
    function Place(t,x,y)
        if t=="#"then
            Add("Block",x,y)
        elseif t=="o"then
            Add("Portal",x,y)
        elseif t=="W"then
            Add("Flippers",x,y)
        elseif t=="w"then
            Add("Water",x,y)
        elseif t=="k"then
            Add("Point",x,y)
        elseif t=="h"then
            Add("KexDoor",x,y)
        elseif t=="R"then
            Add("RedKey",x,y)
        elseif t=="B"then
            Add("BlueKey",x,y)
        elseif t=="G"then
            Add("GreenKey",x,y)
        elseif t=="Y"then
            Add("YellowKey",x,y)
        elseif t=="r"then
            Add("LockR",x,y)
        elseif t=="b"then
            Add("LockB",x,y)
        elseif t=="g"then
            Add("LockG",x,y)
        elseif t=="y"then
            Add("LockY",x,y)
        elseif t=="m"then
            local a={X=x*BLOCKSIZE.X,Y=y*BLOCKSIZE.Y,way=string.lower(Special.Iceway)}table.insert(Workspace["Moveable"],a)
        elseif t=="t"then
            Add("Thief",x,y)
        elseif t=="f"then
            Add("Fire",x,y)
        elseif t=="F"then
            Add("Fireshoes",x,y)
        elseif t=="v"then
            Add("ConD",x,y)
        elseif t=="^"then
            Add("ConU",x,y)
        elseif t=="<"then
            Add("ConL",x,y)
        elseif t==">"then
            Add("ConR",x,y)
        elseif t=="_"then
            Add("ButtonBlock",x,y)
        elseif t=="V"then
            Add("HoverBoots",x,y)
        elseif t=="d"then
            Add("Dirt",x,y)
        elseif t=="Q"then
            Add("Bomb",x,y)
        elseif t=="*"then
        	local c={X=x*BLOCKSIZE.X,Y=y*BLOCKSIZE.Y,way="l"}table.insert(Workspace["Pinkball"],c)
        elseif t=="?"then
            Add("Hint",x,y)
        elseif t=="D"then
            Add("DDosKid",x,y)
        elseif t=="i"then
            Add("Ice",x,y)
        elseif t=="I"then
            Add("IceSkates",x,y)
        elseif t=="!"then
            Add("TFButton",x,y)
        elseif t=="E"then
            local a = {X=x*BLOCKSIZE.X,Y=y*BLOCKSIZE.Y,BOOL = true}table.insert(Workspace["TFBlock"],a)
        elseif t=="e"then
            local a = {X=x*BLOCKSIZE.X,Y=y*BLOCKSIZE.Y,BOOL = false}table.insert(Workspace["TFBlock"],a)
        elseif t=="z"then
        	local c = {X=x*BLOCKSIZE.X,Y=y*BLOCKSIZE.Y,image="TeethD"}table.insert(Workspace["Teeth"],c)
        elseif t=="u"then
        	local c={X=x*BLOCKSIZE.X,Y=y*BLOCKSIZE.Y,way="u"}table.insert(Workspace["Bug"],c)
        elseif t=="x"then
        	Player.StartPos.X = x*BLOCKSIZE.X
        	Player.StartPos.Y = y*BLOCKSIZE.Y
       	elseif t==":"then
       		Add("Gravel",x,y)
       	elseif t=="A"then
       		local A = {X=x*BLOCKSIZE.X,Y=y*BLOCKSIZE.Y,way="u"}table.insert(Workspace["Glider"],A)
       	elseif t == "T"then
       		local T={X=x*BLOCKSIZE.X,Y=y*BLOCKSIZE.Y,way="u"}table.insert(Workspace["Tank"],T)
       	elseif t == "."then
       		Add("T_Button",x,y)
       	elseif t == "+"then
       		local c={X=x*BLOCKSIZE.X,Y=y*BLOCKSIZE.Y,way="u"}table.insert(Workspace["Walker"],c)       		
        elseif t=="%"then
        	local c={X=x*BLOCKSIZE.X,Y=y*BLOCKSIZE.Y,way="d"}
        	if lastObjectPlaced=="1"then
        		c.way ="u";
            elseif lastObjectPlaced=="2"then
                c.way = "r"
            elseif lastObjectPlaced=="3"then
                c.way = "l"
        	end
            if lastObjectPlaced=="1"or lastObjectPlaced=="2"or lastObjectPlaced=="3"then
                c.X=c.X - BLOCKSIZE.X;
            end
           table.insert(Workspace["Fireball"],c)
        elseif t=="0"then
            local c={X=x*BLOCKSIZE.X,Y=y*BLOCKSIZE.Y,way="u"}table.insert(Workspace["Blob"],c)
        elseif t=="=" then
            Add("BlueWall",x,y)
        elseif t=="-"then
            Add("BlueTinged",x,y)
        elseif t=="X"then
            Add("InvisibleWall",x,y)
        elseif t=="/"then
            Add("HiddenWall",x,y)
        elseif t=="c"then
            Add("Teleporter",x,y)
        end
        lastObjectPlaced = t;
    end
    function canMove(x,y,bomb)
    	local bool = false;
    	for i,e in pairs(Workspace)do
 			for _,v in pairs(e)do
 				if v.X == x and v.Y == y then
 					if i == "TFBlock" then
 						for _,v in pairs(Workspace["TFBlock"])do
 							if v.BOOL == false then
 								bool = false;
 							else
 								bool = true;
 							end
	 					end
	 				elseif i=="TFButton" or i=="T_Button" or i=="Hint" or i=="Water"or i=="Ice"or i=="Bomb" then
	 					bool = false;
	 				elseif bomb then
	 					if i=="bomb"then
	 						bool = false;
	 					end
	 				else
	 					bool = true;
 					end
 				end

    		end
    	end
    	if bool then
   			return false;
   		else
    		return true;
    	end
    end
    Music[MusicIndex]:play()
    ResetStage()
    function trigger.Tank()
		Sound.Button:stop()
		Sound.Button:play()
		for _,v in pairs(Workspace["Tank"])do
			local o={d="u",u="d",l="r",r="l"}
			v.way = o[v.way]
		end
    end
    function trigger.TFBlock()
    	for _,t in pairs(Workspace["TFBlock"])do
            if t.BOOL then
				t.BOOL = false;
			else
				t.BOOL = true;
			end
			Sound.Button:stop()
			Sound.Button:play()
		end
    end
end
function love.keypressed(key)
    if Player.Dead then
        for i = 1,10 do
            for _,v in pairs(Workspace)do
                for t,i in pairs(v)do
                    table.remove(v,t)
                end
            end
        end
        ResetStage()
        Player.Dead = false
    end
    if BeatStage then 
        BeatStage = false
        ResetStage(true)
        Music[MusicIndex]:stop()
        MusicIndex = index[love.math.random(#index)]
        Music[MusicIndex]:setVolume(0.4) --0.5
        Music[MusicIndex]:play()
    end
    if key =="m"then
    	if MUTED then
    		MUTED = false;
    	else
    		MUTED = true;
    	end
    end
    if key=="r"then
        ResetStage()
        Player.Image = Texture.PlayerR
    end
    if key=="lshift"then
        Player.Wait = SPEED_FAST
    end
    if key=="f"then
        IS_FULL_SCREEN = not IS_FULL_SCREEN
        success = love.window.setFullscreen(IS_FULL_SCREEN, "desktop")
        setBlockSize()
        ResetStage()
    end
    if KONAMI_INDEX == #KONAMI then
        CurrentStage = CurrentStage + 1
        ResetStage()
        KONAMI_INDEX = 1
    end
    if key == KONAMI[KONAMI_INDEX] then
        KONAMI_INDEX = KONAMI_INDEX + 1
    else
        KONAMI_INDEX = 1
    end
end
function love.keyreleased(key)
    if key=="lshift"then
        Player.Wait = SPEED_SLOW
    end
end

function love.update()
	if MUTED then
		Music[MusicIndex]:stop()
	else
		Music[MusicIndex]:play()
	end
    if Player.Dead then return end
    if BeatStage then return end
    --[[
    if Player.TIMELEFT <= 0 then Player.Dead = true end
    milisec = milisec - 1
	if milisec <= 0 then
		milisec = 50
		Player.TIMELEFT = Player.TIMELEFT - 1
	end
	--]]
    if#Workspace["Pinkball"]>=1 then
        if COOLDOWN.bounce <=0 then
            COOLDOWN.bounce = 9
           	for _,ball in pairs(Workspace["Pinkball"])do
           		if not canMove(ball.X+BLOCKSIZE.X,ball.Y)and not canMove(ball.X-BLOCKSIZE.X,ball.Y) then else
           			if not canMove(ball.X-BLOCKSIZE.X,ball.Y)then
           				ball.w="r"
           			elseif not canMove(ball.X+BLOCKSIZE.X,ball.Y)then
           				ball.w="l"
           			end
           			if ball.w =="r"then
           				ball.X = ball.X + BLOCKSIZE.X
           			else
           				ball.X = ball.X - BLOCKSIZE.X
           			end
           		end
           		-- triggers buttons.
				for _,v in pairs(Workspace["TFButton"])do
					if v.X == ball.X and v.Y == ball.Y then trigger.TFBlock()end
				end
				for _,v in pairs(Workspace["T_Button"])do
					if v.X == ball.X and v.Y == ball.Y then trigger.Tank()end
				end
           		if ball.X==Player.X and ball.Y==Player.Y then Player.Dead=true end
           	end
        end
        COOLDOWN.bounce = COOLDOWN.bounce - 1
    end
    if#Workspace["ConD"]>=1 or#Workspace["ConL"]>=1 or#Workspace["ConR"]>=1 or#Workspace["ConU"]>=1 then
        if COOLDOWN.conveyor == 6 then
            COOLDOWN.conveyor = 0
            for e,f in pairs(Workspace)do
                if Player.Inventory.HoverBoots then break end
                if e == "ConD"then
                	local BOOL=true
                    for _,f in pairs(f)do
                    	if BOOL then
                    		for _,m in pairs(Workspace["Moveable"])do
                    		   	if m.X == f.X and m.Y == f.Y then
                    		 		m.Y = m.Y + BLOCKSIZE.Y
                    		 		m.way = "down";
                    		 		BOOL=false;
                    		   		break
                    		    end
                    		end
                    	end
                        if (f.Y==Player.Y)and(f.X==Player.X)then
                            Player.moveDown();
                            Special.Iceway = "down"
                            break
                        end
                    end
                end
                if e == "ConL"then
                	local BOOL=true
                    for _,f in pairs(f)do
                    	if BOOL then
                    		for _,m in pairs(Workspace["Moveable"])do
                    		   	if m.X == f.X and m.Y == f.Y then
                    		 		m.X = m.X - BLOCKSIZE.X
                    		 		BOOL=false;
                    		 		m.way = "left";
                    		   		break
                    		    end
                    		end
                    	end
                        if (f.Y==Player.Y)and(f.X==Player.X)then
                            Player.moveLeft();
                            Special.Iceway = "left"
                            break
                        end
                    end
                end
                if e == "ConR"then
                	local BOOL = true;
                    for _,f in pairs(f)do
                    	if BOOL then
                    		for _,m in pairs(Workspace["Moveable"])do
                    		   	if m.X == f.X and m.Y == f.Y then
                    		 		m.X = m.X + BLOCKSIZE.X
                    		 		BOOL=false;
                    		 		m.way = "right";
                    		   		break
                    		    end
                    		end
                    	end
                        if (f.Y==Player.Y)and(f.X==Player.X)then
                            Player.moveRight();
                            Special.Iceway = "right"
                            break
                        end
                    end
                end
                if e == "ConU"then
                	local BOOL = true;
                    for _,f in pairs(f)do
                    	if BOOL then
                    		for _,m in pairs(Workspace["Moveable"])do
                    		   	if m.X == f.X and m.Y == f.Y then
                    		 		m.Y = m.Y - BLOCKSIZE.Y
                    		 		BOOL=false;
                    		 		m.way = "up";
                    		   		break
                    		    end
                    		end
                    	end
                        if (f.Y==Player.Y)and(f.X==Player.X)then
                            Player.moveUp();
                            Special.Iceway = "up"
                            break
                        end
                    end
                end
            end
        end
        COOLDOWN.conveyor = COOLDOWN.conveyor + 1
    end
    if#Workspace["Ice"]>=1 then
    	if Player.Inventory.IceSkates then else
    		local w={d={x=0,y=BLOCKSIZE.Y},u={x=0,y=(-BLOCKSIZE.Y)},l={x=(-BLOCKSIZE.X),y=0},r={x=BLOCKSIZE.X,y=0}}
			COOLDOWN.ice = COOLDOWN.ice - 1
			if COOLDOWN.ice <= 0 then
				COOLDOWN.ice = 4;
				for _,v in pairs(Workspace["Ice"])do
					if v.X == Player.X and v.Y == Player.Y then
						Player["move"..string.upper(string.sub(Special.Iceway,1,1))..string.sub(Special.Iceway,2)]()
						Player.Sliding = true; break
					else
						Player.Sliding = false;
					end
				end
				local opposite = {["up"]="down",["down"]="up",["left"]="right",["right"]="left"}
				local bool = false
				for _,ice in pairs(Workspace["Ice"])do
					for i,m in pairs(Workspace["Moveable"])do
						if ice.X == m.X and ice.Y == m.Y then
							local MX,MY = m.X+MovementDirections[m.way].x, m.Y+MovementDirections[m.way].y
							bool = true;
							if MX == Player.X and MY==Player.Y then
								Player["move"..string.upper(string.sub(m.way,0,1))..string.sub(m.way,2)]()
							end
							if not canMove(MX,MY,true)then
								m.way = opposite[m.way]
							end
							m.X = m.X + MovementDirections[m.way].x
							m.Y = m.Y + MovementDirections[m.way].y

							for n,f in pairs(Workspace)do
								for w,c in pairs(f)do
									if m.X == c.X and m.Y == c.Y then
										if n=="Water" or n=="Bomb"then
                                    		table.remove(Workspace["Moveable"],i)
                                        	table.remove(f,w)
                                        	if n=="Water"then
                                        		Add("Dirt",m.X/BLOCKSIZE.X,m.Y/BLOCKSIZE.Y)
                                            	Sound.Splash:play()
                                        	else
                                        	    Sound.Burn:play()
                                    	    end
                                    	elseif n=="TFButton"then
                                    	   	trigger.TFBlock()
										elseif n =="T_Button"then
											trigger.Tank()
                                    	elseif n=="Hint" or n=="ConD" or n=="ConL" or n=="ConR" or n=="ConU"or n=="Gravel"or n=="Ice"then
                                    	elseif n=="TFBlock" and c.BOOL==false then
                                   		end
                                	end
								end 
							end
							--[[
							for l,v in pairs(Workspace["Water"])do
								if v.X == m.X and v.Y == m.Y then
									Add("Dirt",m.X/BLOCKSIZE.X,m.Y/BLOCKSIZE.Y)
									table.remove(Workspace["Water"],l)
									table.remove(Workspace["Moveable"],i)
									Sound.Splash:play()
								end
							end
							--]]
							break
						end
                	end
                	if bool then break end
            	end
			end
		end
	end
	if#Workspace["Teeth"]>=1 then
		if COOLDOWN.teeth <= 0 then
			COOLDOWN.teeth=18;
			for _,creature in pairs(Workspace["Teeth"])do
				local value = false;
				if creature.Y > Player.Y and canMove(creature.X,creature.Y-BLOCKSIZE.Y) then
					value=true;
					creature.Y = creature.Y-BLOCKSIZE.Y;
					creature.image = "TeethU";
				elseif creature.Y < Player.Y and canMove(creature.X,creature.Y+BLOCKSIZE.Y) then
					value = true;
					creature.Y = creature.Y+BLOCKSIZE.Y;
					creature.image = "TeethD"
				end
				if value==false then 
					if creature.X > Player.X and canMove(creature.X-BLOCKSIZE.X,creature.Y) then
						creature.X = creature.X-BLOCKSIZE.X;
						creature.image = "TeethL"
					elseif creature.X < Player.X and canMove(creature.X+BLOCKSIZE.X,creature.Y) then
						creature.X = creature.X+BLOCKSIZE.X;
						creature.image = "TeethR"
					end
				end
				for _,v in pairs(Workspace["TFButton"])do
					if v.X == creature.X and v.Y == creature.Y then trigger.TFBlock()end
				end
				for _,v in pairs(Workspace["T_Button"])do
					if v.X == creature.X and v.Y == creature.Y then trigger.Tank()end
				end
			end
		end
		for _,creature in pairs(Workspace["Teeth"])do
			if creature.X==Player.X and creature.Y==Player.Y then Player.Dead=true;end
		end
		if COOLDOWN.teeth <= 0 then COOLDOWN.teeth = 18 end
		COOLDOWN.teeth = COOLDOWN.teeth - 1
	end
	if#Workspace["Bug"]>=1 then
		if COOLDOWN.bug <=0 then
			COOLDOWN.bug = 10
			local w={d={x=0,y=BLOCKSIZE.Y},u={x=0,y=(-BLOCKSIZE.Y)},l={x=(-BLOCKSIZE.X),y=0},r={x=BLOCKSIZE.X,y=0}}
			for i,bug in pairs(Workspace["Bug"])do
				local notTurned = true;
				if bug.way=="l"then
					if not canMove(bug.X+BLOCKSIZE.X,bug.Y+BLOCKSIZE.Y)and canMove(bug.X,bug.Y+BLOCKSIZE.Y)then
						notTurned = false;
						bug.way="d"
					end
				elseif bug.way=="r"then
					if not canMove(bug.X-BLOCKSIZE.X,bug.Y-BLOCKSIZE.Y)and canMove(bug.X,bug.Y-BLOCKSIZE.Y)then
						notTurned = false;
						bug.way="u"
					end
				elseif bug.way=="d"then
					if not canMove(bug.X+BLOCKSIZE.X,bug.Y-BLOCKSIZE.Y)and canMove(bug.X+BLOCKSIZE.X,bug.Y)then
						notTurned = false;
						bug.way="r"
					end
				elseif bug.way=="u"then
					if not canMove(bug.X-BLOCKSIZE.X,bug.Y+BLOCKSIZE.Y)and canMove(bug.X-BLOCKSIZE.X,bug.Y)then
						notTurned = false;
						bug.way="l"
					end
				end
				if notTurned then
					if bug.way == "r"then
						if not canMove(bug.X + BLOCKSIZE.X,bug.Y)and not canMove(bug.X,bug.Y-BLOCKSIZE.Y)then
							bug.way = "d"
						elseif not canMove(bug.X+BLOCKSIZE.X,bug.Y)and not canMove(bug.X,bug.Y+BLOCKSIZE.Y)then
							bug.way = "u"
						end
					elseif bug.way == "l"then
						if not canMove(bug.X-BLOCKSIZE.X,bug.Y)and not canMove(bug.X,bug.Y-BLOCKSIZE.Y)then
							bug.way = "d"
						elseif not canMove(bug.X-BLOCKSIZE.X,bug.Y)and not canMove(bug.X,bug.Y+BLOCKSIZE.Y)then
							bug.way = "u"
						end
					elseif bug.way =="d"then
						if not canMove(bug.X+BLOCKSIZE.X,bug.Y)and not canMove(bug.X,bug.Y+BLOCKSIZE.Y)then
							bug.way = "l"
						elseif not canMove(bug.X-BLOCKSIZE.X,bug.Y)and not canMove(bug.X,bug.Y+BLOCKSIZE.Y)then
							bug.way = "r"
						end
					elseif bug.way == "u"then
						if not canMove(bug.X+BLOCKSIZE.X,bug.Y)and not canMove(bug.X,bug.Y-BLOCKSIZE.Y)then
							bug.way = "l"
						elseif not canMove(bug.X-BLOCKSIZE.X,bug.Y)and not canMove(bug.X,bug.Y-BLOCKSIZE.Y)then
							bug.way = "r"
						end
					end
				end

				if not canMove(bug.X-BLOCKSIZE.X,bug.Y)and not canMove(bug.X,bug.Y+BLOCKSIZE.Y)and not canMove(bug.X,bug.Y-BLOCKSIZE.Y)then
					bug.way = "r"
				elseif not canMove(bug.X+BLOCKSIZE.X,bug.Y)and not canMove(bug.X-BLOCKSIZE.X,bug.Y)and not canMove(bug.X,bug.Y-BLOCKSIZE.Y)then
					bug.way = "d"
				elseif not canMove(bug.X+BLOCKSIZE.X,bug.Y)and not canMove(bug.X-BLOCKSIZE.X,bug.Y)and not canMove(bug.X,bug.Y+BLOCKSIZE.Y)then
					bug.way = "u"
				elseif not canMove(bug.X+BLOCKSIZE.X,bug.Y)and not canMove(bug.X,bug.Y+BLOCKSIZE.Y)and not canMove(bug.X,bug.Y-BLOCKSIZE.Y)then
					bug.way = "l"
				end

				if not canMove(bug.X+BLOCKSIZE.X,bug.Y)and not canMove(bug.X,bug.Y+BLOCKSIZE.Y)and not canMove(bug.X,bug.Y-BLOCKSIZE.Y) and not canMove(bug.X-BLOCKSIZE.X,bug.Y) then else
					bug.X = bug.X + w[bug.way].x
					bug.Y = bug.Y + w[bug.way].y
				end

				for _,v in pairs(Workspace["TFButton"])do
					if v.X == bug.X and v.Y == bug.Y then trigger.TFBlock()end
				end
				for _,v in pairs(Workspace["T_Button"])do
					if v.X == bug.X and v.Y == bug.Y then trigger.Tank()end
				end
                for _,v in pairs(Workspace["Water"])do
                    if v.X == bug.X and v.Y == bug.Y then table.remove(Workspace["Bug"],i)Sound.Splash:play()end
                end
				if bug.X==Player.X and bug.Y==Player.Y then Player.Dead=true;end
			end
		end
		COOLDOWN.bug=COOLDOWN.bug - 1
	end
	if#Workspace["Glider"]>=1 then
		if COOLDOWN.glider <= 0 then
			COOLDOWN.glider = 10
			for _,glider in pairs(Workspace["Glider"])do
				local w={d={x=0,y=BLOCKSIZE.Y},u={x=0,y=(-BLOCKSIZE.Y)},l={x=(-BLOCKSIZE.X),y=0},r={x=BLOCKSIZE.X,y=0}}
				if glider.way == "r"then
					if not canMove(glider.X + BLOCKSIZE.X,glider.Y)and not canMove(glider.X,glider.Y-BLOCKSIZE.Y)then
						glider.way = "d"
					elseif not canMove(glider.X+BLOCKSIZE.X,glider.Y)and not canMove(glider.X,glider.Y+BLOCKSIZE.Y)then
						glider.way = "u"
					end
				elseif glider.way == "l"then
					if not canMove(glider.X - BLOCKSIZE.X,glider.Y)and not canMove(glider.X,glider.Y-BLOCKSIZE.Y)then
						glider.way = "d"
					elseif not canMove(glider.X-BLOCKSIZE.X,glider.Y)and not canMove(glider.X,glider.Y+BLOCKSIZE.Y)then
						glider.way = "u"
					end
				elseif glider.way =="d"then
					if not canMove(glider.X+BLOCKSIZE.X,glider.Y)and not canMove(glider.X,glider.Y+BLOCKSIZE.Y)then
						glider.way = "l"
					elseif not canMove(glider.X-BLOCKSIZE.X,glider.Y)and not canMove(glider.X,glider.Y+BLOCKSIZE.Y)then
						glider.way = "r"
					end
				elseif glider.way == "u"then
					if not canMove(glider.X+BLOCKSIZE.X,glider.Y)and not canMove(glider.X,glider.Y-BLOCKSIZE.Y)then
						glider.way = "l"
					elseif not canMove(glider.X-BLOCKSIZE.X,glider.Y)and not canMove(glider.X,glider.Y-BLOCKSIZE.Y)then
						glider.way = "r"
					end
				end
				if glider.way == "u"then
					if not canMove(glider.X,glider.Y-BLOCKSIZE.Y)then
						glider.way = "l";
					end
				elseif glider.way == "d"then
					if not canMove(glider.X,glider.Y+BLOCKSIZE.Y)then
						glider.way = "r";
					end
				elseif glider.way == "r"then
					if not canMove(glider.X+BLOCKSIZE.X,glider.Y)then
						glider.way = "u";
					end
				elseif glider.way == "l"then
					if not canMove(glider.X-BLOCKSIZE.X,glider.Y)then
						glider.way = "d";
					end
				end
				if not canMove(glider.X-BLOCKSIZE.X,glider.Y)and not canMove(glider.X,glider.Y+BLOCKSIZE.Y)and not canMove(glider.X,glider.Y-BLOCKSIZE.Y)then
					glider.way = "r"
				elseif not canMove(glider.X+BLOCKSIZE.X,glider.Y)and not canMove(glider.X-BLOCKSIZE.X,glider.Y)and not canMove(glider.X,glider.Y-BLOCKSIZE.Y)then
					glider.way = "d"
				elseif not canMove(glider.X+BLOCKSIZE.X,glider.Y)and not canMove(glider.X-BLOCKSIZE.X,glider.Y)and not canMove(glider.X,glider.Y+BLOCKSIZE.Y)then
					glider.way = "u"
				elseif not canMove(glider.X+BLOCKSIZE.X,glider.Y)and not canMove(glider.X,glider.Y+BLOCKSIZE.Y)and not canMove(glider.X,glider.Y-BLOCKSIZE.Y)then
					glider.way = "l"
				end
				if not canMove(glider.X+BLOCKSIZE.X,glider.Y)and not canMove(glider.X,glider.Y+BLOCKSIZE.Y)and not canMove(glider.X,glider.Y-BLOCKSIZE.Y) and not canMove(glider.X-BLOCKSIZE.X,glider.Y) then else
					glider.X = glider.X + w[glider.way].x
					glider.Y = glider.Y + w[glider.way].y
				end
				-- triggers buttons.
				for _,v in pairs(Workspace["TFButton"])do
					if v.X == glider.X and v.Y == glider.Y then trigger.TFBlock()end
				end
				for _,v in pairs(Workspace["T_Button"])do
					if v.X == glider.X and v.Y == glider.Y then trigger.Tank()end
				end

			end
			for _,Creatur in pairs(Workspace["Glider"])do
				if Creatur.X==Player.X and Creatur.Y==Player.Y then Player.Dead=true;end
			end
		end
		COOLDOWN.glider = COOLDOWN.glider - 1 
	end
	if#Workspace["Tank"]>=1 then
		if COOLDOWN.tank <= 0 then
			COOLDOWN.tank = 10;
			local w={d={x=0,y=BLOCKSIZE.Y},u={x=0,y=(-BLOCKSIZE.Y)},l={x=(-BLOCKSIZE.X),y=0},r={x=BLOCKSIZE.X,y=0}}
			local o={d="u",u="d",l="r",r="l"}
			for _,creature in pairs(Workspace["Tank"])do
				if canMove(creature.X+w[creature.way].x,creature.Y+w[creature.way].y)then
					creature.X = creature.X + w[creature.way].x
					creature.Y = creature.Y + w[creature.way].y
				end
				-- triggers buttons.
				for _,v in pairs(Workspace["TFButton"])do
					if v.X == creature.X and v.Y == creature.Y then trigger.TFBlock()end
				end
				for _,v in pairs(Workspace["T_Button"])do
					if v.X == creature.X and v.Y == creature.Y then trigger.Tank()end
				end
				if creature.X==Player.X and creature.Y==Player.Y then Player.Dead=true;end
           	end
		end
		COOLDOWN.tank = COOLDOWN.tank - 1
	end
	if#Workspace["Walker"]>=1 then
		if COOLDOWN.walker <= 0 then
			COOLDOWN.walker = 9
			for _,walker in pairs(Workspace["Walker"])do
				local w={d={x=0,y=BLOCKSIZE.Y},u={x=0,y=(-BLOCKSIZE.Y)},l={x=(-BLOCKSIZE.X),y=0},r={x=BLOCKSIZE.X,y=0}}
				local notTurned = true;
				if walker.way == "r"then
					if not canMove(walker.X + BLOCKSIZE.X,walker.Y)and not canMove(walker.X,walker.Y-BLOCKSIZE.Y)then
						notTurned = false;
						walker.way = "d"
					elseif not canMove(walker.X+BLOCKSIZE.X,walker.Y)and not canMove(walker.X,walker.Y+BLOCKSIZE.Y)then
						notTurned = false;
						walker.way = "u"
					end
				elseif walker.way == "l"then
					if not canMove(walker.X - BLOCKSIZE.X,walker.Y)and not canMove(walker.X,walker.Y-BLOCKSIZE.Y)then
						notTurned = false;
						walker.way = "d"
					elseif not canMove(walker.X-BLOCKSIZE.X,walker.Y)and not canMove(walker.X,walker.Y+BLOCKSIZE.Y)then
						notTurned = false;
						walker.way = "u"
					end
				elseif walker.way =="d"then
					if not canMove(walker.X+BLOCKSIZE.X,walker.Y)and not canMove(walker.X,walker.Y+BLOCKSIZE.Y)then
						notTurned = false;
						walker.way = "l"
					elseif not canMove(walker.X-BLOCKSIZE.X,walker.Y)and not canMove(walker.X,walker.Y+BLOCKSIZE.Y)then
						notTurned = false;
						walker.way = "r"
					end
				elseif walker.way == "u"then
					if not canMove(walker.X+BLOCKSIZE.X,walker.Y)and not canMove(walker.X,walker.Y-BLOCKSIZE.Y)then
						notTurned = false;
						walker.way = "l"
					elseif not canMove(walker.X-BLOCKSIZE.X,walker.Y)and not canMove(walker.X,walker.Y-BLOCKSIZE.Y)then
						notTurned = false;
						walker.way = "r"
					end
				end
				if notTurned then
					local turn = math.random(1,2)
					if walker.way == "u"then
						if not canMove(walker.X,walker.Y-BLOCKSIZE.Y)then
							if turn == 1 then
								walker.way = "l";
							else
								walker.way = "r";
							end
						end
					elseif walker.way == "d"then
						if not canMove(walker.X,walker.Y+BLOCKSIZE.Y)then
							if turn == 1 then
								walker.way = "l";
							else
								walker.way = "r";
							end
						end
					elseif walker.way == "r"then
						if not canMove(walker.X+BLOCKSIZE.X,walker.Y)then
							if turn == 1 then
								walker.way = "u";
							else
								walker.way = "d";
							end
						end
					elseif walker.way == "l"then
						if not canMove(walker.X-BLOCKSIZE.X,walker.Y)then
							if turn == 1 then
								walker.way = "u";
							else
								walker.way = "d";
							end
						end
					end
				end
				if not canMove(walker.X-BLOCKSIZE.X,walker.Y)and not canMove(walker.X,walker.Y+BLOCKSIZE.Y)and not canMove(walker.X,walker.Y-BLOCKSIZE.Y)then
					walker.way = "r"
				elseif not canMove(walker.X+BLOCKSIZE.X,walker.Y)and not canMove(walker.X-BLOCKSIZE.X,walker.Y)and not canMove(walker.X,walker.Y-BLOCKSIZE.Y)then
					walker.way = "d"
				elseif not canMove(walker.X+BLOCKSIZE.X,walker.Y)and not canMove(walker.X-BLOCKSIZE.X,walker.Y)and not canMove(walker.X,walker.Y+BLOCKSIZE.Y)then
					walker.way = "u"
				elseif not canMove(walker.X+BLOCKSIZE.X,walker.Y)and not canMove(walker.X,walker.Y+BLOCKSIZE.Y)and not canMove(walker.X,walker.Y-BLOCKSIZE.Y)then
					walker.way = "l"
				end
				if not canMove(walker.X+BLOCKSIZE.X,walker.Y)and not canMove(walker.X,walker.Y+BLOCKSIZE.Y)and not canMove(walker.X,walker.Y-BLOCKSIZE.Y) and not canMove(walker.X-BLOCKSIZE.X,walker.Y) then else
					walker.X = walker.X + w[walker.way].x
					walker.Y = walker.Y + w[walker.way].y
				end
				-- triggers buttons.
				for _,v in pairs(Workspace["TFButton"])do
					if v.X == walker.X and v.Y == walker.Y then trigger.TFBlock()end
				end
				for _,v in pairs(Workspace["T_Button"])do
					if v.X == walker.X and v.Y == walker.Y then trigger.Tank()end
				end
			end
			for _,Creatur in pairs(Workspace["Walker"])do
				if Creatur.X==Player.X and Creatur.Y==Player.Y then Player.Dead=true;end
			end
		end
		COOLDOWN.walker = COOLDOWN.walker - 1 
	end
	if#Workspace["Fireball"]>=1 then
		if COOLDOWN.fireball <= 0 then
			COOLDOWN.fireball = 10
			for _,fireball in pairs(Workspace["Fireball"])do
				local w={d={x=0,y=BLOCKSIZE.Y},u={x=0,y=(-BLOCKSIZE.Y)},l={x=(-BLOCKSIZE.X),y=0},r={x=BLOCKSIZE.X,y=0}}
				if fireball.way == "r"then
					if not canMove(fireball.X + BLOCKSIZE.X,fireball.Y)and not canMove(fireball.X,fireball.Y-BLOCKSIZE.Y)then
						fireball.way = "d"
					elseif not canMove(fireball.X+BLOCKSIZE.X,fireball.Y)and not canMove(fireball.X,fireball.Y+BLOCKSIZE.Y)then
						fireball.way = "u"
					end
				elseif fireball.way == "l"then
					if not canMove(fireball.X - BLOCKSIZE.X,fireball.Y)and not canMove(fireball.X,fireball.Y-BLOCKSIZE.Y)then
						fireball.way = "d"
					elseif not canMove(fireball.X-BLOCKSIZE.X,fireball.Y)and not canMove(fireball.X,fireball.Y+BLOCKSIZE.Y)then
						fireball.way = "u"
					end
				elseif fireball.way =="d"then
					if not canMove(fireball.X+BLOCKSIZE.X,fireball.Y)and not canMove(fireball.X,fireball.Y+BLOCKSIZE.Y)then
						fireball.way = "l"
					elseif not canMove(fireball.X-BLOCKSIZE.X,fireball.Y)and not canMove(fireball.X,fireball.Y+BLOCKSIZE.Y)then
						fireball.way = "r"
					end
				elseif fireball.way == "u"then
					if not canMove(fireball.X+BLOCKSIZE.X,fireball.Y)and not canMove(fireball.X,fireball.Y-BLOCKSIZE.Y)then
						fireball.way = "l"
					elseif not canMove(fireball.X-BLOCKSIZE.X,fireball.Y)and not canMove(fireball.X,fireball.Y-BLOCKSIZE.Y)then
						fireball.way = "r"
					end
				end
				if fireball.way == "u"then
					if not canMove(fireball.X,fireball.Y-BLOCKSIZE.Y)then
						fireball.way = "r";
				end
				elseif fireball.way == "d"then
					if not canMove(fireball.X,fireball.Y+BLOCKSIZE.Y)then
						fireball.way = "l";
					end
				elseif fireball.way == "r"then
					if not canMove(fireball.X+BLOCKSIZE.X,fireball.Y)then
						fireball.way = "d";
					end
				elseif fireball.way == "l"then
					if not canMove(fireball.X-BLOCKSIZE.X,fireball.Y)then
						fireball.way = "u";
					end
				end
				if not canMove(fireball.X-BLOCKSIZE.X,fireball.Y)and not canMove(fireball.X,fireball.Y+BLOCKSIZE.Y)and not canMove(fireball.X,fireball.Y-BLOCKSIZE.Y)then
					fireball.way = "r"
				elseif not canMove(fireball.X+BLOCKSIZE.X,fireball.Y)and not canMove(fireball.X-BLOCKSIZE.X,fireball.Y)and not canMove(fireball.X,fireball.Y-BLOCKSIZE.Y)then
					fireball.way = "d"
				elseif not canMove(fireball.X+BLOCKSIZE.X,fireball.Y)and not canMove(fireball.X-BLOCKSIZE.X,fireball.Y)and not canMove(fireball.X,fireball.Y+BLOCKSIZE.Y)then
					fireball.way = "u"
				elseif not canMove(fireball.X+BLOCKSIZE.X,fireball.Y)and not canMove(fireball.X,fireball.Y+BLOCKSIZE.Y)and not canMove(fireball.X,fireball.Y-BLOCKSIZE.Y)then
					fireball.way = "l"
				end
				if not canMove(fireball.X+BLOCKSIZE.X,fireball.Y)and not canMove(fireball.X,fireball.Y+BLOCKSIZE.Y)and not canMove(fireball.X,fireball.Y-BLOCKSIZE.Y) and not canMove(fireball.X-BLOCKSIZE.X,fireball.Y) then else
					fireball.X = fireball.X + w[fireball.way].x
					fireball.Y = fireball.Y + w[fireball.way].y
				end
				-- triggers buttons.
				for _,v in pairs(Workspace["TFButton"])do
					if v.X == fireball.X and v.Y == fireball.Y then trigger.TFBlock()end
				end
				for _,v in pairs(Workspace["T_Button"])do
					if v.X == fireball.X and v.Y == fireball.Y then trigger.Tank()end
				end

			end
			for _,Creatur in pairs(Workspace["Fireball"])do
				if Creatur.X==Player.X and Creatur.Y==Player.Y then Player.Dead=true;end
			end
		end
		COOLDOWN.fireball = COOLDOWN.fireball - 1 
	end
    if#Workspace["Blob"]>=1 then
        if COOLDOWN.blob <= 0 then
            COOLDOWN.blob = 13
            for i,blob in pairs(Workspace["Blob"])do
                local moved = false;
                while moved == false do
                    local randomMove = math.random(1,4)
                    if randomMove == 1 then
                        if canMove(blob.X+BLOCKSIZE.X,blob.Y)then
                            blob.way="r"
                            moved = true;
                        end
                    elseif randomMove == 2 then
                        if canMove(blob.X-BLOCKSIZE.X,blob.Y)then
                            blob.way="l"
                            moved = true;
                        end
                    elseif randomMove == 3 then
                        if canMove(blob.X,blob.Y+BLOCKSIZE.Y)then
                            blob.way="d"
                            moved = true;
                        end
                    else
                        if canMove(blob.X,blob.Y-BLOCKSIZE.Y)then
                            blob.way="u"
                            moved = true;
                        end
                    end
                    if not canMove(blob.X+BLOCKSIZE.X,blob.Y)and not canMove(blob.X,blob.Y+BLOCKSIZE.Y)and not canMove(blob.X,blob.Y-BLOCKSIZE.Y) and not canMove(blob.X-BLOCKSIZE.X,blob.Y) then break end
                end
                if moved then 
                    local w={d={x=0,y=BLOCKSIZE.Y},u={x=0,y=(-BLOCKSIZE.Y)},l={x=(-BLOCKSIZE.X),y=0},r={x=BLOCKSIZE.X,y=0}}
                    blob.X = blob.X + w[blob.way].x
                    blob.Y = blob.Y + w[blob.way].y
                end
                -- triggers buttons.
                for _,v in pairs(Workspace["TFButton"])do
                    if v.X == blob.X and v.Y == blob.Y then trigger.TFBlock()end
                end
                for _,v in pairs(Workspace["T_Button"])do
                    if v.X == blob.X and v.Y == blob.Y then trigger.Tank()end
                end
                for _,v in pairs(Workspace["Water"])do
                    if v.X == blob.X and v.Y == blob.Y then table.remove(Workspace["Blob"],i)Sound.Splash:play()end
                end
                if blob.X==Player.X and blob.Y==Player.Y then Player.Dead=true;end
            end
        end
        COOLDOWN.blob = COOLDOWN.blob - 1
    end

    Player.cooldown = Player.cooldown + 1
    if Player.Inventory.IceSkates then else
    	if Player.Sliding then return end
	end
    if love.keyboard.isDown("up")or love.keyboard.isDown("w")then
        if Player.cooldown >= Player.Wait then
            Player.cooldown = 0
            Special.Iceway = "up";
            Player.moveUp();
        end
    elseif love.keyboard.isDown("down")or love.keyboard.isDown("s")then
        if Player.cooldown >= Player.Wait then
            Player.cooldown = 0
            Special.Iceway = "down";
            Player.moveDown();
        end
    elseif love.keyboard.isDown("right")or love.keyboard.isDown("d")then
        if Player.cooldown >= Player.Wait then
            Player.cooldown = 0
            Special.Iceway = "right";
            Player.moveRight();
        end
    elseif love.keyboard.isDown("left")or love.keyboard.isDown("a")then
        if Player.cooldown >= Player.Wait then
            Player.cooldown = 0
            Special.Iceway = "left";
            Player.moveLeft();
        end
    end
    if Player.image == Texture.Splash then Player.image = Texture.PlayerL end
end

function love.draw()
    love.graphics.setColor(255,255,255)
    for _, v in pairs(Floor)do love.graphics.draw(Texture.Plate,v.X,v.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)end
    for i,v in pairs(Workspace)do
        for _,f in pairs(v)do
            if i == "YellowKey"then
                love.graphics.setColor(255,200,0)
                love.graphics.draw(Texture.Key,f.X,f.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
            elseif i == "GreenKey"then
                love.graphics.setColor(0,255,0)
                love.graphics.draw(Texture.Key,f.X,f.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
            elseif i == "BlueKey"then
                love.graphics.setColor(0,0,255)
                love.graphics.draw(Texture.Key,f.X,f.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
            elseif i == "RedKey"then
                love.graphics.setColor(255,0,0)
                love.graphics.draw(Texture.Key,f.X,f.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
            elseif i == "Dirt"then
                love.graphics.setColor(102,51,0)
                love.graphics.rectangle("fill",f.X,f.Y,BLOCKSIZE.X,BLOCKSIZE.Y)
            elseif i == "Teeth"then
            	love.graphics.setColor(255,255,255)
            	love.graphics.draw(Texture[f.image],f.X,f.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
            elseif i == "LockR"then
            	love.graphics.setColor(255,255,255)
            	love.graphics.draw(Texture.Block,f.X,f.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
            	love.graphics.draw(love.graphics.newImage("/Texture/Objects/L_OUTLINE.png"),f.X,f.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
            	love.graphics.setColor(255,0,0)
            	love.graphics.draw(Texture.Lock,f.X,f.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
            elseif i == "LockY"then
            	love.graphics.setColor(255,255,255)
            	love.graphics.draw(Texture.Block,f.X,f.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
            	love.graphics.draw(love.graphics.newImage("/Texture/Objects/L_OUTLINE.png"),f.X,f.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
            	love.graphics.setColor(255,200,0)
            	love.graphics.draw(Texture.Lock,f.X,f.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
            elseif i == "LockB"then
            	love.graphics.setColor(255,255,255)
            	love.graphics.draw(Texture.Block,f.X,f.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
            	love.graphics.draw(love.graphics.newImage("/Texture/Objects/L_OUTLINE.png"),f.X,f.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
            	love.graphics.setColor(0,0,255)
            	love.graphics.draw(Texture.Lock,f.X,f.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
            elseif i == "LockG"then
            	love.graphics.setColor(255,255,255)
            	love.graphics.draw(Texture.Block,f.X,f.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
            	love.graphics.draw(love.graphics.newImage("/Texture/Objects/L_OUTLINE.png"),f.X,f.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
            	love.graphics.setColor(0,255,0)
            	love.graphics.draw(Texture.Lock,f.X,f.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
            elseif i=="BlueTile"or i=="BlueTinged"then
                love.graphics.setColor(255,255,255);
                love.graphics.draw(Texture.BlueWall,f.X,f.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02);
        	elseif i=="Glider"or i=="TFBlock"or i=="Bug"or i=="Tank"or i=="Walker"or i=="Pinkball"or i=="Fireball"or i=="Blob"or i=="HiddenWall"or i=="InvisibleWall"then

            else
                love.graphics.setColor(255,255,255);
                love.graphics.draw(Texture[i],f.X,f.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02);
            end
        end
    end
    love.graphics.setColor(255,255,255)
    for i,v in pairs(Workspace)do
    	for _,f in pairs(v)do
    		if i == "Glider"then
       			love.graphics.draw(Texture.Glider[f.way],f.X,f.Y)
       		elseif i == "Bug"then
       			love.graphics.draw(Texture.Bug[f.way],f.X,f.Y);
       		elseif i =="Tank"then
       			love.graphics.draw(Texture.Tank[f.way],f.X,f.Y);
       		elseif i=="Moveable"or i=="Walker"or i=="Pinkball"or i=="Fireball"or i=="Blob"then
       			love.graphics.draw(Texture[i],f.X,f.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
       		elseif i == "TFBlock"then
            	if f.BOOL then
       				love.graphics.draw(Texture.Block,f.X,f.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
       				love.graphics.draw(Texture.TFBlock,f.X,f.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
       			else
      				love.graphics.draw(Texture.TFBlock,f.X,f.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
        		end
    		end
    	end
    end
    love.graphics.setColor(255,255,255)
    love.graphics.draw(Player.Image,Player.X,Player.Y,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
    love.graphics.draw(Texture.SideBar.MAINFRAME,BLOCKSIZE.X*13,0,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
    love.graphics.draw(Texture.SideBar.LEVEL,BLOCKSIZE.X*14,BLOCKSIZE.Y*0.5)
    love.graphics.draw(Texture.SideBar.TIME,BLOCKSIZE.X*14,BLOCKSIZE.Y*3.5)
    love.graphics.draw(Texture.SideBar.KEXLEFT,BLOCKSIZE.X*14.2,BLOCKSIZE.Y*6.3)
    for i = 1,3 do love.graphics.draw(Texture.SideBar.NUM,(BLOCKSIZE.X*14.35)+(37*i)-37,BLOCKSIZE.Y*1.5)end
    for i = 1,3 do love.graphics.draw(Texture.SideBar.NUM,(BLOCKSIZE.X*14.35)+(37*i)-37,BLOCKSIZE.Y*4.5)end
    for i = 1,3 do love.graphics.draw(Texture.SideBar.NUM,(BLOCKSIZE.X*14.35)+(37*i)-37,BLOCKSIZE.Y*8.5)end
    love.graphics.draw(Texture.SideBar.OUTLINE,BLOCKSIZE.X*14.3,BLOCKSIZE.Y*1.45)
    love.graphics.draw(Texture.SideBar.OUTLINE,BLOCKSIZE.X*14.3,BLOCKSIZE.Y*4.45)
    love.graphics.draw(Texture.SideBar.OUTLINE,BLOCKSIZE.X*14.3,BLOCKSIZE.Y*8.45)
    --[[
    local num1, num2 = math.floor(CurrentStage/10),Decimal(CurrentStage)
    if CurrentStage >= 10 then -- NUMBERS 
    	love.graphics.draw(Texture.SideBar.NUMBERS[num1],(BLOCKSIZE.X*14.35)+37,BLOCKSIZE.Y*1.5)
    	if Decimal(CurrentStage) == 0 then
    		love.graphics.draw(Texture.SideBar.NUMBERS[0],(BLOCKSIZE.X*14.35)+74,BLOCKSIZE.Y*1.5)
    	else
        	love.graphics.draw(Texture.SideBar.NUMBERS[num2],(BLOCKSIZE.X*14.35)+74,BLOCKSIZE.Y*1.5)
    	end
    else
    	love.graphics.draw(Texture.SideBar.NUMBERS[num2],(BLOCKSIZE.X*14.35)+74,BLOCKSIZE.Y*1.5)
    end
    --]]
    local num1, num2 = math.floor(KexLeft/10),Decimal(KexLeft)
    if KexLeft >= 10 then -- NUMBERS 
    	love.graphics.draw(Texture.SideBar.NUMBERS[num1],(BLOCKSIZE.X*14.35)+37,BLOCKSIZE.Y*8.5)
    	if Decimal(KexLeft) == 0 then
    		love.graphics.draw(Texture.SideBar.NUMBERS[0],(BLOCKSIZE.X*14.35)+74,BLOCKSIZE.Y*8.5)
    	else
        	love.graphics.draw(Texture.SideBar.NUMBERS[num2],(BLOCKSIZE.X*14.35)+74,BLOCKSIZE.Y*8.5)
    	end
    else
    	love.graphics.draw(Texture.SideBar.NUMBERS[num2],(BLOCKSIZE.X*14.35)+74,BLOCKSIZE.Y*8.5)
    end
    --[[
    if Player.TIMELEFT >= 10 then -- NUMBERS 
    	local num1, num2 = math.ceil(Player.TIMELEFT/10),Decimal(Player.TIMELEFT)
    	love.graphics.draw(Texture.SideBar.NUMBERS[num1],(BLOCKSIZE.X*14.35)+37,BLOCKSIZE.Y*1.5)
    	if Decimal(Player.TIMELEFT) == 0 then
    		love.graphics.draw(Texture.SideBar.NUMBER[0],(BLOCKSIZE.X*14.35)+74,BLOCKSIZE.Y*1.5)
    	else
        	love.graphics.draw(Texture.SideBar.NUMBERS[num2],(BLOCKSIZE.X*14.35)+74,BLOCKSIZE.Y*1.5)
    	end
    else
    	love.graphics.draw(Texture.SideBar.NUMBERS[num2],(BLOCKSIZE.X*14.35)+74,BLOCKSIZE.Y*1.5)
    end
    if Player.TIMELEFT >= 10 then -- NUMBERS
    	local num1, num2 = math.floor(Player.TIMELEFT/10), Decimal(Player.TIMELEFT)
    	love.graphics.draw(Texture.SideBar.NUMBERS[num1],(BLOCKSIZE.X*14.35)+37,BLOCKSIZE.Y*4.5)
    	if num2 == 9 then
    		love.graphics.draw(Texture.SideBar.NUMBERS[9],(BLOCKSIZE.X*14.35)+74,BLOCKSIZE.Y*4.5)
    	elseif num2 == 8 then
    		love.graphics.draw(Texture.SideBar.NUMBERS[8],(BLOCKSIZE.X*14.35)+74,BLOCKSIZE.Y*4.5)
    	elseif num2 == 7 then
    		love.graphics.draw(Texture.SideBar.NUMBERS[7],(BLOCKSIZE.X*14.35)+74,BLOCKSIZE.Y*4.5)
    	elseif num2 == 6 then
    		love.graphics.draw(Texture.SideBar.NUMBERS[6],(BLOCKSIZE.X*14.35)+74,BLOCKSIZE.Y*4.5)
    	elseif num2 == 5 then
    		love.graphics.draw(Texture.SideBar.NUMBERS[5],(BLOCKSIZE.X*14.35)+74,BLOCKSIZE.Y*4.5)
    	elseif num2 == 4 then
    		love.graphics.draw(Texture.SideBar.NUMBERS[4],(BLOCKSIZE.X*14.35)+74,BLOCKSIZE.Y*4.5)
    	elseif num2 == 3 then
    		love.graphics.draw(Texture.SideBar.NUMBERS[3],(BLOCKSIZE.X*14.35)+74,BLOCKSIZE.Y*4.5)
    	elseif num2 == 2 then
    		love.graphics.draw(Texture.SideBar.NUMBERS[2],(BLOCKSIZE.X*14.35)+74,BLOCKSIZE.Y*4.5)
    	end
    	if num2 == 1 then
    		love.graphics.draw(love.graphics.newImage("/Texture/SideBar/NUMBERS/ONE.png"),(BLOCKSIZE.X*14.35)+74,BLOCKSIZE.Y*4.5)	
    	end
        love.graphics.print(num1.."\n"..num2,20,10)
    else
    	love.graphics.draw(Texture.SideBar.NUMBERS[num2],(BLOCKSIZE.X*14.35)+74,BLOCKSIZE.Y*4.5)
    end
    --]]

    love.graphics.setColor(50,50,50)
    love.graphics.rectangle("line",BLOCKSIZE.X*13,0,BLOCKSIZE.X*5,RESOLUTION.SCREEN_SIZE.y)
    love.graphics.setColor(255,255,255)

    if CurrentStage == "test"then
        love.graphics.print("Level: TEST",BLOCKSIZE.X*13.1,BLOCKSIZE.Y*0.1,0,1,1)
        love.graphics.print("\nBLOCK X: "..BLOCKSIZE.X.."\nBLOCK Y: "..BLOCKSIZE.Y.."\nPlayerPosX: "..Player.X.."\nPlayerPosY: "..Player.Y.."\nBlockPos X,Y "..Workspace["Block"][1].X.."\n"..Workspace["Block"][1].Y,BLOCKSIZE.X*13.1,BLOCKSIZE.Y*0.1,0,1,1)
    else
    	--[[
        love.graphics.print("Level: ".. StageInfo.LevelIndex[CurrentStage],BLOCKSIZE.X*13.3,BLOCKSIZE.Y*0.3)
        love.graphics.print("\nTiger biscuits left: "..KexLeft ,BLOCKSIZE.X*13.3,BLOCKSIZE.Y*0.3)
        --]]
    end
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("line",BLOCKSIZE.X*13.5,BLOCKSIZE.Y*10.5,BLOCKSIZE.X*4,BLOCKSIZE.Y*2)
    love.graphics.setColor(255,255,255)
    for i =1,4 do
    	love.graphics.draw(Texture.Plate,(BLOCKSIZE.X*13.5)+(BLOCKSIZE.X*i)-BLOCKSIZE.X,BLOCKSIZE.Y*10.5)
    	love.graphics.draw(Texture.Plate,(BLOCKSIZE.X*13.5)+(BLOCKSIZE.X*i)-BLOCKSIZE.X,(BLOCKSIZE.Y*10.5)+BLOCKSIZE.Y)
    end

    if Player.Inventory.Flippers then
        love.graphics.setColor(255,255,255)
        love.graphics.draw(Texture.Flippers,BLOCKSIZE.X*13.5,BLOCKSIZE.Y*10.5,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
    end
    if Player.Inventory.FireShoes then
        love.graphics.setColor(255,255,255)
        love.graphics.draw(Texture.Fireshoes,BLOCKSIZE.X*14.5,BLOCKSIZE.Y*10.5,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
    end
    if Player.Inventory.RedKey then
        love.graphics.setColor(255,0,0)
        love.graphics.draw(Texture.Key,BLOCKSIZE.X*13.5,BLOCKSIZE.Y*11.5,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
    end
    if Player.Inventory.BlueKey then
        love.graphics.setColor(0,0,255)
        love.graphics.draw(Texture.Key,BLOCKSIZE.X*14.5,BLOCKSIZE.Y*11.5,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
    end
    if Player.Inventory.GreenKey then
        love.graphics.setColor(0,255,0)
        love.graphics.draw(Texture.Key,BLOCKSIZE.X*15.5,BLOCKSIZE.Y*11.5,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
    end
    if Player.Inventory.YellowKey then
        love.graphics.setColor(255,200,0)
        love.graphics.draw(Texture.Key,BLOCKSIZE.X*16.5,BLOCKSIZE.Y*11.5,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
    end
    if Player.Inventory.HoverBoots then
        love.graphics.setColor(255,255,255)
        love.graphics.draw(Texture.HoverBoots,BLOCKSIZE.X*15.5,BLOCKSIZE.Y*10.5,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
    end
     if Player.Inventory.IceSkates then
        love.graphics.setColor(255,255,255)
        love.graphics.draw(Texture.IceSkates,BLOCKSIZE.X*16.5,BLOCKSIZE.Y*10.5,0,BLOCKSIZE.X*0.02,BLOCKSIZE.Y*0.02)
    end
    if Player.Hint then
        love.graphics.setColor(255,255,255)
        love.graphics.print(StageInfo.LevelsInfo[StageInfo.LevelIndex[CurrentStage]].hint,BLOCKSIZE.X*13.1,BLOCKSIZE.Y*4)
    end
    if BeatStage then
        love.graphics.setColor(150,150,150)
        love.graphics.rectangle("fill",100,150,450,350)
        love.graphics.setColor(0,0,0)
        love.graphics.rectangle("line",100,150,450,350)
        love.graphics.draw(Texture.SideBar.WIN,100,150)
    end
    if Player.Dead then
        love.graphics.setColor(150,150,150)
        love.graphics.rectangle("fill",100,150,450,350)
        love.graphics.setColor(0,0,0)
        love.graphics.rectangle("line",100,150,450,350)
        love.graphics.draw(Texture.Lose,100,150)
    end
end