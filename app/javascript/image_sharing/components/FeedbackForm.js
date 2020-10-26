import React from 'react';
import { Button, Form, FormGroup, Label, Input } from 'reactstrap';
import post from '../utils/helper.js';

class FeedbackForm extends React.Component {
  constructor() {
    super();
    this.state = {
      name: '',
      comments: ''
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
    post(path, this.state);
  }

  render() {
    return (
      <Form style={{ width: '70%' }}>
        <FormGroup>
          <Label>Your Name:</Label>
          <Input onChange={event => this.onNameChange(`${event.target.value}`)} type='text' />
        </FormGroup>
        <FormGroup>
          <Label>Comments:</Label>
          <Input onChange={event => this.onCommentChange(`${event.target.value}`)} type='textarea' />
        </FormGroup>
        <Button color='primary' onClick={this.submitFeedbackToBackend()}>Submit</Button>
      </Form>
    );
  }
}

export default FeedbackForm;
