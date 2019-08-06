import axios from 'axios';

export default axios.create({
  headers: {
    'X-CSRF-TOKEN': window.csrfTokenValue
  }
});
