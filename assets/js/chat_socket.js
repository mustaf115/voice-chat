import {Socket, Presence} from "phoenix"


const messageInput = document.querySelector('#message')
const token = document.querySelector('#user_token').value

let socket = new Socket("/socket", {params: {token}})

let channel = socket.channel("chat:lobby", {})
let presence = new Presence(channel)

let msgDiv = document.querySelector('#msgs')

const renderOnlineUsers = presence => {
  let response = ""

  presence.list((id) => {
    response += `<br>${id}</br>`
  })

  document.querySelector('#online').innerHTML = response
}

const renderChat = msgs => {
  console.log(msgs)
  msgDiv.innerHTML = ''
  msgs.forEach( msg => {
    msgDiv.innerHTML += `<p>${msg.author}: ${msg.content}</p>`
  })
}

channel.join()
  .receive("ok", ({msgs}) => { renderChat(msgs) })
  .receive("error", resp => { console.log("Unable to join", resp) })

channel.on('new_msg', ({body}) => {
  renderChat(body)
})

messageInput.addEventListener('keypress', e => {
  if(e.keyCode === 13) {
    channel.push('new_msg', { body: e.target.value })
    e.target.value = ''
  }
})

socket.connect()
presence.onSync(() => renderOnlineUsers(presence))
// const chat = () => {
//   let socket = new Socket("/socket", {params: {token}})
//
//   socket.connect()
//
//   const channel
// }

export default socket
