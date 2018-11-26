<%@ Page Language="C#" AutoEventWireup="true" CodeFile="showAdmin.aspx.cs" Inherits="showAdmin" %>


<!DOCTYPE html>
<head runat="server">
    <link rel="stylesheet" type="text/css" href="Css/StyleSheet.css" />
    <link href="Css/StyleSheet2.css" rel="stylesheet" />
     <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"/>
     <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="javascript/JavaScript.js"></script>
    <title>Show List Admin</title>
    <script>
      var url = "Handler.ashx";
             function mainmenu() {
            $(" #nav ul ").css({ display: "none" }); // Opera Fix

            $(" #nav li").hover(function () {
                $(this).find('ul:first').css({ visibility: "visible", display: "none" }).show(400);
            }
            , function () {
                $(this).find('ul:first').css({ visibility: "hidden" });
            });
        }

        $(document).ready(function () {
            mainmenu();
        });
       
        function logout() {
    
            sessionStorage.removeItem("username");
            sessionStorage.removeItem("fname");
            sessionStorage.removeItem("lname");
            sessionStorage.removeItem("email");
            sessionStorage.removeItem("pass");
            window.location = "Home.aspx";
        }
        function onLoadJavaScript() {
            try {
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            catch (e) {
                try {
                    xmlHttp = new XMLHttpRequest();
                }
                catch (e) {
                }
                createTable1()
            }
            
           
        }
                var flag = false;


        $(function () {
            // this initializes the dialog (and uses some common options that I do)
            $("#dialog").dialog({
                autoOpen: false, modal: true, show: "blind", hide: "blind", width: 340, height: 500
            });


            $("#dialog_2").dialog({
                autoOpen: false, modal: true, show: "blind", hide: "blind", width: 340, height: 450
            });
            
           
        });


    function createTable1() {
            var url2 = url + "?cmd=getAllAdmin ";
            xmlHttp.open("GET", url2, true);
        xmlHttp.onreadystatechange = buildTT;
            xmlHttp.send();
        
        }
        
        function buildTT() {
                   if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
                       var myJSON_Text = xmlHttp.responseText;
                if (myJSON_Text != "]") {
                    var obj = eval('(' + myJSON_Text + ')');
                    var i = 0; 
                    var table = document.getElementById("myTable");
                     while (obj[i] != null) {
                       var tr = document.createElement("tr");
                        var td = document.createElement("td");
                        var txt = document.createTextNode(obj[i].username);
                        td.appendChild(txt);
                        tr.appendChild(td);
                        var td = document.createElement("td");
                        var txt = document.createTextNode(obj[i].Fname);
                        td.appendChild(txt);
                        tr.appendChild(td);
                        var td = document.createElement("td");
                        var txt = document.createTextNode(obj[i].Lname);
                        td.appendChild(txt);
                        tr.appendChild(td);
                        var td = document.createElement("td");
                        var txt = document.createTextNode(obj[i].email);
                        td.appendChild(txt);
                        tr.appendChild(td);
                         var td3 = document.createElement("td");
                          var x = "\"" + obj[i].username + "\"";
                        td3.innerHTML += "<a href='#' color='blue' onclick='editA(" + x + "); return false;'>Edit</a>";
                         tr.appendChild(td3);
                        var td4 = document.createElement("td");
                         td4.innerHTML += "<a href='#' color='blue' onclick='DELA(" + x + "); return false;'>Delete</a>";
                        tr.appendChild(td4);
                        table.appendChild(tr);
                        i++;
                     }
                    
                }
                
                   }

        }

           function DELA(x) {
            
            var url2 = url + "?cmd=DelAd&username=" + x;
            xmlHttp.open("GET", url2, true);
            xmlHttp.onreadystatechange = checkDel;
            xmlHttp.send();
        }
              function checkDel() {
                  if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
                      var myJSON_Text = xmlHttp.responseText;
                      if (myJSON_Text != "DELETE") {
                          alert("Sorry Admin has not been deleted");
                      } else {
                          alert("Admin has  been deleted ");
                      }

                      var Table = document.getElementById("myTable");
                      Table.innerHTML = "";
                      createTH();
                      createTable1();
                  }
               }
        
        function editA(x) {
            var url2 = url + "?cmd=getAD&username=" + x;
            xmlHttp.open("GET", url2, true);
            xmlHttp.onreadystatechange = editAdminStep2;
            xmlHttp.send();
        }
        
        function editAdminStep2() {
            if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
                var myJSON_Text = xmlHttp.responseText;
                var obj = eval('(' + myJSON_Text + ')');
                $("#dialog").dialog("open");
                var div = document.getElementById("dialog");
                div.innerHTML = " Username<br/> <input type= 'text' id= 'username' disabled value= " + obj[0].username + "  /> <br/> First Name<br/> <input type= 'text' id= 'firstname' value= " + obj[0].Fname + " /> <br/> Last Name<br/> <input type= 'text' id= 'lastname' value= " + obj[0].Lname + " /> <br/> Email<br/> <input type= 'text' id= 'email'  value= " + obj[0].email + "   /> <br/> Password<br/> <input type= 'text' id= 'password'  value= " + obj[0].pass + " />   <br/> <input type= 'submit' id= 'sub' class='login__submit' value='Edit' onclick='editAd(); return false;' />";

            }
        }
        
        function editAd() {

            var username = document.getElementById('username').value;
            var firstname = document.getElementById('firstname').value;
            var lastname = document.getElementById('lastname').value;
            var email = document.getElementById('email').value;
            var password = document.getElementById('password').value;

            if (firstname == "" || lastname == "" || email == "" || password == "") {
                alert("Please complete the all fields!");
            } else {
                var check = false;
                if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(email))
                    check = true;
                if (!check) {
                    alert("You have entered an invalid email address!")
                } else {
                    var url2 = url + "?cmd=editAD&newfname=" + firstname + "&newlname=" + lastname + "&newusername=" + username + "&newemial=" + email + "&newpassword=" + password ;
                    xmlHttp.open("GET", url2, true);
                    xmlHttp.onreadystatechange = buildnewtable;
                    xmlHttp.send();

                }
            }
        }

            function buildnewtable() {
            if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
                var myJSON_Text = xmlHttp.responseText;
                $("#dialog").dialog("close");
                alert("Edit Successfully");

            var Table = document.getElementById("myTable");
                Table.innerHTML = "";
                createTH();
                createTable1();
            }
        }


        function createTH() {

            var table = document.getElementById("myTable");

            var tr = document.createElement("tr");

            var td = document.createElement("th");
            var txt = document.createTextNode("Username");
            td.appendChild(txt);
            tr.appendChild(td);

            var td = document.createElement("th");
            var txt = document.createTextNode("F-Name");
            td.appendChild(txt);
            tr.appendChild(td);

            var td = document.createElement("th");
            var txt = document.createTextNode("LName");
            td.appendChild(txt);
            tr.appendChild(td);

            var td = document.createElement("th");
            var txt = document.createTextNode("Email");
            td.appendChild(txt);
            tr.appendChild(td);

            var td = document.createElement("th");
            var txt = document.createTextNode("Password");
            td.appendChild(txt);
            tr.appendChild(td);
            

            var td = document.createElement("th");
            tr.appendChild(td);


            table.appendChild(tr);

        }

    </script>
       
       
