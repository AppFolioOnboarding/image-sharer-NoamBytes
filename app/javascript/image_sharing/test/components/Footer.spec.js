/* eslint-env mocha */

import assert from 'assert';
import { shallow } from 'enzyme';
import React from 'react';
import Footer from '../../components/Footer';

describe('<Footer />', () => {
  it('should render correctly', () => {
    const wrapper = shallow(<Footer text='Text' />);
    const text = wrapper.find('footer');

    assert.strictEqual(text.length, 1);
    assert.strictEqual(text.text(), 'Text');
  });
});
