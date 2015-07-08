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

  getInitialState: function(){
    return {
      editForm: false,
      title: this.props.title
    }
  },

  setCardState: function(){
    // /projects/:project_id/kanbans/:kanban_id/cards/:id
    this.setState({editForm: !this.state.editForm})
  },

  saveChanges: function(){
    var self = this
    $.ajax({
      url: this.props.kanban_id + '/cards/' + this.props.id,
      dataType: 'json',
      type: "PATCH",
      cache: false,
      data: {board_id: this.props.board_id, title: this.state.title},
      success: function(data){
        this.setState({editForm: false})
        self.props.board.setState({cards: data})
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(xhr, status, err.toString());
      }
    });
  },

  archiveCard: function(){
    $.ajax({
      url: this.props.kanban_id + '/cards/' + this.props.id,
      dataType: 'json',
      type: "DELETE",
      cache: false,
      data: {board_id: this.props.board_id},
      success: function(data){
        this.props.deleteCard()
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(xhr, status, err.toString());
      }
    });
  },

  cardHTML: function(){
    return (
      <li className="card list-group-item" {...this.dragSourceFor(ItemTypes.CARD)}>
      <div>
        <span className='card-title'>
          {this.props.title}
        </span>
  
        <span className="card-options dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
          <i className='glyphicon glyphicon-option-horizontal'></i>
        </span>
        <ul className='dropdown-menu' role='menu'>
          <li className='card-settings-title'>Card Settings</li>
          <li className="divider"></li>
          <li><a href="#" onClick={this.setCardState}>Edit</a></li>
          <li><a href="#" onClick={this.archiveCard}>Archive</a></li>
        </ul>
      </div>
      </li>
    )
  },

  handleChange: function(){
    this.setState({title: event.target.value })
  },

  cardEditForm: function(){
    return (
      <li className="card list-group-item">
      <form className='form-inline edit-card-title'>
        <div className='form-group'>
          <textarea className="kanban-text-area form-control" value={this.state.title} onChange={this.handleChange} ></textarea>
        </div>

        <div className='pull-right'>
          <button className='btn btn-default btn-xs' onClick={this.setCardState}>Cancel</button>
          <button className='btn btn-active btn-xs' onClick={this.saveChanges}>Update</button>
        </div>
        <div className='clearfix'></div>
      </form>
      </li>
    )
  },

  render: function() {

    var html = this.state.editForm ? this.cardEditForm() : this.cardHTML();

    return (
      <div>
        {html}
      </div>
    );
  }
});


    // <a href="#" className="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
    //         <i className='glyphicon glyphicon-pencil'></i>
    //       </a>
    //       <ul className='dropdown-menu' role='menu'>
    //         <li className='board-settings-title'>Board Settings</li>
    //         <li className="divider"></li>
    //         <li><a href="#" onClick={this.setBoardState}>Edit</a></li>
    //         <li><a href="#" onClick={this.archiveBoard}>Archive</a></li>
    //       </ul>
