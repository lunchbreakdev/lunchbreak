export default function classNames(
  ...classes: (string | false | 0 | undefined | null)[]
) {
  return classes
    .filter(Boolean)
    .map((c) => c && c.trim())
    .join(' ')
}
