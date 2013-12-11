Changes = require('../src/changes')

describe 'Changes prototype', ->
    stubs = {}
    mocks = {}
    beforeEach ->
        stubs =
            state  : 'empty'
        mocks =
            resultFn : -> stubs.state
            changeFn : -> 'test'


    describe 'new Changes()', ->
        changes = null
        beforeEach ->
            spyOn(Changes.prototype, 'initialize').andCallThrough()
            changes = new Changes(mocks.resultFn, mocks.changeFn)

        it 'should return a Changes object', ->
            expect(changes.constructor).toBe(Changes)

        it 'should initialize', ->
            expect(changes.initialize).toHaveBeenCalled()

        it 'should have default properties', ->
            expect(changes._frequency).toBe(200)
            expect(changes._lastResult).toBe('empty')
            expect(changes._resultFn).toBe(mocks.resultFn)
            expect(changes._changeFn).toBe(mocks.changeFn)


    describe '.isChanged()', ->
        changes = null
        beforeEach ->
            changes = new Changes(mocks.resultFn, mocks.changeFn)

        it 'should be false when unchanged', ->
            expect(changes.isChanged()).toBe(false)

        it 'should be true when changed', ->
            stubs.state = 'new state'
            expect(changes.isChanged()).toBe(true)


    describe '.start()', ->
        changes = null
        beforeEach ->
            changes = new Changes(mocks.resultFn, mocks.changeFn)
            spyOn(changes, '_resultFn').andCallThrough()
            spyOn(changes, '_changeFn').andCallThrough()
            jasmine.Clock.useMock()

        it 'should start polling resultFn', ->
            expect(changes._resultFn.calls.length).toBe(0)
            changes.start()
            jasmine.Clock.tick(changes._frequency+1);
            expect(changes._resultFn).toHaveBeenCalled()

        it 'should call changeFn when changed', ->
            changes.start()
            expect(changes._changeFn.calls.length).toBe(0)
            stubs.state = 'changed'
            jasmine.Clock.tick(changes._frequency+1);
            expect(changes._changeFn).toHaveBeenCalled()