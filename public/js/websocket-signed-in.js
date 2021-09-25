const socket = io();
socket.on('loginCheck', () => {
  let loggedIn = window.localStorage.getItem('loggedIn');
  socket.emit('loginResponse', loggedIn);
})