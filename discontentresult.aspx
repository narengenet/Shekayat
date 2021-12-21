<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="discontentresult.aspx.cs" Inherits="Shekayat.discontentresult" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row g-3 align-content-center">
        <div class="col-sm-12">
            <h1 class="text-success referal-result">شکایت شما با موفقیت ثبت شد.</h1>
        </div>
        <div class="col-sm-12">
            
            <asp:Label ID="Label1" runat="server" CssClass="form-label" Text="کد پیگیری شما: "></asp:Label>
            <asp:Label ID="lblToken" runat="server" CssClass="form-label font-weight-bold referal-code"></asp:Label>
            
        </div>
        <div class="col-sm-12">
            پس از بررسی و ارسال پاسخ، از طریق پیامک به شما اطلاع رسانی خواهد شد.
        </div>
        <div class="col-sm-12">
            <asp:LinkButton runat="server" PostBackUrl="~/Default.aspx" CssClass="btn-info p-2">بازگشت به خانه</asp:LinkButton>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
