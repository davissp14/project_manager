
var BoardTitle = React.createClass({

  propTypes: {
    name: React.PropTypes.string.isRequired
  },

  getInitialState: function(){
    return { editForm: false, name: this.props.name };
  },

  handleChange: function(){
    this.setState({name: event.target.value })
  },

  setBoardState: function(){
    this.setState({editForm: !this.state.editForm, name: this.state.name })
  },

  saveChanges: function(){  
    $.ajax({
      url: this.props.kanban_id + '/boards/' + this.props.id,
      dataType: 'json',
      type: "PATCH",
      cache: false,
      data: {name: this.state.name},
      success: function(data){
        this.setState({editForm: false, value: this.state.name});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(xhr, status, err.toString());
      }
    });

  },

  archiveBoard: function(){
    var self = this.props.kanban
    $.ajax({
      url: this.props.kanban_id + '/boards/' + this.props.id,
      dataType: 'json',
      type: "DELETE",
      cache: false,
      success: function(data){
        this.props.kanban.setState({data: data});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(xhr, status, err.toString());
      }
    });
  },

  editBoardHTML: function(){
    return (
      <form className='form-inline edit-title'>
        <div className='form-group'>
          <input type='text' className='form-control' value={this.state.name} onChange={this.handleChange} />
        </div>
        <span className='edit-board-options'>
          <i className='glyphicon glyphicon-ok' onClick={this.saveChanges}></i>
          <i className='glyphicon glyphicon-remove' onClick={this.setBoardState}></i>
        </span>
      </form>
    );
  },

  boardHTML: function(){
    return (
      <div className='board-title'>
        <strong>{this.state.name}</strong>
        <span className='pull-right edit-board'>
          <a href="#" className="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
            <i className='glyphicon glyphicon-pencil'></i>
          </a>
          <ul className='dropdown-menu' role='menu'>
            <li className='board-settings-title'>Board Settings</li>
            <li className="divider"></li>
            <li><a href="#" onClick={this.setBoardState}>Edit</a></li>
            <li><a href="#" onClick={this.archiveBoard}>Archive</a></li>
          </ul>
        </span>
      </div>
    );

  },

  render: function(){
    var html = this.state.editForm ? this.editBoardHTML() : this.boardHTML();

    return (
      <div className='form-box-title'>
        {html}
      </div>  
    );
  }
});