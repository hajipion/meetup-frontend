angular.module('meetupServices')
  .factory 'DateHelper', (CELLS_PER_DAY)->

    getDaysForMonth: (date) ->
      start = date.clone().moveToFirstDayOfMonth()
      start = start.last().monday() unless start.is().monday()
      end = date.clone().moveToLastDayOfMonth()
      end = end.next().sunday() unless end.is().sunday()
      days = []
      while start <= end
        days.push start
        start = start.clone().next().day()
      days

    getWeeksInMonth: (date) ->
      days = @getDaysForMonth(date)
      (days[n..n+6] for n in [0..days.length-1] by 7)

    getTimeOnly: (date) -> date.clone().set({ year: 1970, month: 1, day: 1 })

    getCellsNumberInInterval: (start, end) ->
      minutesDiff = (@getTimeOnly(end) - @getTimeOnly(start)) / 60000
      minutesPerCell = 24 * 60 / CELLS_PER_DAY
      Math.ceil(minutesDiff / minutesPerCell)
