import axios from 'axios';

const client = axios.create({
  headers: {
    'X-CSRF-TOKEN': window.csrfTokenValue
  }
});

export const search = (params) => {
  return client.post(
    '/actions/sys/wayfinding/search',
    params
  )
}

export const place = (params) => {
  return client.post(
    '/actions/sys/wayfinding/place',
    params
  )
}

export const person = (params) => {
  return client.post(
    '/actions/sys/wayfinding/person',
    params
  )
}

export default client;
