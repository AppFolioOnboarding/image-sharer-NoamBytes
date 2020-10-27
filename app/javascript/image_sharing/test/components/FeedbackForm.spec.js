/* eslint-env mocha */

import assert from 'assert';
import { mount, shallow } from 'enzyme';
import React from 'react';
import sinon from 'sinon';
import FeedbackForm from '../../components/FeedbackForm';
import * as postHelper from '../../utils/helper.js';

describe('<FeedbackForm />', () => {
  let wrapper;
  beforeEach(() => {
    wrapper = shallow(<FeedbackForm />);
  });

  afterEach(() => {
    sinon.restore();
  });

  it('should render correctly', () => {
    const inputs = wrapper.find('Input');
    const labels = wrapper.find('Label');
    const button = wrapper.find('Button');

    assert.strictEqual(inputs.length, 2);
    assert.strictEqual(labels.length, 2);
    assert.strictEqual(labels.at(0).children().at(0).text(), 'Your Name:');
    assert.strictEqual(labels.at(1).children().at(0).text(), 'Comments:');
    assert.strictEqual(button.length, 1);
    assert.strictEqual(button.children().at(0).text(), 'Submit');
  });

  it('should call the onSubmit function when submit button is clicked', () => {
    const submitStub = sinon.stub(wrapper.instance(), 'submitFeedbackToBackend');

    wrapper.find('Button').simulate('click');

    assert(submitStub.calledOnce);
  });

  it('should make a post request and set success state', () => {
    const submitStub = sinon.stub(postHelper, 'post').resolves({ status: 200, message: 'success!' });

    wrapper.setState({ name: 'someName', comments: 'someComment' });

    wrapper.instance().submitFeedbackToBackend().then(() => {
      assert(submitStub.calledOnceWith('/api/feedbacks', { name: 'someName', comments: 'someComment' }));
      assert.deepStrictEqual(wrapper.state(), {
        name: '',
        comments: '',
        alertStatus: 'success',
        alertMessage: 'success!'
      });
    });
  });

  it('should make a post request and set error state', () => {
    const submitStub = sinon.stub(postHelper, 'post').rejects({ data: { status: 422, message: 'bad' } });

    wrapper.instance().submitFeedbackToBackend().then(() => {
      assert(submitStub.calledOnceWith('/api/feedbacks', { name: '', comments: '' }));
      assert.deepStrictEqual(wrapper.state(), {
        name: '',
        comments: '',
        alertStatus: 'danger',
        alertMessage: 'bad'
      });
    });
  });

  it('shows a success alert when the state is successful', () => {
    wrapper.setState({
      name: '',
      comments: '',
      alertStatus: 'success',
      alertMessage: 'Success!'
    });

    assert.strictEqual(wrapper.find('Alert').length, 1);
    assert.strictEqual(wrapper.find('Alert').prop('color'), 'success');
    assert.strictEqual(wrapper.find('Alert').children().at(0).text(), 'Success!');
  });

  it('sets the name state when name is inputted', () => {
    const nameInput = wrapper.find('Input').at(0);

    nameInput.simulate('change', { target: { value: 'SomeName' } });

    assert.strictEqual(wrapper.state().name, 'SomeName');
  });

  it('sets the comments state when comment is inputted', () => {
    const nameInput = wrapper.find('Input').at(1);

    nameInput.simulate('change', { target: { value: 'blah' } });

    assert.strictEqual(wrapper.state().comments, 'blah');
  });
});

