/* eslint-env mocha */

import assert from 'assert';
import { mount } from 'enzyme';
import React from 'react';
import FeedbackForm from '../../components/FeedbackForm';

describe('<FeedbackForm />', () => {
  it('should render correctly', () => {
    const wrapper = mount(<FeedbackForm />);
    const inputs = wrapper.find('Input');
    const labels = wrapper.find('Label');
    const button = wrapper.find('Button');

    assert.strictEqual(inputs.length, 2);
    assert.strictEqual(labels.length, 2);
    assert.strictEqual(labels.at(0).text(), 'Your Name:');
    assert.strictEqual(labels.at(1).text(), 'Comments:');
    assert.strictEqual(button.length, 1);
    assert.strictEqual(button.text(), 'Submit');
  });
});
