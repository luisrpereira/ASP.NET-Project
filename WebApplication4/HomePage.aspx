<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="WebApplication4.WebForm4" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <title>Home Page IPCA Health</title>
    <style>
        body {
            min-height: 100vh;
            position: relative;
            padding-bottom: 60px;
        }

        footer {
            text-align: center;
            width: 100%;
            padding: 10px;
            position: absolute;
            bottom: 0;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="header jumbotron bg-primary text-white" style="text-align: center">
            <h1 style="font-family: rockwell">IPCA Health</h1>
            <h4>A sua saúde é o mais importante para nós</h4>
        </div>
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <div class="row justify-content-center">
            <img src="receçao.jpg" alt="Receção" width="200" height="200" style="border-radius: 50%; border: 1px solid #ddd" />
            <img src="enfermagem.jpg" alt="Enfermagem" width="200" height="200" class="offset-1" style="border-radius: 50%; border: 1px solid #ddd" />
            <img src="medico.jpg" alt="Médico" width="200" height="200" class="offset-1" style="border-radius: 50%; border: 1px solid #ddd" />
            <img src="dados.jpg" alt="Dados" width="200" height="200" class="offset-1" style="border-radius: 50%; border: 1px solid #ddd" />
        </div>
        <br />
        <div class="row justify-content-center">
            <div>
                <asp:Button ID="Button1" runat="server" Text="Receção" class="btn-primary rounded" Width="200px" OnClick="Button1_Click" />
            </div>
            <div class="offset-1">
                <asp:Button ID="Button2" runat="server" Text="Consulta Enfermagem" class="btn-primary rounded" Width="200px" OnClick="Button2_Click" />
                <br />
                <br />
                <asp:DropDownList ID="DropDownList1" runat="server" Width="200px" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged"></asp:DropDownList>
            </div>
            <div class="offset-1">
                <asp:Button ID="Button3" runat="server" Text="Consulta Médica" class="btn-primary rounded" Width="200px" OnClick="Button3_Click" />
                <br />
                <br />
                <asp:DropDownList ID="DropDownList2" Width="200px" runat="server"></asp:DropDownList>
            </div>
            <div class="offset-1">
                <asp:Button ID="Button4" runat="server" Text="Histórico de consultas" class="btn-primary rounded" Width="200px" OnClick="Button4_Click" />
            </div>
        </div>
        <br />
        <br />
        <footer class="text-white bg-primary">
            <p>Copyright &copy; <%:DateTime.Now.Year %> MC&ML Dynamic Solutions</p>
        </footer>
    </form>
</body>
</html>
