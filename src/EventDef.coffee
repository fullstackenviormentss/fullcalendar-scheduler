
origApplyRawProps = EventDef::applyRawProps
origEventDefClone = EventDef::clone

###
NOTE: will always be populated by applyRawProps
###
EventDef::resourceIds = null

###
resourceId should already be normalized
###
EventDef::hasResourceId = (resourceId) ->
	resourceId in this.resourceIds

###
resourceId should already be normalized
###
EventDef::removeResourceId = (resourceId) ->
	removeExact(this.resourceIds, resourceId)

###
resourceId should already be normalized
###
EventDef::addResourceId = (resourceId) ->
	this.resourceIds.push(resourceId)


EventDef::getResourceIds = ->
	this.resourceIds.slice() # clone


EventDef::applyRawProps = (rawProps) ->
	isSuccess = origApplyRawProps.apply(this, arguments)
	this.resourceIds = Resource.extractIds(rawProps, @source.calendar)
	isSuccess


EventDef::clone = ->
	def = origEventDefClone.apply(this, arguments)
	def.resourceIds = this.getResourceIds()
	def
