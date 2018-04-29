const Reactor = (() => {
  class Element {
    constructor(props) {
      this.props = props
    }
  }

  class Component extends Element {
    constructor(props) {
      super(props);
      this.state = {}
    }

    // componentWillMount() {}
    // componentDidMount() {}
    //
    // shouldComponentUpdate() {
    // 	return true;
    // }
    //
    // componentWillUnmount() {}
    // componentDidUnmount() {}

    setState(stateUpdate) {
      this.state = Object.assign({}, this.state, stateUpdate);
      ReactorDOM.render(this, this.container)
    }
  }

  class div extends Element {
    render() {
      return 'div'
    }
  }

  class string extends Element {
    render() {
      return this.props.value
    }
  }

  function createElement(type, props = {}, ...children) {
    let klass = typeof type == 'string' ? eval(type) : type;

    let childElements = children.map((el) => {
      return typeof el == 'string' ? new string({value: el}) : el
    });

    return new klass(Object.assign({children: childElements}, props))
  }

  return {Component, createElement}
})();

const ReactorDOM = (() => {
  function render(element, container) {
    container.innerHTML = '';
    _render(element, container)
  }

  function _render(element, container) {
    let isString = element.constructor.name == 'string';

    let node = element.node || (isString ? element.render() : document.createElement('div'));

    !element.node && (element.node = isString ? container : node);
    !element.container && (element.container = container);
    container.childElementCount == 0 ? container.append(node) : container.replaceChild(node, container.children[0]);

    let children;

    if (element.constructor.name === 'div') {
      children = element.props.children
    } else if (!isString) {
      children = [element.render()]
    }

    children && children.forEach((child) => _render(child, node))
  }

  return {render, _render}
})();

class MyComponent extends Reactor.Component {
  constructor(props) {
    super(props);
    window.myComponent = this;
    this.state = {text: ''}
  }

  render() {
    return (
      Reactor.createElement('div', {className: 'hello-world'},
        'Hello ',
        'World!',
        Reactor.createElement('div', null, this.state.text)
      )
    )
  }
}

document.addEventListener('DOMContentLoaded', () => {
  ReactorDOM.render(
    Reactor.createElement(MyComponent),
    document.querySelector('#app')
  );
});


