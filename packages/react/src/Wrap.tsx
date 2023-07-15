import { createElement } from 'react'

interface IWrap {
  if?: boolean
  with: (typeof createElement.arguments)[0]
  wrapProps?: (typeof createElement.arguments)[1]
  children: NonNullable<React.ReactNode>
}

const Wrap = ({ if: condition, with: wrapper, wrapProps, children }: IWrap) =>
  condition ? createElement(wrapper, wrapProps, [children]) : <>{children}</>

export default Wrap
