<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../Css/StyleSheet.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"/>
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="javascript/JavaScript.js"></script>

    <title></title>
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
        function login() {
            var username = document.getElementById('username').value;
            var password = document.getElementById('pass').value;
            if (username == "" || password == "") {
                alert("Enter Username and Password!");
            } else {          
                var url2 = url + "?cmd=login&username="+username+"&pass="+password;
                xmlHttp.open("GET", url2, true);
                xmlHttp.onreadystatechange = checkLogIN;
                xmlHttp.send();
            }
        }

        function checkLogIN() {
             
            if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
                var myJSON_Text = xmlHttp.responseText;
                if (myJSON_Text != "]") {
                    var obj = eval('(' + myJSON_Text + ')');
                    sessionStorage.setItem("username", obj[0].username);
                    sessionStorage.setItem("fname", obj[0].fname);
                    sessionStorage.setItem("lname", obj[0].username);
                    sessionStorage.setItem("email", obj[0].email);
                    sessionStorage.setItem("pass", obj[0].password);

                        window.location = "homeloging.aspx";
                      alert(obj[0].username);

                } else {
                    alert("You enter worng Username or Password , Try again");

                }
            }
        }



            function loginAdmin() {
            var username = document.getElementById('username').value;
            var password = document.getElementById('pass').value;
            if (username == "" || password == "") {
                alert("Enter Username and Password!");
            } else {
                var url2 = url + "?cmd=loginAD&username="+username+"&pass="+password;
                xmlHttp.open("GET", url2, true);
                xmlHttp.onreadystatechange = checkLogINAD;
                xmlHttp.send();
            }
        }
        
        function checkLogINAD() {
             
            if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
                var myJSON_Text = xmlHttp.responseText;
                if (myJSON_Text != "]") {
                    var obj = eval('(' + myJSON_Text + ')');
                    sessionStorage.setItem("username", obj[0].username);
                    sessionStorage.setItem("fname", obj[0].fname);
                    sessionStorage.setItem("lname", obj[0].username);
                    sessionStorage.setItem("email", obj[0].email);
                    sessionStorage.setItem("pass", obj[0].password);

                    window.location ="Admin.aspx";
                      alert(obj[0].username);

                } else {
                    alert("You enter worng Username or Password , Try again");

                }
            }
        }



        function register() {
            var newfname = document.getElementById('newfname').value;
            var newlname = document.getElementById('newlname').value;
            var newusername = document.getElementById('newusername').value;
            var newemial = document.getElementById('newemial').value;
            var newpassword = document.getElementById('newpassword').value;
            if (newfname == "" || newlname == "" || newusername == "" || newemial == "" || newpassword == "") {
                alert("Please complete the all fields!");
            } else {
                var check = false;
                if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(newemial))
                    check = true;
                if (!check) {
                    alert("You have entered an invalid email address!")
                } else {
                    var url2 = url +"?cmd=register&newfname="+newfname+"&newlname="+newlname+"&newusername="+newusername+"&newemial="+newemial+"&newpassword="+newpassword;
                    xmlHttp.open("GET", url2, true);
                    xmlHttp.onreadystatechange = checkRegister;
                    xmlHttp.send();

                }
            }
        }


        function checkRegister() {
            if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
                
                var myJSON_Text = xmlHttp.responseText;
                if (myJSON_Text != "add") {
                    alert("Sorry This username exists in the system");
                } else {
                    alert("Welcome to Coffee Shop , You can Log In ");
                }
            }

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
            }
            sessionStorage.removeItem("username");
            sessionStorage.removeItem("fname");
            sessionStorage.removeItem("lname");
            sessionStorage.removeItem("email");
            sessionStorage.removeItem("pass");
                
        }
  
    </script>
       
   
       
</head>
   
<body onload="onLoadJavaScript()">
    <form id="form1" runat="server">

                <div id="wrapper">
        <div id="banner">
             <div >

                        <table style="width:200px;height:200px ; padding-top:155px; float:right; " >
                            <tr style="border:none">
                                <td class="auto-style1"><input type="text" placeholder="username"  id="username"   /></td> 
                                <td class="auto-style1"><input type="password" placeholder="password"  id="pass" /></td> 
                                <td class="auto-style1"><input type="submit" style="background-color:inherit; color:snow; float:right"   id="log_in" value="Log In" onclick='login(); return false;'/></td>
                                <td class="auto-style1"><input type="submit" style="background-color:inherit; color:snow; float:right"   id="loginadmin" value="Log In As Admin" onclick='loginAdmin(); return false;'/></td>

                            </tr>

                        </table>

                    </div>
        </div>
               
        <div id="navigation">

            <ul id="nav">
                <li><a href= "Home.aspx" runat="server">Home</a></li> 
              
            </ul>
        </div>
        <div id="content_area">
                     
                      <table style="padding-left:30px; ">

                    <tr>
                       <td> <h2 >New User? Create a New Account!</h2></td>    
                    </tr>
                    
                    <tr>
                            <td><input type="text"  placeholder="First Name"  id="newfname"  required="required" /></td> 
                            <td><input type="text"  placeholder="Last Name"  id="newlname"  required="required" /></td>
                    </tr>
                    <tr>
                         <td><input type="text"  placeholder="User Name"  id="newusername"  required="required" /></td> 
                         <td><input type="email"  placeholder="Email"  id="newemial"  required="required" /></td> 
                    </tr>

                    <tr>
                         <td><input type="password"  placeholder="Password"  id="newpassword"  required="required" /></td> 
                    </tr>

                    <tr>
                        <td><input type="submit"   id="newaccount"  value="Create Account"  onclick='register(); return false;'/></td> 

                    </tr>
                  

                </table>
             <p style="font-size:20px;"><b>Welcome to our coffee shop<br>
              The cafe allows registered customers to pre-order their order by phone without waiting in line.<br>
               Come and be part of us sign up today:)</br><br></p>
        <img id="tag2" src="https://media.giphy.com/media/687qS11pXwjCM/giphy.gif"  class="imgRight"/>
 
        </div>
                    

         <div  id="sidebar">
            <img alt="coffee"  src="https://media.giphy.com/media/10sKNgit3jiU2A/giphy.gif"  style="padding-right:100px;"/></div>
          
            
        <div id="footer">
            <p>All Rights reserved to Maayan & Keren....</p>
        </div>
                    </div>
                             </form>
</body>
</html>
