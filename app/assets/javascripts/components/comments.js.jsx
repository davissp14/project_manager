
var CommentBox = React.createClass({
  loadCommentsFromServer: function() {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      cache: false,
      success: function(data){
        this.setState({data: data});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },
  handleCommitSubmit: function(comment) {
    // Optimistically appending comment.
    var comments = this.state.data;
    var newComments = comments.concat([comment]);
    this.setState({data: comments});

    $.ajax({
      url: this.props.url,
      dataType: 'json',
      type: 'POST',
      data: {comment: comment}, 
      success: function(data){
        this.setState({data: data});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },
  getInitialState: function() {
    return { data: [] };
  },

  componentDidMount: function(){
    this.loadCommentsFromServer();
    if (this.props.pollInterval != null) { 
      setInterval(this.loadCommentsFromServer, this.props.pollInterval);
    }
  },

  render: function() {
    return (
      <div className='comments-feature'>
        <div className='form-box'>
          <div className='form-box-content'>
            <div className='comment-box'>
              <CommentList data={this.state.data} />
            </div>
          </div>
        </div>

        <CommentForm onCommentSubmit={this.handleCommitSubmit} />
      </div>
    );
  }
});

var CommentList = React.createClass({
  render: function() {
    var commentNodes = this.props.data.map(function(comment){
      return (
        <div className='comment-item'>
          <span className='comment-icon'>
            <img src={comment.user.profile_icon} /> 
          </span>

          <span className='comment-poster'>
            <strong>{comment.user.slug}</strong> 
            <br />
            <small>
              commented on {comment.created_at }
            </small>
          </span>

          <div className='comment-text'>
            {comment.text}
          </div>
        </div>
      );
    });

    return (
      <div className='comment-list'>
        {commentNodes}
      </div>
    )
  }
});

var CommentForm = React.createClass({
  handleSubmit: function(e){
    e.preventDefault();

    var comment = React.findDOMNode(this.refs.myText).value.trim();
    if (!comment) {
      return; 
    }

    this.props.onCommentSubmit({text: comment});
    React.findDOMNode(this.refs.myText).value = '';
    return; 

  },
  render: function(){
    return (
      <form className='commentForm simple_form' onSubmit={this.handleSubmit}>
        <div className='form-group text'>
          <textarea className='form-control text' placeholder='Leave a comment' ref='myText'></textarea>
        </div>
        <input type='submit' value='Comment' className='btn btn-active btn-md' />
      </form>
    );
  }
});