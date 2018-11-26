<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Food.aspx.cs" Inherits="Food" %>

<!DOCTYPE html>
<head runat="server">
         <link rel="stylesheet" type="text/css" href="Css/StyleSheet.css" />
    <link href="Css/StyleSheet2.css" rel="stylesheet" />
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
       
        function logout() {
    
            sessionStorage.removeItem("username");
            sessionStorage.removeItem("fname");
            sessionStorage.removeItem("lname");
            sessionStorage.removeItem("email");
            sessionStorage.removeItem("pass");
            window.location = "Home.aspx";
        }

          function log() {
              var data = sessionStorage.getItem('username');
              if (data != null) { window.location="homeloging.aspx" }
              else {
                  window.location = "Home.aspx";
              }
        }
          function createTablefood() {
            var url2 = url + "?cmd=createTablefood";
            alert(url2)

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
                        var txt = document.createTextNode(obj[i].Name);
                        td.appendChild(txt);
                        tr.appendChild(td);
                        var td = document.createElement("td");
                        var txt = document.createTextNode(obj[i].Price);
                        td.appendChild(txt);
                        tr.appendChild(td);
                        table.appendChild(tr);
                        i++;
                    }
                    
                    
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
            createTablefood();
            
           
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
                <li><a href= "homeloging.aspx" runat="server">Home</a></li> 
                <li><a href="#" runat="server">Shop</a></li>
                <li><a href="#">Menu</a>
                    <ul>
                        <li><a href="Coffee.aspx" runat="server">Coffee Menu</a></li>
                        <li><a href="Food.aspx" runat="server">Foof Menu</a></li>
                    </ul>
                </li>
                <li><a href="About.aspx" runat="server">About</a></li>
                 
            </ul>
        </div>
        <div id="content_area">
<div >

        <h1><b style="font-size:14px;">Food menu</b></h1>
           <table " class=table, id="myTable"  >
                       <tr class="tr" id="myTr">
                           <th class ="th">Name</th>
                           <th>Price</th>
                       </tr>
                   </table>
</div>
   
        </div>
         <div  id="sidebar">
            <img alt="coffee" class="auto-style1" src="Images/espresso.jpg" aria-atomic="True" /></div>>
            
            
        <div id="footer">
            <p>All Rights reserved to Maayan & Keren....</p>
        </div>
    </div>

   </form>
</body>
</html>