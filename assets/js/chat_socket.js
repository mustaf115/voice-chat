import {Socket} from "phoenix"


const messageInput = document.querySelector('#message')
const token = document.querySelector('#user_token').value

let socket = new Socket("/socket", {params: {token}})
socket.connect()

let channel = socket.channel("chat:lobby", {})
let msgDiv = document.querySelector('#msgs')

const drawChat = msgs => {
  console.log(msgs)
  msgDiv.innerHTML = ''
  msgs.forEach( msg => {
    msgDiv.innerHTML += `<p>${msg.author}: ${msg.content}</p>`
  })
}

channel.join()
  .receive("ok", ({msgs}) => { drawChat(msgs) })
  .receive("error", resp => { console.log("Unable to join", resp) })

channel.on('new_msg', ({body}) => {
  drawChat(body)
})

messageInput.addEventListener('keypress', e => {
  if(e.keyCode === 13) {
    channel.push('new_msg', { body: e.target.value })
    e.target.value = ''
  }
})

// const chat = () => {
//   let socket = new Socket("/socket", {params: {token}})
//
//   socket.connect()
//
//   const channel
// }

export default socket
