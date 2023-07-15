import { render } from '@testing-library/react'

import Wrap from './Wrap'

const TestContainer = ({ children }: { children: React.ReactNode }) => {
  return <div id="container">{children}</div>
}

describe('react/Wrap', () => {
  it('should render the wrapper if true', () => {
    const { container } = render(
      <Wrap if={true} with="div" wrapProps={{ id: 'container' }}>
        <p>Content</p>
      </Wrap>,
    )

    expect(container.querySelector('#container')).toBeTruthy()
  })

  it('should not render the wrapper if false', () => {
    const { container } = render(
      <Wrap if={false} with="div" wrapProps={{ id: 'container' }}>
        <p>Content</p>
      </Wrap>,
    )

    expect(container.querySelector('#container')).toBeFalsy()
  })

  it('should not render the wrapper if no `if` prop is provided', () => {
    const { container } = render(
      <Wrap with="div" wrapProps={{ id: 'container' }}>
        <p>Content</p>
      </Wrap>,
    )

    expect(container.querySelector('#container')).toBeFalsy()
  })

  it('should render the wrapper with attributes', () => {
    const { container } = render(
      <Wrap
        if={true}
        with="div"
        wrapProps={{ id: 'container', 'aria-hidden': true }}
      >
        <p>Content</p>
      </Wrap>,
    )

    expect(
      container.querySelector('#container')!.hasAttribute('aria-hidden'),
    ).toBeTruthy()
  })

  it('should render a custom component as the wrapper', () => {
    const { container } = render(
      <Wrap if={true} with={TestContainer}>
        <p>Content</p>
      </Wrap>,
    )

    expect(container.querySelector('#container')).toBeTruthy()
  })
})
