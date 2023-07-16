import { forwardRef, useEffect, useRef, useState } from 'react'
import './App.css'

import { classNames } from '@lunchbreak/functions'
import { useCombinedRef } from '@lunchbreak/hooks'
import { Wrap } from '@lunchbreak/react'

const TestComponent = forwardRef<HTMLDivElement>((_props, ref) => {
  const internalRef = useRef(null)
  const combinedRef = useCombinedRef(ref, internalRef)

  return <div ref={combinedRef} id="test-component"></div>
})

function App() {
  const [isWrapped, setIsWrapped] = useState(false)

  const testRef = useRef<HTMLDivElement>(null)

  useEffect(() => {
    const el = testRef.current

    if (!el) {
      console.log('No element found')
    } else {
      console.log('Element found!')
    }
  }, [testRef])

  return (
    <div className={classNames('foo', 'bar', isWrapped && 'baz')}>
      <h1>Lunch Break Tools</h1>
      <div className="card">
        <button onClick={() => setIsWrapped(!isWrapped)}>Toggle wrapper</button>
        <div>
          <Wrap if={isWrapped} with="a" wrapProps={{ href: '#' }}>
            <span>I am {!isWrapped && 'not '}a link</span>
          </Wrap>
        </div>
      </div>
      <TestComponent ref={testRef} />
    </div>
  )
}

export default App
