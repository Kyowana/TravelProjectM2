<%@ Page Title="" Language="C#" MasterPageFile="~/BackAdmin/BackAdminMaster.Master" AutoEventWireup="true" CodeBehind="AccountList_backadmin.aspx.cs" Inherits="TravelProject.BackAdmin.AccountList_backadmin" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Button ID="btnDelete" runat="server" Text="刪除" OnClick="btnDelete_Click" /><br />

    <asp:GridView ID="gvList" runat="server" AutoGenerateColumns="false">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:CheckBox ID="chkdel" runat="server" />
                    <asp:HiddenField ID="hfID" runat="server" Value='<%# Eval("UserID")%>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="UserID" HeaderText="代碼" />
            <asp:BoundField DataField="Account" HeaderText="帳號" />

            <asp:TemplateField>
                <ItemTemplate>
                    <a href="login_backadmin.aspx?UserID=<%# Eval("UserID") %>">編輯</a>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>