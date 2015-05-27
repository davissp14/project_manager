
var NewBoardForm = React.createClass({

  propTypes: {
    kanban_id:  React.PropTypes.number.isRequired
  },

  getInitialState: function(){
    return { 
      collapseForm: false,
      hideForm: false 
    }
  },

  setFormState: function(){
    this.setState({collapseForm: !this.state.collapseForm })
  },

  addBoard: function(){
    var name = React.findDOMNode(this.refs.name).value.trim();
    $.ajax({
      url: this.props.kanban_id + '/boards',
      type: 'POST',
      dataType: 'json',
      data: {name: name},
      success: function(data){
        this.props.kanban.setState({data: data})
        if (this.isMounted()) {
          this.setState({collapseForm: false})
        }
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this, status, err.toString());
      }
    });
  },

  addBoardForm: function(){
    return (
      <div className='form-box'>
        <div className='form-box-title'>Add a board</div>
        <div className='form-box-content'>
          <input type='text' className='form-control' ref='name' />
          <button className='btn btn-default btn-xs' onClick={this.setFormState}>Cancel</button>
          <button className='btn btn-active btn-xs' onClick={this.addBoard}>Add</button>
        </div>
      </div>
    );
  },

  hiddenBoardForm: function(){
    return (
      <div>
      <a href='#' onClick={this.setFormState}> Add a board... </a>
      </div>
    );
  },

  render: function(){
    var html = this.state.collapseForm ? this.addBoardForm() : this.hiddenBoardForm();
    return (
      <div className="col-md-3">
        {html}
      </div>
    );
  }

});