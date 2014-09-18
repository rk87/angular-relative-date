'use strict'

angular.module('relativeDate', [])
  .value('now', new Date())
  .filter 'relativeDate', ['now', (now) ->
    (date) ->
      date = new Date(date) unless date instanceof Date
      delta = null

      minute = 60
      hour = minute * 60
      day = hour * 24
      week = day * 7
      month = day * 30
      year = day * 365

      calculateDelta = ->
        delta = Math.round((now - date) / 1000)

      calculateDelta()

      if delta > day && delta < week
        # We're dealing with days now, so time becomes irrelevant
        date = new Date(date.getFullYear(), date.getMonth(), date.getDate(), 0, 0, 0)
        calculateDelta()

      switch
        when delta < 30 then '剛剛'
        when delta < minute then "#{delta} 秒前"
        when delta < 2 * minute then '1 分鐘前'
        when delta < hour then "#{Math.floor(delta / minute)} 分鐘前"
        when Math.floor(delta / hour) == 1 then '1 小時前'
        when delta < day then "#{Math.floor(delta / hour)} 小時前"
        when delta < day * 2 then '昨天'
        when delta < week then "#{Math.floor(delta / day)} 天前"
        when Math.floor(delta / week) == 1 then '1 週前'
        when delta < month then "#{Math.floor(delta / week)} 週前"
        when Math.floor(delta / month) == 1 then '上個月'
        when delta < year then "#{Math.floor(delta / month)} 個月前"
        when Math.floor(delta / year) == 1 then '1 年前'
        else '很久以前'
  ]
