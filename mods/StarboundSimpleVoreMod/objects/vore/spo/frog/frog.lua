croakLock		= 0
spitLock		= 0

timer			= 0
timerChew		= 0
timerDigest		= 0
timerEat		= 0
timerSwallow	= 0

function init()

end

function update(dt)
	if world.loungeableOccupied(entity.id()) then

		if timerSwallow > 50 then
			if timerDigest % 13 == 0 then
				animator.playSound("digest")
			end
			
			animator.setAnimationState("main", "digest")
			timerDigest = timerDigest + 1

		elseif timerChew > 300 then
			if timerSwallow == 0 then
				animator.playSound("swallow")
			end
			
			animator.setAnimationState("main", "swallow")
			timerSwallow = timerSwallow + 1

		elseif timerEat > 28 then
			if timerChew % 13 == 0 and timerChew > 10 then
				animator.playSound("chew")
			end
			
			animator.setAnimationState("main", "chew")
			timerChew = timerChew + 1

		else
			if timerEat == 0 then
				animator.playSound("eat")
			end
			
			animator.setAnimationState("main", "eat")
			timerEat = timerEat + 1
		end

	else

		if timerSwallow > 50 then			
			animator.setAnimationState("main", "spit")
			spitLock = 1
		end

		timerChew = 0
		timerDigest	= 0
		timerEat = 0
		timerSwallow = 0

		if croakLock == 0 and spitLock == 0 and math.random(200) == 1 then
			croakLock = 1
			animator.setAnimationState("main", "croak")
			animator.playSound("croak")

		elseif croakLock == 0 and spitLock == 0 then
			animator.setAnimationState("main", "idle")
		end

		if croakLock == 1 or spitLock == 1 then
			timer = timer + 1
		end

		if timer > 15 and croakLock == 1 then
			croakLock = 0
			timer = 0
		elseif spitLock == 1 then		
			if timer == 1 then
				animator.playSound("swallow")
			elseif timer == 25 then
				animator.playSound("eat")
			elseif timer > 46 then
				spitLock = 0
				timer = 0
			end
		end
	end
end