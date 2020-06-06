import * as CONSTANTS from './constants';

export const isUnauthorized = response => {
  return response.status == CONSTANTS.STATUS_UNAUTHORIZED;
};
