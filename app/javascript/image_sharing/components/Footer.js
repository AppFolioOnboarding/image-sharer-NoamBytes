import React from 'react';
import PropTypes from 'prop-types';

export default function Footer(props) {
  return (
    <footer>
      <small>{props.text}</small>
    </footer>
  );
}

Footer.propTypes = {
  text: PropTypes.string.isRequired
};
