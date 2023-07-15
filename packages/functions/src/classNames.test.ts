import classNames from './classNames'

describe('functions/classNames', () => {
  const expectedValue = 'foo bar'

  it('should combine strings', () => {
    expect(classNames('foo', 'bar')).toEqual(expectedValue)
  })

  it('should trim whitespace', () => {
    expect(classNames(' foo ', 'bar ')).toEqual(expectedValue)
  })

  it('should ignore falsey values', () => {
    expect(classNames('foo', false, undefined, 'bar', 0)).toEqual(expectedValue)
  })
})
