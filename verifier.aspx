<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="verifier.aspx.cs" Inherits="Shekayat.verifier" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="modal modal-signin position-static d-block bg-white py-2" tabindex="-1" role="dialog" id="modalSignin">
        <div class="modal-dialog" role="document">
            <div class="modal-content rounded-5 shadow">
                <div class="modal-header p-5 pb-4 border-bottom-0">
                    <!-- <h5 class="modal-title">Modal title</h5> -->
                    <h2 class="fw-bold mb-0">فعال سازی ورود با شماره همراه <span runat="server" id="txtMobile"></span></h2>
                    <button type="button" class="btn-sms" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body p-5 pt-0">
                    <asp:Label class="text-danger d-none" ID="errorToken" runat="server" Text="کد چهاررقمی وارد شده اشتباه است."></asp:Label>


                    <div class="form-floating mb-3 pb-1">
                        <input type="text" class="form-control rounded-4 text-center font-em-3 pb-4 mb-0" id="floatingInput" runat="server" onkeypress="return isNumber(event)" maxlength="4">
                        <label for="floatingInput">کد چهار رقمی پیامکی</label>
                    </div>
                    <asp:Button ID="Button1" runat="server" CssClass="w-100 mb-2 btn btn-lg rounded-4 btn-primary" Text="ورود" OnClick="Button1_Click" />

                    <small class="text-muted">چنانچه هنوز کدی برای شما پیامک نشده است لطفا کمی منتظر بمانید</small>
<%--                    <hr class="my-4">
                    <h2 class="fs-5 fw-bold mb-3">یا مجددا تلاش کنید</h2>
                    <div class="d-flex flex-row-reverse w-100">
                        <button class="w-60 py-2 mb-2 btn btn-outline-warning rounded-4" type="submit">
                            <svg class="bi me-1" width="16" height="16">
                                <use xlink:href="#twitter"></use></svg>
                            ارسال مجدد کد چهار رقمی
                        </button>
                    </div>--%>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <script type="text/javascript">     
        function isNumber(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if ((charCode > 31 && charCode < 48) || charCode > 57) {
                return false;
            }
            return true;
        }
    </script>
</asp:Content>
