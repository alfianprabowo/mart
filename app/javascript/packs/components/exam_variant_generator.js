export default class ExamVariantGenerator {
  constructor(element){
    this.element = element;
    this.addButton = this.element.querySelector('.js-button__add-more-topic');
    this.listTopicVariant = this.element.querySelector('.js-list__topic-variant');
    this.sublistTopicVariant = this.listTopicVariant.firstChild;
    this.newIndex = 0;
  }

  init(){
    this.bindAddButtonClick();
  }

  bindAddButtonClick(){
    this.addButton.addEventListener('click', this.handleAddButtonClick.bind(this));
  }

  handleAddButtonClick(){
    this.preprocessUpdateProperties();
    let newHTML = this.sublistTopicVariant.outerHTML.replace(/[0]/g, this.newIndex);

    this.listTopicVariant.appendChild(this.createNewNode(newHTML));
  }

  preprocessUpdateProperties(){
    this.newIndex++;
  }

  createNewNode(htmlString) {
    var div = document.createElement('div');
    div.innerHTML = htmlString.trim();

    return div.firstChild;
  }

}
