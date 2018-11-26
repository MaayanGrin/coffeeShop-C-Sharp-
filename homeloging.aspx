<%@ Page Language="C#" AutoEventWireup="true" CodeFile="homeloging.aspx.cs" Inherits="Coffee" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../Css/StyleSheet.css" rel="stylesheet" />
    <link href="../Css/StyleSheet2.css" rel="stylesheet" />
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
        function createTable() {
            var url2 = url + "?cmd=createTable&username=" + sessionStorage.getItem('username');
            xmlHttp.open("GET", url2, true);
            xmlHttp.onreadystatechange = buildT;
            xmlHttp.send();
        }

        function buildT() {
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
                        var txt = document.createTextNode(obj[i].Amount);
                        td.appendChild(txt);
                        tr.appendChild(td);
                        var td = document.createElement("td");
                        var txt = document.createTextNode(obj[i].date);
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
            createTable();
        }
        function logout() {
    
            sessionStorage.removeItem("username");
            sessionStorage.removeItem("fname");
            sessionStorage.removeItem("lname");
            sessionStorage.removeItem("email");
            sessionStorage.removeItem("pass");
            window.location = "Home.aspx";
        }


    </script>
       
       
    <style type="text/css">
        .auto-style1 {
            width: 261px;
            height: 409px;
            margin-left: 0px;
        }
    </style>
       
       
</head>
   
   
<body onload="onLoadJavaScript()">
    <form id="form1" runat="server">

                <div id="wrapper">
        <div id="banner">
             <div >
                <h1 id="header" style="margin:0px; color:snow; padding-top:18; padding-left:856px;">Welcome</h1> 
                    
               <script>
                         var data = sessionStorage.getItem('username');
                         document.getElementById("header").innerHTML = "Welcome- "+ data;
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
        <div  id="sidebar">
            <img alt="coffee" class="auto-style1" src="Images/espresso.jpg" aria-atomic="True" /></div>
            
        <div id="content_area">
            <h1><b style="font-size:14px;">Order History</b></h1>
           <table class=table, id="myTable"  >
                       <tr class="tr" id="myTr">
                           <th class ="th">Name</th>
                           <th>Amount</th>
                           <th>Date</th>
                           <th>Price</th>
                       </tr>
                   </table>
           
             
        </div>
        <div id="footer">
            <p>All Rights reserved to Maayan & Keren....</p>
        </div>
    </div>
                             </form>
</body>
</html>