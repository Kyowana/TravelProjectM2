<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TravelProject.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <h2>會員登入 Member Login</h2>
        <p>尚未成為I TABI的會員嗎?</p>
        <p>現在就創立帳號以查看此網站上的受限頁面與內容。</p>
        <p><a href="Regester.aspx">前往註冊頁面→</a></p>
        <asp:Literal ID="ltlMsg" runat="server"></asp:Literal><br />
        帳號<asp:TextBox ID="txtAcc" runat="server"></asp:TextBox><br />
        密碼<asp:TextBox ID="txtPWD" runat="server"></asp:TextBox><br />
        <asp:Button ID="btnLogin" runat="server" Text="登入" OnClick="btnLogin_Click" /><br />
        <p>若您忘記密碼請跟我們聯絡</p>
        <strong>聯絡信箱:</strong><a href="mailto:ITABI@gmail.com">ITABI@gmail.com
    </form>
</body>
</html>
