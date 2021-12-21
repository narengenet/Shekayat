<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="loginxyzroosta.aspx.cs" Inherits="Shekayat.loginxyzroosta" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="modal modal-signin position-static d-block bg-white py-2" tabindex="-1" role="dialog" id="modalSignin">
        <div class="modal-dialog" role="document">
            <div class="modal-content rounded-5 shadow">
                <div class="modal-header p-5 pb-4 border-bottom-0">
                    <!-- <h5 class="modal-title">Modal title</h5> -->
                    <h2 class="fw-bold mb-0">ورود مدیران <span runat="server" id="txtMobile"></span></h2>
                    <button type="button" class="btn-admin" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body p-5 pt-0">
                    <div class="w-100 mb-2 login-section">
                        <asp:Label ID="Label5" runat="server" AssociatedControlID="mobile" CssClass="form-label" Text="شماره تلفن همراه"></asp:Label>
                        <asp:TextBox ID="mobile" runat="server" class="form-control"></asp:TextBox>

                        <div runat="server" id="usernameErr" class="invalid-feedback">
                            شماره تلفن همراه وارد شده مجاز نیست.
                        </div>
                        <asp:Button ID="Button1" runat="server" CssClass="form-control btn-success mt-3" Text="ادامه" OnClick="Button1_Click" />
                    </div>
                    <div class="w-100 mb-2 expire-section d-none">
                        <label class="form-label text-danger" >دفعات مجاز ورود با شماره تلفن همراه شما به اتمام رسید. لطفا بعدا محددا تلاش کنید.</label>
                    </div>
                </div>
            </div>
        </div>
    </div>









    <script>
        var expired = false;
        $(document).ready(function () {
            if (getUrlVars().verifier == 'false') {
                $('.toast-header').addClass('bg-danger');
                $('#toasttitle').addClass('text-white');
                $("#toasttitle").html('ورود ناموفق');
                $('#toastbody').html('دفعات مجاز ورود با کد پیامکی به اتمام رسید. لطفا کمی بعد محددا تلاش کنید.');
                $('.toast').toast('show');
            }
            if (expired) {
                Expired();
            }
        });

        function Expire() {
            expired = true;
        }

        function Expired() {
            $('.toast-header').addClass('bg-danger');
            $('#toasttitle').addClass('text-white');
            $("#toasttitle").html('هشدار امنیتی');
            $('#toastbody').html('دفعات مجاز ورود با شماره تلفن همراه شما به اتمام رسید. لطفا بعدا محددا تلاش کنید.');
            $('.toast').toast('show');

            $(".login-section").hide();
            $(".expire-section").removeClass("d-none");

        }
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
