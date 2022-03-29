<%@ Page Title="" Language="C#" MasterPageFile="~/FrountMain.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="TravelProject.index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">
        <div class="row">
            <asp:Repeater ID="rptCoverImg" runat="server" DataSourceID="PictureSQL" OnItemCommand="rptCoverImg_ItemCommand">
                <ItemTemplate>
                    <div class="col-lg-4 col-md-6 col-sm-12">
                        <a href="<%# Eval("PicturePath")%>"><img typeof="botton" id="imgCover" runat="server" class="img-thumbnail" src='<%# Eval("PicturePath")%>'></a>
                    </div>

                </ItemTemplate>
            </asp:Repeater>
            <asp:SqlDataSource ID="PictureSQL" runat="server" ConnectionString="<%$ ConnectionStrings:TravelConnectionString %>" SelectCommand="
                SELECT Pictures.PicturePath
                FROM Articles
                INNER JOIN Pictures ON Articles.ArticleID = Pictures.ArticleID
                WHERE (Pictures.PictureNumber = 1)
                ORDER BY Articles.CreateTime DESC">
            </asp:SqlDataSource>
        </div>


</div>

    
</asp:Content>