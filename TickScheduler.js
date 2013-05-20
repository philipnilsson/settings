// Generated by CoffeeScript 1.6.2
(function() {
  var _;

  _ = Bacon._;

  window.TickScheduler = function() {
    var add, boot, counter, currentTick, nextId, run, running, schedule, toRemove;

    counter = 1;
    currentTick = 0;
    schedule = {};
    toRemove = [];
    nextId = function() {
      return counter++;
    };
    running = false;
    add = function(delay, entry) {
      var tick;

      tick = currentTick + delay;
      if (!entry.id) {
        entry.id = nextId();
      }
      if (!schedule[tick]) {
        schedule[tick] = [];
      }
      schedule[tick].push(entry);
      return entry.id;
    };
    boot = function(id) {
      if (!running) {
        running = true;
        setTimeout(run, 0);
      }
      return id;
    };
    run = function() {
      var entry, forNow, _i, _len, _ref;

      while (Object.keys(schedule).length) {
        while ((_ref = schedule[currentTick]) != null ? _ref.length : void 0) {
          forNow = schedule[currentTick].splice(0);
          for (_i = 0, _len = forNow.length; _i < _len; _i++) {
            entry = forNow[_i];
            if (_.contains(toRemove, entry.id)) {
              _.remove(entry.id, toRemove);
            } else {
              entry.fn();
              if (entry.recur) {
                add(entry.recur, entry);
              }
            }
          }
        }
        delete schedule[currentTick];
        currentTick++;
      }
      return running = false;
    };
    return {
      setTimeout: function(fn, delay) {
        return boot(add(delay, {
          fn: fn
        }));
      },
      setInterval: function(fn, recur) {
        return boot(add(recur, {
          fn: fn,
          recur: recur
        }));
      },
      clearTimeout: function(id) {
        return toRemove.push(id);
      },
      clearInterval: function(id) {
        return toRemove.push(id);
      },
      now: function() {
        return currentTick;
      }
    };
  };

}).call(this);
