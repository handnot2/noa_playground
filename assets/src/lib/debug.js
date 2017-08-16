const log = function(data, label = null) {
  if (sessionStorage.getItem('debug')) {
    if (label != null) {console.log(label);}
    console.log(data);
  }
}

export default {
  log
}
