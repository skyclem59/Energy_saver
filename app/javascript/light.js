       // add listener

       var groups = []
       var grouplist = []

       const buttons = document.getElementsByClassName("btn-round")

       const user = 'Jd7BRYz6h3GQlQxVdyxS4nqSGnow2hjydVFAAsYc'
       const url = 'http://10.10.105.176/api/'.concat(user).concat('/groups')
       const myRequest = new Request(url);

       fetch(myRequest)
       .then(response => response.json())
       .then((data) => {
        const results = Object.keys(data).map(key => data[key])
        console.log("jj", results);
        results.forEach((g) => {
           groups.push(g.name)

           });

        return  groups
   });

console.log(grouplist)

       Array.from(buttons).forEach((b) => {

 // add event on each button

 b.addEventListener("click", (event) => {
   //Button.classList.add("blue");

   b.classList.toggle("btn-success")

   var group = 0

   if (b.id === "Salon") {
  var group = 1
  }
   if (b.id === "Cuisine") {
   var  group = 2
  }
   const user = 'Jd7BRYz6h3GQlQxVdyxS4nqSGnow2hjydVFAAsYc'
   const url = 'http://10.10.105.176/api/'.concat(user).concat('/groups/').concat(group).concat('/action')


   if (b.innerText === "ON") {;
    const myRequest = new Request(url , {method: 'PUT', body: '{"on": false}'});

    fetch(myRequest)
    .then(response => response.json());


    b.innerText ="OFF";
  } else {

    const myRequest = new Request(url, {method: 'PUT', body: '{"on": true}'});

    fetch(myRequest)
    .then(response => response.json());

    b.innerText = "ON";
  }
});
});

