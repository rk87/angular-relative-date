'use strict'

describe 'Filter: relativeDate', ->
  relativeDate = null

  NOW = new Date '2013-09-07T12:00:00Z'

  beforeEach module 'relativeDate', ($provide) ->
    $provide.value 'now', NOW

    # Hack to get around CoffeeScript's implicit return
    undefined

  beforeEach inject (_$filter_) ->
    relativeDate = _$filter_ 'relativeDate'

  it 'Allows the `now` value to be set', ->
    inject (now) ->
      expect(now).toEqual NOW

  it 'Has the correct response for each interval', ->
    expect(relativeDate '2013-09-07T12:00:00Z').toEqual '剛剛'
    expect(relativeDate '2013-09-07T11:59:31Z').toEqual '剛剛'
    expect(relativeDate '2013-09-07T11:59:29Z').toEqual '31 秒前'
    expect(relativeDate '2013-09-07T11:59:01Z').toEqual '59 秒前'
    expect(relativeDate '2013-09-07T11:59:00Z').toEqual '1 分鐘前'
    expect(relativeDate '2013-09-07T11:58:01Z').toEqual '1 分鐘前'
    expect(relativeDate '2013-09-07T11:58:00Z').toEqual '2 分鐘前'
    expect(relativeDate '2013-09-07T11:00:01Z').toEqual '59 分鐘前'
    expect(relativeDate '2013-09-07T11:00:00Z').toEqual '1 小時前'
    expect(relativeDate '2013-09-07T10:00:01Z').toEqual '1 小時前'
    expect(relativeDate '2013-09-07T10:00:00Z').toEqual '2 小時前'
    expect(relativeDate '2013-09-06T12:00:01Z').toEqual '23 小時前'
    expect(relativeDate '2013-09-06T12:00:00Z').toEqual '昨天'
    expect(relativeDate '2013-09-06T00:00:00Z').toEqual '昨天'
    expect(relativeDate '2013-09-05T22:59:59Z').toEqual '昨天'
    expect(relativeDate '2013-09-01').toEqual '6 天前'
    expect(relativeDate '2013-08-31').toEqual '1 週前'
    expect(relativeDate '2013-08-09').toEqual '4 週前'
    expect(relativeDate '2013-08-08').toEqual '上個月'
    expect(relativeDate '2013-03-01').toEqual '6 個月前'
    expect(relativeDate '2012-09-07').toEqual '1 年前'
    expect(relativeDate '2012-04-07').toEqual '1 年前'
    expect(relativeDate '2011-04-07').toEqual '很久以前'
