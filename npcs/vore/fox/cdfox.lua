require "/scripts/vore/npcvore.lua"

isDigest = true

playerLines = {		"Surprise! Hope you enjoy learning about the reproductive system of foxes~<3",
					"Such a scrumptious thing you are~",
					"Ooooo~ Gonna love to make the most of you",
					"*purrs* Mmm hope I can find more like you, so good~",
					"Gonna be a shame to let ya out, just love a full sac~ *kneads you about*",
					"Gosh, I bet it's hot in there with all my fur and fat heating you up~",
					"You'll be making my furcoat even more gorgeous soon~",
					"Mnnng~ Keep squirming, you feel so good in there~"
}

function initHook()

	index = entity.getItemSlot("legs").parameters.colorIndex
	
	chest = {
		name = "foxchest",
		parameters = {
					colorIndex = index
	}}
	
	fullchest = {
		name = "foxchestballs",
		parameters = {
					colorIndex = index
	}}
	
	legs = {
		name = "foxlegs",
		parameters = {
					colorIndex = index
	}}
	
	fulllegs = {
		name = "foxlegsballs",
		parameters = {
					colorIndex = index
	}}

end

function feedHook()

end

function loseHook()

	if isPlayer then
		entity.say("Thank you so much for indulging me. You'll enjoy being fox seed~")
	end

	isPlayer = false

end

function updateHook()

	if isPlayer and math.random(700) == 1 then
		entity.say( playerLines[math.random(#playerLines)])
	end

end
