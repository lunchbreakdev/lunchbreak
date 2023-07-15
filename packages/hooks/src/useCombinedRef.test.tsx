import { forwardRef, useRef } from 'react'

import { unmountComponentAtNode } from 'react-dom'

import useCombinedRef from './useCombinedRef'

const TestComponent = forwardRef<HTMLDivElement>((props, ref) => {
  const insideRef = useRef<HTMLDivElement>(null)
  const elRef = useCombinedRef(ref, insideRef)

  return <div ref={elRef} id="test-element"></div>
})

let container: HTMLDivElement

beforeEach(() => {
  container = document.createElement('div')
  document.body.appendChild(container)
})

describe('hooks/useCombinedRef', () => {})

afterEach(() => {
  unmountComponentAtNode(container)
  container.remove()
  container = null
})
