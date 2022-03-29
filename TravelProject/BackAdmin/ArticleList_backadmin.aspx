<%@ Page Title="" Language="C#" MasterPageFile="~/BackAdmin/BackAdminMaster.Master" AutoEventWireup="true" CodeBehind="ArticleList_backadmin.aspx.cs" Inherits="TravelProject.BackAdmin.ArticleList_backadmin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Button runat="server" ID="btnDelete" Text="刪除" OnClick="btnDelete_Click" /><br />

    <asp:TextBox ID="txtkeyword" runat="server" placeHolder="請輸入搜尋文字"></asp:TextBox>
    <asp:Button ID="btnSearch" runat="server" Text="搜尋" OnClick="btnSearch_Click" /><br />

    <asp:GridView ID="gvList" runat="server" AutoGenerateColumns="false">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:CheckBox ID="ckbDel" runat="server" />
                    <asp:HiddenField ID="hfID" runat="server" Value='<%# Eval("ArticleID")%>' />

                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="UserID" HeaderText="會員代號"/>
            <asp:BoundField DataField="ArticleContent" HeaderText="文章內文" />
            <asp:BoundField DataField="CreateDate" HeaderText="發佈日期" />
            <asp:TemplateField>
                <ItemTemplate>
                        <p>
                         <a href="ViewArticle.aspx?Post=<%# Eval("ArticleID")  %>" title=""> <%# Eval("ArticleContent")  %> 
                          </a>
                         </p>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:PlaceHolder runat="server" ID="plcEmpty" Visible="false">
        <p>尚未有資料</p>
    </asp:PlaceHolder>
</asp:Content>