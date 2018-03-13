       // add listener

const buttons = document.getElementsByClassName("btn-round")
console.log(buttons)

Array.from(buttons).forEach((b) => {

 // add event on each button

 console.log(b)

 b.addEventListener("click", (event) => {
   //Button.classList.add("blue");

b.classList.toggle("btn-success")


if (b.innerText === "ON") {;
  b.innerText ="OFF";
} else {
  b.innerText = "ON";
}


   // if b.classList.contains("btn-green") {
   //    b.classList.remove("btn-green")
   //    b.innerText = "OFF";
   //  } else {
   //    b.classList.add("btn-green")
   //    b.innerText = "ON";
   //  }
   });
});




