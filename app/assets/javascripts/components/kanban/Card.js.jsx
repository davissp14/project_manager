var DragDropMixin = ReactDND.DragDropMixin;

const ItemTypes = {
  CARD: 'card'
};

var Card = React.createClass({  

  propTypes: {
    kanban_id: React.PropTypes.number.isRequired,
    title: React.PropTypes.string.isRequired,
    deleteCard: React.PropTypes.func.isRequired 
  },

  mixins: [
    DragDropMixin
  ],

  statics: {
    configureDragDrop: function(register) {
      register(ItemTypes.CARD, {
        dragSource: {
          beginDrag: function(component) {
            return {
              item: {
                id: component.props.id,
                kanban_id: component.props.kanban_id,
                title: component.props.title,
                deleteCard: component.props.deleteCard
              }
            };
          }
        }
      });
    }
  },

  render: function() {
    return (
      <li className="task list-group-item"
          {...this.dragSourceFor(ItemTypes.CARD)}>
        {this.props.title}
        <span className="delete"
              onClick={this.props.deleteCard} />
      </li>
    );
  }
});
