animState = "blank"

victim = nil
health = nil

lock = true
--entity.setAnimationState("bodyState", "fed4")
--entity.playSound("digest")

bellySounds = {	"belly1",
				"belly2",
				"belly3"
}

eatenLines = {	"A moment on my lips, a lifetime on my hips~",
				"Too late now~",
				"Thanks for the meal~",
				"Not much of a meal, but it'll do~"
}

bellyLines = {	"So, uh, any hard feelings if I sell the runes I cough up later?",
				"Sorry, not feeling up to that whole healing schtick today. Hope you don't mind.~",
				"I love it when people just surrender themselves to me...",
				"If you see any fishbones in there, don't think too hard about the fact your bones will be joining them, ok?"
}

rubLines = {	"Not often i get a rub fron the outside.",
				"Nothing like a post-meal belly-rub.",
				"Keep it up, it's good for digestion...",
				"Better be good at this, or i'll have seconds.",
				"Maybe later you can give me a rub from the inside instead.",
				"Well aren't you nice, helping me digest your friend.",
				"Can you feel your friend slowly digesting inside of me?",
				"Not sure if you want to be next, or pleading for your life."
}

chatEmpty = {	"Hey, I can turn anything into magic runes...Want me to show you how?",
				"Hey, mind if I get a quick taste of you? Fish is getting booooring."
}

chatFull = {	"Mmm, come back in a bit, sugar~",
				"What's that you say? I don't hear anybody.",
				"Say, are you open later? I might have some... room in my schedule~"
}
function init()

end

function update(dt)
		
	animState = entity.animationState("bodyState")
		
	if world.loungeableOccupied(entity.id()) then
	
		if victim ~= nil then
			health = world.entityHealth(victim)[1] / world.entityHealth(victim)[2]
		end
		
		if animState == "idle" and lock then
			entity.setAnimationState("bodyState", "swallow")
			entity.say( eatenLines[ math.random( #eatenLines ) ] )
			entity.playSound("swallow")
		end
		
		if health == nil then
			health = 1
		end
		
		if math.random(700) == 1 then
			entity.say( bellyLines[ math.random( #bellyLines ) ] )
		end
		
		if math.random(700) == 1 then
			entity.playSound( bellySounds[ math.random( #bellySounds ) ] )
		end
		
		if health < 0.7 and animState == "full1" then
			entity.setAnimationState("bodyState", "digest1")
		elseif health < 0.4 and animState == "full2" then
			entity.setAnimationState("bodyState", "digest2")
		elseif health < 0.1 and animState == "full3" then
			entity.setAnimationState("bodyState", "digest3")
			lock = false
		end
		
		if math.random(700) == 1 then
			local people = world.entityQuery( entity.position(), 7, {
				withoutEntityId = entity.id(),
				includedTypes = {"player"},
				boundMode = "CollisionArea"
			})
			if #people > 1 then
				entity.say( chatFull[ math.random( #chatFull ) ] )
			end
		end
		
	else
		
		lock = true
		
		entity.setAnimationState("bodyState", "idle")
		
		if math.random(700) == 1 then
			local people = world.entityQuery( entity.position(), 7, {
				includedTypes = {"player"},
				boundMode = "CollisionArea"
			})
			if #people > 0 then
				entity.say( chatEmpty[ math.random( #chatEmpty ) ] )
			end
		end
	end
end

function onInteraction(args)

	victim = args.sourceId
	
	if world.loungeableOccupied(entity.id()) then
		entity.say( rubLines[ math.random( #rubLines ) ] )
	end
	
end