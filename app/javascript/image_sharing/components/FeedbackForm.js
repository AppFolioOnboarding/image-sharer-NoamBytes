import React from 'react';
import { Button, Form, FormGroup, Label, Input } from 'reactstrap';

const FeedbackForm = () => (
  <Form style={{ width: '70%' }}>
    <FormGroup>
      <Label>Your Name:</Label>
      <Input type='text' />
    </FormGroup>
    <FormGroup>
      <Label>Comments:</Label>
      <Input type='textarea' />
    </FormGroup>
    <Button color='primary'>Submit</Button>
  </Form>
);

export default FeedbackForm;
