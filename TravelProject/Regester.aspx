<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Regester.aspx.cs" Inherits="TravelProject.Regester" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <h2>會員註冊 Member Register</h2>
        帳號<asp:TextBox ID="txtAccount" runat="server" TextMode="SingleLine"></asp:TextBox>
        <asp:Label ID="lblAccMsg" runat="server" ForeColor="Red"></asp:Label><br />
        密碼<asp:TextBox ID="txtPWD" runat="server" TextMode="Password"></asp:TextBox><br />
        確認密碼<asp:TextBox ID="txtChkPWD" runat="server" TextMode="Password"></asp:TextBox><br />
        E-mail<asp:TextBox ID="txtEmail" runat="server" TextMode="Email"></asp:TextBox><br />
        確認E-mail<asp:TextBox ID="txtChkEmail" runat="server" TextMode="Email"></asp:TextBox><br />
        <asp:Label ID="lblPWDMsg" runat="server" ForeColor="Red"></asp:Label><br />
        <asp:Button ID="btnCreate" runat="server" Text="確認送出" OnClick="btnCreate_Click" />
        <asp:Button ID="btnCancel" runat="server" Text="取消" OnClick="btnCancel_Click" />
        <asp:Literal ID="ltlHint" runat="server"></asp:Literal>
    </form>
</body>
</html>
