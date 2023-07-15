# @lunchbreak/react

Handy React components for your next project!

## `Wrap`

Component to conditionally wrap content.

```tsx
import { Wrap } from '@lunchbreak/react'
// or
import Wrap from '@lunchbreak/react/Wrap'

const Component = (condition: boolean) => {
  return (
    <Wrap if={condition} with="a" wrapperProps={{ href: './page' }}>
      <span>Item</span>
    </Wrap>
  )
}
```