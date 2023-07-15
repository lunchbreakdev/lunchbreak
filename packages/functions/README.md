# @lunchbreak/functions

Handy JavaScript functions for your next project!

## `classNames`

An easier way to create an HTML `class` string.
Accepts any number of strings and allows for conditional values.

```tsx
import { classNames } from '@lunchbreak/functions'
// or
import classNames from '@lunchbreak/functions/classNames'

const Component = (large: boolean) => {
  return (
    <button
      className={classNames('btn', large && 'btn-lg')}
    >
      Click me!
    </button>
  )
}
```