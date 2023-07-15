# @lunchbreak/hooks

Handy React hooks for your next project!

## `useCombinedRef`

Combines two or more React refs into one.

```tsx
import { forwardRef, useRef } from 'react'

import { useCombinedRef } from '@lunchbreak/hooks'
// or
import useCombinedRef from '@lunchbreak/hooks/useCombinedRef'

const Component = forwardRef<HTMLDivElement>((props, ref) => {
  const internalRef = useRef<HTMLDivElement>(null)
  const combinedRef = useCombinedRef(internalRef, ref)

  return (
    <div ref={combinedRef}></div>
  )
})
```