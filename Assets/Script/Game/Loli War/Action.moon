Dorothy builtin.Platformer

{store:Store} = Data
{
	:LayerBunny
	:LayerBlock
	:GroupPlayerPoke
	:GroupEnemyPoke
	:GroupPlayer
	:GroupEnemy
	:MaxBunnies
} = Store

UnitAction\add "fallOff",
	priority: 1
	reaction: 0.1
	recovery: 0
	available: => not @onSurface
	create: =>
		with @model
			.speed = 1.5
			.loop = true
			\resume "jump"
		=>
			if @onSurface
				return true
			false,
	stop: =>
		@model\stop!

pushSwitchEnd = (name,model)->
	switch name
		when "switch","attack"
			model.parent\stop!

UnitAction\add "pushSwitch",
	priority: 3
	reaction: 3
	recovery: 0.2
	available: => @onSurface
	create: =>
		with @model
			.speed = 1.5
			.loop = false
			.look = "noweapon"
			\play "switch"
			if not .playing
				\play "attack"
			\slot "AnimationEnd",pushSwitchEnd
		with @entity.atSwitch
			.entity.pushed = true
			.entity.fromRight = @x > .x
		-> false,
	stop: =>
		@model\slot("AnimationEnd")\remove pushSwitchEnd
		@model\stop!

UnitAction\add "waitUser",
	priority: 1
	reaction: 0.1
	recovery: 0.2
	available: -> true
	create: =>
		with @model
			.speed = 1
			.loop = true
			\play "idle"
		-> false,
	stop: =>
		@model\stop!

switchPushed = (name,model)->
	switch name
		when "pushRight","pushLeft"
			model.parent\stop!

UnitAction\add "pushed",
	priority: 2
	reaction: 0.1
	recovery: 0.2
	available: -> true
	create: =>
		with @model
			.recovery = 0.2
			.speed = 1.5
			\play @entity.fromRight and "pushRight" or "pushLeft"
			\slot "AnimationEnd",switchPushed
		once =>
			sleep 0.5
			Audio\play "Audio/switch.wav"
			heroes = Group {"hero"}
			switch @entity.switch_
				when "Switch"
					heroes\each (hero)->
						if @group == hero.group and hero.ep >= 1
							with Entity!
								.bunny,.group,.faceRight,.position = switch @group
									when GroupPlayer
										"BunnyG",GroupPlayer,true,Vec2 1000,1004-500
									when GroupEnemy
										"BunnyP",GroupEnemy,false,Vec2 3130,1004-500
								.AI = "BunnyForwardReturnAI"
								.layer = LayerBunny
								bunnyCount = 0
								Group({"bunny"})\each (bunny)->
									bunnyCount += 1 if bunny.group == @group
								.hp = 0 if bunnyCount > MaxBunnies
							emit "EPChange",@group,-1
							return true
				when "SwitchG"
					heroes\each (hero)->
						if @group == hero.group and hero.ep >= 2
							with Entity!
								.layer = LayerBlock
								.poke,.group,.position = switch @group
									when GroupPlayer
										"pokeb",GroupPlayerPoke,Vec2 192,1004-512
									when GroupEnemy
										"pokep",GroupEnemyPoke,Vec2 3904,1004-512
							emit "EPChange",@group,-2
							return true
			while true
				sleep!
	stop: =>
		@entity.pushed = false
		@model\slot("AnimationEnd")\remove pushSwitchEnd
		@model\stop!

strikeEnd = (name,model)->
	model.parent\stop! if name == "hit"

UnitAction\add "strike",
	priority: 4
	reaction: 3
	recovery: 0
	available: => true
	create: =>
		with @model
			.speed = 1
			.loop = false
			.look = "sad"
			\play "hit"
			\slot "AnimationEnd",strikeEnd
		Audio\play "Audio/hit.wav"
		-> false,
	stop: =>
		@model\slot("AnimationEnd")\remove strikeEnd
		@model\stop!

villyAttackEnd = (name,model)->
	model.parent\stop! if name == "attack"

UnitAction\add "villyAttack",
	priority: 3
	reaction: 10
	recovery: 0.1
	available: => true
	create: =>
		with @model
			.speed = @attackSpeed
			.loop = false
			.look = "fight"
			\play "attack"
			\slot "AnimationEnd",villyAttackEnd
		once =>
			bulletDef = Store[@unitDef.bulletType]
			onAttack = ->
				Audio\play "Audio/v_att.wav"
				with Bullet bulletDef,@
					.targetAllow = @targetAllow
					\slot "HitTarget",(bullet,target,pos)->
						entity = target.entity
						entity.hitPoint = pos
						entity.hitPower = @attackPower
						entity.hitFromRight = bullet.velocityX < 0
						factor = Data\getDamageFactor @damageType, target.defenceType
						damage = (@attackBase + @attackBonus) * (@attackFactor + factor)
						entity.hp -= damage
						bullet.hitStop = true
					\addTo @world,@order
			attackSpeed = @attackSpeed
			sleep 0.17/attackSpeed
			onAttack!
			sleep 0.63/attackSpeed
			onAttack!
			sleep 1.0
			true,
	stop: =>
		@model\slot("AnimationEnd")\remove villyAttackEnd
		@model\stop!

UnitAction\add "wait",
	priority: 1
	reaction: 0.1
	recovery: 0
	available: => @onSurface
	create: =>
		with @model
			.speed = 1
			.look = Store.winner == @group and "happy" or "sad"
			.loop = true
			\play "idle"
		=>
			if not @onSurface
				return true
			false,
	stop: =>
		@model\stop!