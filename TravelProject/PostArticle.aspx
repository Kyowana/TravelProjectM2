<%@ Page Title="" Language="C#" MasterPageFile="~/FrountMain.Master" AutoEventWireup="true" CodeBehind="PostArticle.aspx.cs" Inherits="TravelProject.PostArticle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">    
    <h2>發布文章</h2>
    <div>
        地點
        <asp:TextBox ID="txtDistrict" runat="server" placeholder="請輸入地點"></asp:TextBox>
        <asp:Button ID="btnSearchDistrict" runat="server" Text="搜尋" OnClick="btnSearchDistrict_Click" /><br />
        <asp:PlaceHolder ID="plcSearch" runat="server" Visible="false">
            <asp:ListBox ID="ListBox1" runat="server" ></asp:ListBox>
            <asp:Button ID="btnDistrictClick" runat="server" Text="確認地點" OnClick="btnDistrictClick_Click" />
            <%--<div id="map" style="width:100px; height:100px;"></div>--%>
        </asp:PlaceHolder>
            <asp:HiddenField ID="hfLat" runat="server" />
            <asp:HiddenField ID="hfLng" runat="server" />
            <asp:HiddenField ID="hfPlaceID" runat="server" />
    </div>
    <div>
        上傳圖片
        <asp:FileUpload ID="fuPhoto" runat="server" />
    </div>
    <div>
        文章內容
        <asp:TextBox ID="txtContent" runat="server" TextMode="MultiLine"></asp:TextBox>
    </div>
    <div>
        瀏覽權限
        <asp:DropDownList ID="ddlViewLimit" runat="server">
            <asp:ListItem Text="公開" Value="1" Selected="True" ></asp:ListItem>
            <asp:ListItem Text="僅限追蹤者" Value="2"></asp:ListItem>
            <asp:ListItem Text="只限本人" Value="3"></asp:ListItem>
        </asp:DropDownList>
    </div>
    <div>
        留言權限
        <asp:DropDownList ID="ddlCommemtLimit" runat="server">
            <asp:ListItem Text="開放" Value="1" Selected="True" ></asp:ListItem>
            <asp:ListItem Text="僅限追蹤者" Value="2" ></asp:ListItem>
            <asp:ListItem Text="不開放" Value="3"></asp:ListItem>
        </asp:DropDownList>
    </div>
    <asp:Button ID="btnPost" runat="server" Text="發布文章" OnClick="btnPost_Click" />
    <asp:Button ID="btnCancel" runat="server" Text="取消發布" OnClick="btnCancel_Click" />
    <script
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBA9A_Ry9G67EMNHQHYwh3aAE9ubAkaLdU&callback=initMap&v=weekly"
        async></script>
</asp:Content>
