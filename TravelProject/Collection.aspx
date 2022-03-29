<%@ Page Title="" Language="C#" MasterPageFile="~/FrountMain.Master" AutoEventWireup="true" CodeBehind="Collection.aspx.cs" Inherits="TravelProject.Collection" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>收藏</h2>
    <asp:Repeater ID="rptCollection" runat="server">
        <ItemTemplate>
            <p>
                <a href="ViewArticle.aspx?Post=<%# Eval("ArticleID")  %>" title="">
                    <%# Eval("District")  %>
                </a>
            </p>
        </ItemTemplate>
    </asp:Repeater>
</asp:Content>
