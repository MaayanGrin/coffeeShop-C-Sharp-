<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Admin.aspx.cs" Inherits="Admin" %>

<!DOCTYPE html>
<head runat="server">
    <link rel="stylesheet" type="text/css" href="Css/StyleSheet.css" />
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
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

        }

        function registerA() {
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
                    var url2 = url + "?cmd=registerA&newfname=" + newfname + "&newlname=" + newlname + "&newusername=" + newusername + "&newemial=" + newemial + "&newpassword=" + newpassword;
                    xmlHttp.open("GET", url2, true);
                    xmlHttp.onreadystatechange = checkRegisterA;
                    xmlHttp.send();

                }
            }
        }


        function checkRegisterA() {
            if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
                var myJSON_Text = xmlHttp.responseText;
                if (myJSON_Text != "add") {
                    alert("Sorry This username exists in the system");
                } else {
                    alert("The manager was added to the system ");
                }
            }
        }


    </script>


</head>


<body onload="onLoadJavaScript()">
    <form id="form1" runat="server">

        <div id="wrapper">
            <div id="banner">
                <div>
                    <h1 id="header" style="margin: 0px; color: snow; padding-top: 18px; padding-left: 856px;">Welcome</h1>

                    <script>
                        var data = sessionStorage.getItem('username');
                        if (data != null) {
                            document.getElementById("header").innerHTML = "Welcome- " + data;
                        }
                    </script>
                    <input type="submit" style="background-color: inherit; color: snow; float: right" id="log_in" value="Log Out" onclick='logout(); return false;' />

                </div>
            </div>

            <div id="navigation">

                <ul id="nav">
                    <li><a href="Admin.aspx" runat="server">Home</a></li>
                    <li><a href="#">Show</a>
                        <ul>
                            <li><a href="showclient.aspx" runat="server">Show Clients</a></li>
                            <li><a href="showAdmin.aspx" runat="server">Show Admins</a></li>
                        </ul>
                    </li>
                    <li><a href="Settings Menu.aspx" runat="server">Settings Menu</a><li>
                </ul>
            </div>
            <div id="content_area">

                <table style="padding-left: 30px;">

                    <tr>
                        <td>
                            <h2>Add Now  New Admin!!!</h2>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <input type="text" placeholder="First Name" id="newfname" required="required" /></td>
                        <td>
                            <input type="text" placeholder="Last Name" id="newlname" required="required" /></td>
                    </tr>
                    <tr>
                        <td>
                            <input type="text" placeholder="User Name" id="newusername" required="required" /></td>
                        <td>
                            <input type="email" placeholder="Email" id="newemial" required="required" /></td>
                    </tr>

                    <tr>
                        <td>
                            <input type="password" placeholder="Password" id="newpassword" required="required" /></td>
                    </tr>

                    <tr>
                        <td>
                            <input type="submit" id="newaccount" value="Add Admin" onclick='registerA(); return false;' /></td>

                    </tr>


                </table>

            </div>

            <div id="sidebar">
                <img alt="coffee" class="auto-style1" src="Images/espresso.jpg" aria-atomic="True" />
            </div>

            <div id="footer">
                <p>All Rights reserved to Maayan & Keren....</p>
            </div>
        </div>
    </form>
</body>
</html>