</head>
   
   
<body onload="onLoadJavaScript()">
    <form id="form1" runat="server">

                <div id="wrapper">
        <div id="banner">
             <div >
                <h1 id="header" style="margin:0px; color:snow; padding-top:18px; padding-left:856px;">Welcome</h1> 
                    
               <script>
                   var data = sessionStorage.getItem('username');
                   if (data != null) {
                       document.getElementById("header").innerHTML = "Welcome- " + data;
                   }
               </script>
                  <input type="submit" style="background-color:inherit; color:snow; float:right"  id="log_in" value="Log Out" onclick='logout(); return false;'/>

                    </div>
        </div>
               
        <div id="navigation">

            <ul id="nav">
                 <li><a href="Admin.aspx" runat="server">Home</a></li>                 
                 <li><a href="#">Show</a>
                    <ul>
                        <li><a href="showclient.aspx" runat="server">Show Clients</a></li>
                        <li><a href="showAdmin.aspx" runat ="server">Show Admins</a></li>
                    </ul>
                </li>
                 <li><a href="Settings Menu.aspx" runat="server">Settings Menu</a><li>
            </ul>
        </div>
        <div id="content_area">

            <h1><b style="font-size:14px;">List Admins</b></h1>
           <table class=table, id="myTable"  >
                       <tr class="tr">
                           <th class ="th">User-Name</th>
                           <th>F-Name</th>
                           <th>L-Name</th>
                           <th>Email</th>
                       </tr>
                   </table>
           
         
   
        </div>
                      <div id="dialog" title="Edit">
           </div>

        <div  id="sidebar">
            <img alt="coffee" class="auto-style1" src="Images/espresso.jpg" aria-atomic="True" /></div>
            
            
        <div id="footer">
            <p>All Rights reserved to Maayan & Keren....</p>
        </div>
    </div>
                             </form>
</body>
</html>
