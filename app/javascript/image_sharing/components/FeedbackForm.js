import React from 'react';
import { Alert, Button, Form, FormGroup, Label, Input } from 'reactstrap';
import { post } from '../utils/helper.js';

class FeedbackForm extends React.Component {
  constructor() {
    super();
    this.state = {
      name: '',
      comments: '',
      alertStatus: undefined,
      alertMessage: ''
    };
  }

  onNameChange(name) {
    this.setState({ name });
  }

  onCommentChange(comment) {
    this.setState({ comments: comment });
  }

  submitFeedbackToBackend() {
    const path = '/api/feedbacks';
    return post(path, { name: this.state.name, comments: this.state.comments }).then((response) => {
      this.setState({ alertStatus: 'success', alertMessage: response.message });
    }).catch((response) => {
      this.setState({ alertStatus: 'danger', alertMessage: response.data.message });
    }).finally(() => {
      this.setState({
        name: '',
        comments: ''
      });
    });
  }

  render() {
    return (
      <React.Fragment>
        {this.state.alertStatus &&
          <Alert color={this.state.alertStatus}>{this.state.alertMessage}</Alert>
        }
        <Form style={{ width: '70%' }}>
          <FormGroup>
            <Label>Your Name:</Label>
            <Input
              value={this.state.name}
              onChange={event => this.onNameChange(event.target.value)}
              type='text'
            />
          </FormGroup>
          <FormGroup>
            <Label>Comments:</Label>
            <Input
              value={this.state.comments}
              onChange={event => this.onCommentChange(event.target.value)}
              type='textarea'
            />
          </FormGroup>
          <Button color='primary' onClick={() => this.submitFeedbackToBackend()}>Submit</Button>
        </Form>
      </React.Fragment>
    );
  }
}

export default FeedbackForm;
