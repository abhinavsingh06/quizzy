import { isUnauthorized } from './helpers';
import {
  STATUS_UNPROCESSABLE_ENTITY,
  STATUS_OK,
  STATUS_NOT_FOUND,
  STATUS_BAD_REQUEST,
} from './constants';

export const fetchApi = ({
  url,
  method,
  body,
  onError,
  errorCallback,
  onSuccess,
  successCallBack,
}) => {
  method = method.toUpperCase();

  var options = {
    method: method,
    headers: {
      Accept: 'application/json',
      'Content-Type': 'application/json',
      'X-CSRF-TOKEN': document.querySelector('[name="csrf-token"]').content,
    },
  };

  const methods = ['POST', 'PUT', 'PATCH'];
  if (methods.includes(method)) {
    options['body'] = JSON.stringify(body);
  }

  fetch(url, options)
    .then(response =>
      response.json().then(data => {
        if (isUnauthorized(response)) {
          onError({ messages: [data.errors], type: 'danger' });
        } else if (response.status == STATUS_UNPROCESSABLE_ENTITY) {
          onError({ messages: data.errors, type: 'danger' });
        } else if (
          response.status >= STATUS_OK &&
          response.status < STATUS_BAD_REQUEST
        ) {
          onSuccess({ messages: [data.notice], type: 'success' });
          successCallBack(data);
        } else if (response.status == STATUS_NOT_FOUND) {
          onError({ messages: [data.errors], type: 'danger' });
        } else {
          throw Error(response.statusText);
        }
      })
    )
    .catch(error => {
      console.error(error);
    });
};
