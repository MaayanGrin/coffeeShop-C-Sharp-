<%@ Page Language="C#" AutoEventWireup="true" CodeFile="About.aspx.cs" Inherits="About" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
         <link rel="stylesheet" type="text/css" href="Css/StyleSheet.css" />
     <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"/>
     <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="javascript/JavaScript.js"></script>
    <title></title>
    <script>

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


    </script>
       
       
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
        <div id="content_area">
 
             לרשום דברים על המסעדה
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