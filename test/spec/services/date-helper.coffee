describe 'Service: DateHelper', ->
  beforeEach module 'meetupServices'
  beforeEach module 'meetupConfig'

  dateHelper = {}
  cellsPerDay = 0

  beforeEach inject (DateHelper, CELLS_PER_DAY) ->
    dateHelper = DateHelper
    cellsPerDay = CELLS_PER_DAY

  describe 'functions to get days in month', () ->

    cases = [
      # random case
      date: new Date(2013, 8, 21)
      totalDays: 42
    ,
      # starts monday, ends randomly
      date: new Date(2013, 6, 10)
      totalDays: 35
    ,
      # ends sunday, starts randomly
      date: new Date(2014, 7, 1)
      totalDays: 35
    ,
      # starts monday, ends sunday
      date: new Date(2010, 1, 10)
      totalDays: 28
    ]


    it 'should count the right number of days in month', ->
      for c in cases
        days = dateHelper.getDaysForMonth c.date
        expect(days.length).toBe c.totalDays

    it 'should start on monday', ->
      for c in cases
        days = dateHelper.getDaysForMonth c.date
        expect(days[0].is().monday()).toBe true

    it 'should end on sunday', ->
      for c in cases
        days = dateHelper.getDaysForMonth c.date
        expect(days[days.length - 1].is().sunday()).toBe true

    it 'should return weeks of 7 days', ->
      for c in cases
        weeks = dateHelper.getWeeksInMonth c.date
        for week in weeks
          expect(week.length).toBe 7

    it 'should return the right number of weeks', ->
      for c in cases
        weeks = dateHelper.getWeeksInMonth c.date
        expect(weeks.length).toBe(c.totalDays / 7)


  describe 'function to get cells per day', ->
    it 'should count cells correctly with when minutes is not set', ->
      start = Date.today().set { hour: 14, minute: 0 }
      end = Date.today().set { hour: 18, minute: 0 }
      expectedCellsNumber = 4 * cellsPerDay / 24
      computedCellsNumber = dateHelper.getCellsNumberInDay start, end
      expect(computedCellsNumber).toBe expectedCellsNumber

    it 'should count cells correctly when minutes are 0 or 30', ->
      start = Date.today().set { hour: 14, minute: 30 }
      end = Date.today().set { hour: 18, minute: 0 }
      expectedCellsNumber = 3.5 * cellsPerDay / 24
      computedCellsNumber = dateHelper.getCellsNumberInDay start, end
      expect(computedCellsNumber).toBe expectedCellsNumber

      start.set { hour: 14, minute: 0 }
      end.set { hour: 18, minute: 30 }
      expectedCellsNumber = 4.5 * cellsPerDay / 24
      computedCellsNumber = dateHelper.getCellsNumberInDay start, end
      expect(computedCellsNumber).toBe expectedCellsNumber

    it 'should throw ignore last cell for non integer cells number', ->
      start = Date.today().set { hour: 14, minute: 30 }
      end = Date.today().set { hour: 18, minute: 35 }
      expectedCellsNumber = 4 * cellsPerDay / 24
      computedCellsNumber = dateHelper.getCellsNumberInDay start, end
      expect(computedCellsNumber).toBe expectedCellsNumber
