class Element {
  constructor(props = {}) {
    this.props = props
  }

  renderChildren() {
    if (this.props.children) {
      return this.props.children.reduce((string, child) => string + child.render(), '')
    } else {
      return 'no children'
    }
  }

  renderOpeningTag() {
    return this.props.className ? `<${this.props.tagName} class="${this.props.className}">` : `<${this.props.tagName}>`
  }

  renderClosingTag() {
    return `</${this.props.tagName}>`
  }

  render() {
    if (this.props.tagName) {
      return (
        `${this.renderOpeningTag()}${this.renderChildren()}${this.renderClosingTag()}`
      )
    } else {
      return this.props.value
    }
  }
}

document.addEventListener('DOMContentLoaded', () => {
  let app = document.querySelector('#app');

  let root = new Element({
    tagName: 'div',
    className: 'center',
    children: [
      new Element({
        tagName: 'span',
        children: [
          new Element({
            value: 'left'
          })
        ]
      }),
      new Element({
        tagName: 'span',
        children: [
          new Element({
            value: 'right'
          })
        ]
      }),
      new Element({
        value: 'hello world'
      })
    ]
  });

  window.root = root;

  app.innerHTML = root.render()
});