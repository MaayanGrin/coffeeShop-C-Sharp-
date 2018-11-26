<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Settings Menu.aspx.cs" Inherits="Settings_Menu" %>

<!DOCTYPE html>
<head runat="server">
    <link rel="stylesheet" type="text/css" href="Css/StyleSheet.css" />
    <link href="Css/StyleSheet2.css" rel="stylesheet" />
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

        $(function () {
            // this initializes the dialog (and uses some common options that I do)
            $("#dialog").dialog({
                autoOpen: false, modal: true, show: "blind", hide: "blind", width: 340, height: 500
            });


            $("#dialog2").dialog({
                autoOpen: false, modal: true, show: "blind", hide: "blind", width: 340, height: 450
            });


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
                createTable();
            }
        }

        function createTable() {
            var url2 = url + "?cmd=getMenu ";
            xmlHttp.open("GET", url2, true);
            xmlHttp.onreadystatechange = buildT1;
            xmlHttp.send();

        }

        function buildT1() {
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
                        var txt = document.createTextNode(obj[i].Type);
                        td.appendChild(txt);
                        tr.appendChild(td);
                        var td = document.createElement("td");
                        var txt = document.createTextNode(obj[i].Price);
                        td.appendChild(txt);
                        tr.appendChild(td);

                        var td3 = document.createElement("td");
                        var x = "\"" + obj[i].Name + "\"";
                        td3.innerHTML += "<a href='#' color='blue' onclick='edit(" + x + "); return false;'>Edit</a>";
                        tr.appendChild(td3);
                        var td4 = document.createElement("td");
                        td4.innerHTML += "<a href='#' color='blue' onclick='DEL(" + x + "); return false;'>Delete</a>";
                        tr.appendChild(td4);
                        table.appendChild(tr);
                        i++;
                    }

                }
            }

        }

        function DEL(x) {

            var url2 = url + "?cmd=Del&Name=" + x;
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
                createTable();
            }
        }

        function edit(x) {

            var url2 = url + "?cmd=getmenu1&Name=" + x;
            xmlHttp.open("GET", url2, true);
            xmlHttp.onreadystatechange = editStep2;
            xmlHttp.send();
        }

        function editStep2() {
            if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
                var myJSON_Text = xmlHttp.responseText;
                var obj = eval('(' + myJSON_Text + ')');
                $("#dialog").dialog("open");
                var div = document.getElementById("#dialog");
                div.innerHTML = " Name<br/> <input type= 'text' id= 'Name' disabled value= " + obj[0].Name + "  /> <br/> Type<br/> <input type= 'text' id= 'Type' value= " + obj[0].Type + " /> <br/> Price<br/> <input type= 'text' id= 'Price' value= " + obj[0].Price + " /> <br/>  <input type= 'submit' id= 'sub' class='login__submit' value='Edit' onclick='editM1(); return false;' />";

            }
        }

        function editM1() {

            var name = document.getElementById('Name').value;
            var type = document.getElementById('Type').value;
            var price = document.getElementById('Price').value;

            if (name == "" || type == "" || price == "") {
                alert("Please complete the all fields!");
            } else {
                var url2 = url + "?cmd=edit&Name=" + name + "&Type=" + type + "&Price=" + price;
                xmlHttp.open("GET", url2, true);

                xmlHttp.onreadystatechange = buildnewtable;
                xmlHttp.send();

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
                createTable();
            }
        }

        function createTH() {

            var table = document.getElementById("myTable");

            var tr = document.createElement("tr");

            var td = document.createElement("th");
            var txt = document.createTextNode("Name");
            td.appendChild(txt);
            tr.appendChild(td);

            var td = document.createElement("th");
            var txt = document.createTextNode("Type");
            td.appendChild(txt);
            tr.appendChild(td);

            var td = document.createElement("th");
            var txt = document.createTextNode("Price");
            td.appendChild(txt);
            tr.appendChild(td);

            var td = document.createElement("th");
            tr.appendChild(td);


            table.appendChild(tr);

        }

        function additem() {
            $("#dialog2").dialog("open");
            var div = document.getElementById("dialog2");
            div.innerHTML = " Name<br/> <input type= 'text' id= 'Name' /> <br/> Type<br/> <input type= 'text' id= 'Type'  /> <br/> Price<br/> <input type= 'text' id= 'Price'  /> <br/>  <input type= 'submit' id= 'sub' class='login__submit' value='Add' onclick='editAdd(); return false;' />";

        }

        function editAdd() {
            var name = document.getElementById('Name').value;
            var type = document.getElementById('Type').value;
            var price = document.getElementById('Price').value;

            if (name == "" || type == "" || price == "") {
                alert("Please complete the all fields!");
            } else {
                var url2 = url + "?cmd=editAdd&Name=" + name + "&Type=" + type + "&Price=" + price;
                xmlHttp.open("GET", url2, true);
                xmlHttp.onreadystatechange = addMenu3;
                xmlHttp.send();

            }
        }

        function addMenu3() {
            if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
                var myJSON_Text = xmlHttp.responseText;
                $("#dialog2").dialog("close");
                alert("Add Successfully");
               
                var Table = document.getElementById("myTable");
                Table.innerHTML = "";
                createTH();
                createTable();
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

                <h1><b style="font-size: 14px;">Menu   </b>
                    <input type="submit" value="Add Item" onclick='additem(); return false' class="auto-style1" /></h1>
                &nbsp;
            </div>
            <table class="table," id="myTable">
                <tr class="tr">
                    <th class="th">Name</th>
                    <th>Type</th>
                    <th>Price</th>
                </tr>
            </table>


        </div>
        <div id="dialog" title="Edit">
        </div>
        <div id="dialog2" title="Edit">
        </div>

        <div id="sidebar" style="margin: auto">
        </div>


        <div id="footer">
            <p>All Rights reserved to Maayan & Keren....</p>
        </div>
        </div>
    </form>
</body>
</html>