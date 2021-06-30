

/**
 * Calculates MD5 of the given string and returns
 * the base64 encoded binary.
 */
export function md5Base64(string) {
  return md5(string).toString(encBase64);
}

/**
 * A simple throttle version that ensures
 * the given function is called at most once
 * within the given time window.
 */
export function throttle(fn, windowMs) {
  let ignore = false;

  return (...args) => {
    if (!ignore) {
      fn(...args);
      ignore = true;
      setTimeout(() => {
        ignore = false;
      }, windowMs);
    }
  };
}
