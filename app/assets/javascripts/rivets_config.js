//============Adapters==================//
rivets.adapters[':'] = {
  subscribe: function(obj, keypath, callback) {
    obj.on('change:' + keypath, callback)
    if (obj instanceof Backbone.Collection){
      obj.on('reset sync add', callback)
    }
  },
  unsubscribe: function(obj, keypath, callback) {
    obj.off('change:' + keypath, callback)
    if (obj instanceof Backbone.Collection){
      obj.off('reset sync add', callback)
    }
  },
  read: function(obj, keypath) {
    return obj instanceof Backbone.Collection ? obj.models : obj.get(keypath);
  },
  publish: function(obj, keypath, value) {
    obj.set(keypath, value)
  }
}

//=============Config (I don't know that this does===========//
////TODO Figure this out
rivets.configure({
  handler: function(target, event, binding) {
    this.call(binding.model, event, binding.view.models)
  }
})


//======================Formaters====================//
rivets.formatters.asDateTime = function(val) {
  if (val == undefined) {
    return null
  } else {
    return new Date(val * 1000);
  }
}

//Take a string and number and tracates the string to the number and add ... to the end
rivets.formatters.truncate = function(val, num) {
  if (val == undefined) {
    return null
  } else {
    return val.substring(0,num) + "..."
  }
}

//Check if a value is empty. This will work on anything that has the attriubute of length
rivets.formatters.isEmpty = function(val) {
  if (val == undefined) {
    return true
  } else {
    return val.length == 0 ? true : false
  }
}

//Joins togather a list into a string based list
rivets.formatters.stringify = function(val) {
  return val.join(', ')
}

//This is fancy stuff and I forget it purpose. Somethign to do with adjusting the scope of this...
//TODO Figure this out
rivets.formatters.bind = function(fn) {
  var args = [].slice.call(arguments, 1)
  return function() {
    fn.apply(null, _.flatten(args.concat(arguments)))
  }
}

//Pipe this into any binding on elements that have default action like links.
rivets.formatters.preventDefault = function(fn) {
  return function(e) {
    e.preventDefault()
    fn.apply(this, arguments)
  }
}


Backbone.history.start({ pushState: true })
