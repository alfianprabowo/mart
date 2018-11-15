export default class PageManager {
  constructor(element){
    this.element = element;
  }

  init(){
    this.element.addEventListener('DOMContentLoaded', window.PageManager.initialize.bind(this));
  }

  static initialize(){
    let components = Array.prototype.slice.call(
      this.element.getElementsByClassName('js-component')
    );

    for(let i = 0; i < components.length; i++){
      let component = components[i];
      let componentClassName = component.dataset.component;

      let volatileComponent = new window[componentClassName](component);
      volatileComponent.init();
    }
  }
}
