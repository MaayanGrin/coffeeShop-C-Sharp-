<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Threading.Tasks;

using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;

public class Handler : HttpTaskAsyncHandler
{

    private SqlConnection myConnect;
    private SqlCommand mySQLCommand;
    private SqlCommand mySQLCommand2;
    private SqlDataReader reader2;
    private SqlDataReader reader;
    private JavaScriptSerializer myJavaScriptSerializer2;
    private string resultStr;
    private JavaScriptSerializer myJavaScriptSerializer = new JavaScriptSerializer();


    public override async Task ProcessRequestAsync(HttpContext context)
    {
        string username = "";
        if (context.Request.QueryString["username"] != null)
            username = context.Request.QueryString["username"];
        string cmd = "";
        if (context.Request.QueryString["cmd"] != null)
            cmd = context.Request.QueryString["cmd"];

        string myConnectString = "Data Source=DESKTOP-A8J2RQH\\SQLEXPRESS;" +
            "Initial Catalog=CoffeShop;Integrated Security=True";
        myConnect = new SqlConnection(myConnectString);
        await myConnect.OpenAsync();

        if (cmd == "login")
        {
            String username2 = context.Request.QueryString["username"];
            String password2 = context.Request.QueryString["pass"];
            mySQLCommand2 = new SqlCommand("SELECT * FROM [users] where  username  = '" + username2 + "' AND pass = '" + password2 + "' ", myConnect);
            reader2 = await mySQLCommand2.ExecuteReaderAsync();
            myJavaScriptSerializer2 = new JavaScriptSerializer();
            resultStr = "[";
            User user = new User();
            if (await reader2.ReadAsync())
            {
                user.username = reader2.GetString(0);
                user.Fname = reader2.GetString(1);
                user.Lname = reader2.GetString(2);
                user.email = reader2.GetString(3);
                user.pass = reader2.GetString(4);
                resultStr += myJavaScriptSerializer.Serialize(user) + ",";
            }
            resultStr = resultStr.Substring(0, resultStr.Length - 1);
            resultStr += "]";
            myConnect.Close();
            context.Response.Write(resultStr);
        }
        if (cmd == "register")
        {

            String newfname = context.Request.QueryString["newfname"];
            String newlname = context.Request.QueryString["newlname"];
            String newusername = context.Request.QueryString["newusername"];
            String newemial = context.Request.QueryString["newemial"];
            String newpassword = context.Request.QueryString["newpassword"];

            mySQLCommand = new SqlCommand("INSERT INTO [users] (username,Fname,Lname,email,pass) VALUES('" + newusername + "','" + newfname + "','" + newlname + "','" + newemial + "','" + newpassword + "') ", myConnect);
            var check1 = false;
            try
            {

                reader = await mySQLCommand.ExecuteReaderAsync();
            }
            catch (Exception e)
            {
                check1 = true;
                context.Response.Write("exist");

            }

            if (check1 == false)

                context.Response.Write("add");
            myConnect.Close();
        }
        if (cmd == "registerA")
        {

            String newfname = context.Request.QueryString["newfname"];
            String newlname = context.Request.QueryString["newlname"];
            String newusername = context.Request.QueryString["newusername"];
            String newemial = context.Request.QueryString["newemial"];
            String newpassword = context.Request.QueryString["newpassword"];

            mySQLCommand = new SqlCommand("INSERT INTO [Admin] (username,Fname,Lname,email,pass) VALUES('" + newusername + "','" + newfname + "','" + newlname + "','" + newemial + "','" + newpassword + "') ", myConnect);
            var check1 = false;
            try
            {

                reader = await mySQLCommand.ExecuteReaderAsync();
            }
            catch (Exception e)
            {
                check1 = true;
                context.Response.Write("exist");

            }

            if (check1 == false)

                context.Response.Write("add");
            myConnect.Close();
        }

        if (cmd == "loginAD")
        {
            String username2 = context.Request.QueryString["username"];
            String password2 = context.Request.QueryString["pass"];
            mySQLCommand2 = new SqlCommand("SELECT * FROM [Admin] where  username  = '" + username2 + "' AND pass = '" + password2 + "' ", myConnect);
            reader2 = await mySQLCommand2.ExecuteReaderAsync();
            myJavaScriptSerializer2 = new JavaScriptSerializer();
            resultStr = "[";
            User user = new User();
            if (await reader2.ReadAsync())
            {
                user.username = reader2.GetString(0);
                user.Fname = reader2.GetString(1);
                user.Lname = reader2.GetString(2);
                user.email = reader2.GetString(3);
                user.pass = reader2.GetString(4);
                resultStr += myJavaScriptSerializer.Serialize(user) + ",";
            }
            resultStr = resultStr.Substring(0, resultStr.Length - 1);
            resultStr += "]";
            myConnect.Close();
            context.Response.Write(resultStr);
        }
        if (cmd == "createTable")
        {

            String username2 = context.Request.QueryString["username"];
            mySQLCommand2 = new SqlCommand("SELECT * FROM [Order] where username  = '" + username2 + "'", myConnect);
            reader2 = await mySQLCommand2.ExecuteReaderAsync();
            myJavaScriptSerializer2 = new JavaScriptSerializer();
            resultStr = "[";
            Order order = new Order();
            while (await reader2.ReadAsync())
            {
                order.username = reader2.GetString(0);
                order.Name = reader2.GetString(1);
                order.Amount = reader2.GetInt32(2);
                var c = reader2.GetDateTime(3);
                c.GetDateTimeFormats();
                order.date = c.ToShortDateString();
                order.Price = reader2.GetInt32(4);
                resultStr += myJavaScriptSerializer.Serialize(order) + ",";
            }

            resultStr = resultStr.Substring(0, resultStr.Length - 1);
            resultStr += "]";
            myConnect.Close();
            context.Response.Write(resultStr);

        }
        if (cmd == "createTablecoffee")
        {

            mySQLCommand2 = new SqlCommand("SELECT * FROM [Item] where Type= 'coffee' ", myConnect);
            reader2 = await mySQLCommand2.ExecuteReaderAsync();
            myJavaScriptSerializer2 = new JavaScriptSerializer();
            resultStr = "[";
            item item = new item();
            while (await reader2.ReadAsync())
            {
                item.Name = reader2.GetString(0);
                item.Price = reader2.GetInt32(2);
                resultStr += myJavaScriptSerializer.Serialize(item) + ",";
            }

            resultStr = resultStr.Substring(0, resultStr.Length - 1);
            resultStr += "]";
            myConnect.Close();
            context.Response.Write(resultStr);

        }

        if (cmd == "createTablefood")
        {

            mySQLCommand2 = new SqlCommand("SELECT * FROM [Item] where Type='food '", myConnect);
            reader2 = await mySQLCommand2.ExecuteReaderAsync();
            myJavaScriptSerializer2 = new JavaScriptSerializer();
            resultStr = "[";
            item item = new item();
            while (await reader2.ReadAsync())
            {
                item.Name = reader2.GetString(0);
                item.Price = reader2.GetInt32(2);
                resultStr += myJavaScriptSerializer.Serialize(item) + ",";
            }

            resultStr = resultStr.Substring(0, resultStr.Length - 1);
            resultStr += "]";
            myConnect.Close();
            context.Response.Write(resultStr);

        }

        if (cmd == "getAllUser")
        {
            mySQLCommand2 = new SqlCommand("SELECT * FROM users", myConnect);
            reader2 = await mySQLCommand2.ExecuteReaderAsync();
            myJavaScriptSerializer2 = new JavaScriptSerializer();
            resultStr = "[";
            User user = new User();
            while (await reader2.ReadAsync())
            {
                user.username = reader2.GetString(0);
                user.Fname = reader2.GetString(1);
                user.Lname = reader2.GetString(2);
                user.email = reader2.GetString(3);
                user.pass = reader2.GetString(4);
                resultStr += myJavaScriptSerializer.Serialize(user) + ",";
            }
            resultStr = resultStr.Substring(0, resultStr.Length - 1);
            resultStr += "]";
            myConnect.Close();
            context.Response.Write(resultStr);


        }
        if (cmd == "getAllAdmin")
        {
            mySQLCommand2 = new SqlCommand("SELECT * FROM [Admin] ", myConnect);
            reader2 = await mySQLCommand2.ExecuteReaderAsync();
            myJavaScriptSerializer2 = new JavaScriptSerializer();
            resultStr = "[";
            User user = new User();
            while (await reader2.ReadAsync())
            {

                user.username = reader2.GetString(0);
                user.Fname = reader2.GetString(1);
                user.Lname = reader2.GetString(2);
                user.email = reader2.GetString(3);
                user.pass = reader2.GetString(4);
                resultStr += myJavaScriptSerializer.Serialize(user) + ",";
            }
            resultStr = resultStr.Substring(0, resultStr.Length - 1);
            resultStr += "]";
            myConnect.Close();
            context.Response.Write(resultStr);


        }
        if (cmd == "DelAd")
        {
            String username2 = context.Request.QueryString["username"];
            mySQLCommand2 = new SqlCommand("DELETE FROM [Admin] WHERE username='" + username2 + "'", myConnect);
            var check1 = false;
            try
            {

                reader = await mySQLCommand2.ExecuteReaderAsync();
            }
            catch (Exception e)
            {
                check1 = true;
                context.Response.Write("NOT DELETE");

            }

            if (check1 == false)

                context.Response.Write("DELETE");
            myConnect.Close();
        }

        if (cmd == "getAD")
        {
            String username2 = context.Request.QueryString["username"];
            mySQLCommand2 = new SqlCommand("SELECT * FROM [Admin] where  username  = '" + username2 + "' ", myConnect);
            reader2 = await mySQLCommand2.ExecuteReaderAsync();
            myJavaScriptSerializer2 = new JavaScriptSerializer();
            resultStr = "[";
            User user = new User();
            if (await reader2.ReadAsync())
            {
                user.username = reader2.GetString(0);
                user.Fname = reader2.GetString(1);
                user.Lname = reader2.GetString(2);
                user.email = reader2.GetString(3);
                user.pass = reader2.GetString(4);

                resultStr += myJavaScriptSerializer.Serialize(user) + ",";
            }
            resultStr = resultStr.Substring(0, resultStr.Length - 1);
            resultStr += "]";
            myConnect.Close();
            context.Response.Write(resultStr);


        }

        if (cmd == "editAD")
        {
            String newfname = context.Request.QueryString["newfname"];
            String newlname = context.Request.QueryString["newlname"];
            String newusername = context.Request.QueryString["newusername"];
            String newemial = context.Request.QueryString["newemial"];
            String newpassword = context.Request.QueryString["newpassword"];


            mySQLCommand = new SqlCommand("UPDATE [Admin] SET fname = '" + newfname + "',lname = '" + newlname + "',email = '" + newemial + "',pass = '" + newpassword + "' WHERE username = '" + newusername + "'  ", myConnect);
            try { reader = await mySQLCommand.ExecuteReaderAsync(); }
            catch (Exception e)
            {
                context.Response.Write("not edit");
                return;
            }
            myConnect.Close();
            context.Response.Write("edit");

        }

        if (cmd == "Delc")
        {
            String username2 = context.Request.QueryString["username"];
            mySQLCommand2 = new SqlCommand("DELETE FROM [users] WHERE username='" + username2 + "'", myConnect);
            var check1 = false;
            try
            {

                reader = await mySQLCommand2.ExecuteReaderAsync();
            }
            catch (Exception e)
            {
                check1 = true;
                context.Response.Write("NOT DELETE");

            }

            if (check1 == false)

                context.Response.Write("DELETE");
            myConnect.Close();
        }

        if (cmd == "getc")
        {
            String username2 = context.Request.QueryString["username"];
            mySQLCommand2 = new SqlCommand("SELECT * FROM [users] where  username  = '" + username2 + "' ", myConnect);
            reader2 = await mySQLCommand2.ExecuteReaderAsync();
            myJavaScriptSerializer2 = new JavaScriptSerializer();
            resultStr = "[";
            User user = new User();
            if (await reader2.ReadAsync())
            {
                user.username = reader2.GetString(0);
                user.Fname = reader2.GetString(1);
                user.Lname = reader2.GetString(2);
                user.email = reader2.GetString(3);
                user.pass = reader2.GetString(4);

                resultStr += myJavaScriptSerializer.Serialize(user) + ",";
            }
            resultStr = resultStr.Substring(0, resultStr.Length - 1);
            resultStr += "]";
            myConnect.Close();
            context.Response.Write(resultStr);


        }

        if (cmd == "editc")
        {
            String newfname = context.Request.QueryString["newfname"];
            String newlname = context.Request.QueryString["newlname"];
            String newusername = context.Request.QueryString["newusername"];
            String newemial = context.Request.QueryString["newemial"];
            String newpassword = context.Request.QueryString["newpassword"];


            mySQLCommand = new SqlCommand("UPDATE [users] SET fname = '" + newfname + "',lname = '" + newlname + "',email = '" + newemial + "',pass = '" + newpassword + "' WHERE username = '" + newusername + "'  ", myConnect);
            try { reader = await mySQLCommand.ExecuteReaderAsync(); }
            catch (Exception e)
            {
                context.Response.Write("not edit");
                return;
            }
            myConnect.Close();
            context.Response.Write("edit");

        }

        if (cmd == "getMenu")
        {

            mySQLCommand2 = new SqlCommand("SELECT * FROM [Item]", myConnect);
            reader2 = await mySQLCommand2.ExecuteReaderAsync();
            myJavaScriptSerializer2 = new JavaScriptSerializer();
            resultStr = "[";
            item item = new item();
            while (await reader2.ReadAsync())
            {
                item.Name = reader2.GetString(0);
                item.Type = reader2.GetString(1);
                item.Price = reader2.GetInt32(2);
                resultStr += myJavaScriptSerializer.Serialize(item) + ",";
            }

            resultStr = resultStr.Substring(0, resultStr.Length - 1);
            resultStr += "]";
            myConnect.Close();
            context.Response.Write(resultStr);

        }

        if (cmd == "Del")
        {
            String type = context.Request.QueryString["Name"];
            mySQLCommand2 = new SqlCommand("DELETE FROM [Item] WHERE Name='" + type + "'", myConnect);
            var check1 = false;
            try
            {

                reader = await mySQLCommand2.ExecuteReaderAsync();
            }
            catch (Exception e)
            {
                check1 = true;
                context.Response.Write("NOT DELETE");

            }

            if (check1 == false)

                context.Response.Write("DELETE");
            myConnect.Close();
        }

        if (cmd == "getmenu1")
        {
            String type = context.Request.QueryString["Name"];
            mySQLCommand2 = new SqlCommand("SELECT * FROM [Item] where  Name  = '" + type + "' ", myConnect);
            reader2 = await mySQLCommand2.ExecuteReaderAsync();
            myJavaScriptSerializer2 = new JavaScriptSerializer();
            resultStr = "[";
            item item = new item();
            if (await reader2.ReadAsync())
            {
                item.Name = reader2.GetString(0);
                item.Type = reader2.GetString(1);
                item.Price = reader2.GetInt32(2);
                ;

                resultStr += myJavaScriptSerializer.Serialize(item) + ",";
            }
            resultStr = resultStr.Substring(0, resultStr.Length - 1);
            resultStr += "]";
            myConnect.Close();
            context.Response.Write(resultStr);


        }

        if (cmd == "edit")
        {
            String name = context.Request.QueryString["Name"];
            String type = context.Request.QueryString["Type"];
            String price = context.Request.QueryString["Price"];

            mySQLCommand = new SqlCommand("UPDATE [Item] SET Name = '" + name + "',Type = '" + type + "',Price = '" + price + "' WHERE Name ='" + name+"'", myConnect);
            try { reader = await mySQLCommand.ExecuteReaderAsync(); }
            catch (Exception e)
            {
                context.Response.Write("not edit");
                return;
            }
            myConnect.Close();
            context.Response.Write("edit");

        }
           if (cmd == "editAdd")
        {
            String name = context.Request.QueryString["Name"];
            String type = context.Request.QueryString["Type"];
            String price = context.Request.QueryString["Price"];

             mySQLCommand = new SqlCommand("INSERT INTO [Item] (Name,Type,Price) VALUES('" + name + "','" + type + "','" + price + "') ", myConnect);
            var check1 = false;
            try
            {

                reader = await mySQLCommand.ExecuteReaderAsync();
            }
            catch (Exception e)
            {
                check1 = true;
                context.Response.Write("exist");

            }

            if (check1 == false)

                context.Response.Write("add");
            myConnect.Close();
        }



    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}