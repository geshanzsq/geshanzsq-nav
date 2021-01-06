<template>
  <div class="loader">
    <div class="loader-inner pacman">
      <div></div>
      <div></div>
      <div></div>
      <div></div>
      <div></div>
      <span class="loader-text">{{content}}</span>
    </div>
  </div>
</template>

<script>
  export default {
    name: "Jump",
    props: {
      content: {
        type: String,
        default: '正在拼命跳转中，请等待...'
      }
    }
  }
</script>

<style scoped>
  body{
    background:#999;
    margin:0;
  }

  .loader {
    -webkit-animation:fadein 2s;
    -moz-animation:fadein 2s;
    -o-animation:fadein 2s;
    animation:fadein 2s;
    position:absolute;
    top:0;
    left:0;
    right:0;
    bottom:0;
    background-color:#fff;
  }

  @-moz-keyframes fadein{
    from {
      opacity:0
    }
    to {
      opacity:1
    }
  }

  @-webkit-keyframes fadein{
    from{
      opacity:0
    }
    to {
      opacity:1
    }
  }

  @-o-keyframes fadein{
    from{
      opacity:0
    }
    to {
      opacity:1
    }
  }

  @keyframes fadein{
    from{
      opacity:0
    }
    to{
      opacity:1
    }
  }

  .loader-inner{
    position:absolute;
    z-index:300;
    top:40%;
    left:50%;
    -webkit-transform:translate(-50%,-50%);
    -moz-transform:translate(-50%,-50%);
    -ms-transform:translate(-50%,-50%);
    -o-transform:translate(-50%,-50%);
    transform:translate(-50%,-50%);
  }

  @-webkit-keyframes rotate_pacman_half_up{
    0% {
      -webkit-transform:rotate(270deg);
      transform:rotate(270deg);
    }
    50% {
      -webkit-transform:rotate(360deg);
      transform:rotate(360deg);
    }
    100%{
      -webkit-transform:rotate(270deg);
      transform:rotate(270deg);
    }
  }

  @keyframes rotate_pacman_half_up{
    0%{
      -webkit-transform:rotate(270deg);
      transform:rotate(270deg);
    }
    50%{
      -webkit-transform:rotate(360deg);
      transform:rotate(360deg);
    }
    100%{
      -webkit-transform:rotate(270deg);
      transform:rotate(270deg);
    }
  }
  @-webkit-keyframes rotate_pacman_half_down{
    0%{
      -webkit-transform:rotate(90deg);
      transform:rotate(90deg);
    }
    50%{
      -webkit-transform:rotate(0deg);
      transform:rotate(0deg);
    }
    100%{
      -webkit-transform:rotate(90deg);
      transform:rotate(90deg);
    }
  }
  @keyframes rotate_pacman_half_down{
    0%{
      -webkit-transform:rotate(90deg);
      transform:rotate(90deg);
    }
    50%{
      -webkit-transform:rotate(0deg);
      transform:rotate(0deg);
    }
    100%{
      -webkit-transform:rotate(90deg);
      transform:rotate(90deg);
    }
  }
  @-webkit-keyframes pacman-balls{
    75%{
      opacity:0.7;
    }
    100%{
      -webkit-transform:translate(-100px,-6.25px);
      transform:translate(-100px,-6.25px);
    }
  }
  @keyframes pacman-balls{
    75%{
      opacity:0.7;
    }
    100%{
      -webkit-transform:translate(-100px,-6.25px);
      transform:translate(-100px,-6.25px);
    }
  }
  .pacman > div:nth-child(2){
    -webkit-animation:pacman-balls 1s 0s infinite linear;
    animation:pacman-balls 1s 0s infinite linear;
  }
  .pacman > div:nth-child(3){
    -webkit-animation:pacman-balls 1s 0.33s infinite linear;
    animation:pacman-balls 1s 0.33s infinite linear;
  }
  .pacman > div:nth-child(4){
    -webkit-animation:pacman-balls 1s 0.66s infinite linear;
    animation:pacman-balls 1s 0.66s infinite linear;
  }
  .pacman > div:nth-child(5){
    -webkit-animation:pacman-balls 1s 0.99s infinite linear;
    animation:pacman-balls 1s 0.99s infinite linear;
  }
  .pacman > div:first-of-type{
    width:0px;
    height:0px;
    border-right:25px solid transparent;
    border-top:25px solid #e1244e;
    border-left:25px solid #e1244e;
    border-bottom:25px solid #e1244e;border-radius:25px;
    -webkit-animation:rotate_pacman_half_up 0.5s 0s infinite;
    animation:rotate_pacman_half_up 0.5s 0s infinite;
  }
  .pacman > div:nth-child(2){
    width:0px;
    height:0px;
    border-right:25px solid transparent;
    border-top:25px solid #e1244e;
    border-left:25px solid #e1244e;
    border-bottom:25px solid #e1244e;
    border-radius:25px;
    -webkit-animation:rotate_pacman_half_down 0.5s 0s infinite;
    animation:rotate_pacman_half_down 0.5s 0s infinite;margin-top:-50px;
  }
  .pacman > div:nth-child(3),.pacman > div:nth-child(4),.pacman > div:nth-child(5),.pacman > div:nth-child(6){
    background-color:#e1244e;
    width:15px;
    height:15px;
    border-radius:100%;
    margin:2px;
    width:10px;
    height:10px;
    position:absolute;
    -webkit-transform:translate(0,-6.25px);
    -ms-transform:translate(0,-6.25px);
    transform:translate(0,-6.25px);
    top:25px;
    left:100px;
  }
  .loader-text{
    margin:20px 0 0 -60px;
    display:block;
    font-size: 20px;
    font-weight: bold;
  }
</style>