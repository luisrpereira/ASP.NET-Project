<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ConsultaDados.aspx.cs" Inherits="WebApplication4.WebForm5" EnableEventValidation="false" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Consulta de dados IPCA Health</title>
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <style type="text/css">
        input[type=text] {
            margin-right: 5px;
            position: relative;
            top: 2px;
            left: 0px;
            width: 537px;
            height: 170px;
        }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.6/jquery.min.js" type="text/javascript"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="Stylesheet" type="text/css" />
    <script type="text/javascript">
        $(function () {
            $("[id*=txtDate]").datepicker({
                showOn: 'button',
                buttonImageOnly: true,
                buttonImage: 'calendar.png'
            });
        });
    </script>
    <style>
        body {
            width: 100%;
            margin: 5px;
            min-height: 100vh;
            position: relative;
            padding-bottom: 60px;
        }

        .table-condensed tr th {
            border: 0px solid #3385ff;
            color: white;
            background-color: #3385ff;
        }

        .table-condensed, .table-condensed tr td {
            border: 0px solid #000;
        }

        tr:nth-child(even) {
            background: #f8f7ff
        }

        tr:nth-child(odd) {
            background: #fff;
        }

        footer {
            text-align: center;
            width: 100%;
            padding: 10px;
            position: absolute;
            bottom: 0;
        }

        .auto-style1 {
            left: 0px;
            width: 229px;
            top: 142px;
            height: 36px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align: center" class="jumbotron bg-primary text-white">
            <h1 style="font-family: rockwell">Histórico de Consultas</h1>
        </div>
        <div class="ml-3">
            <asp:DropDownList ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="True">
                <asp:ListItem Text="Filtrar por data:" Value="0" />
                <asp:ListItem Text="Filtrar por número de utente:" Value="1" />
            </asp:DropDownList>
            <asp:TextBox ID="txtDate" runat="server" ReadOnly="true" Style="border-radius: 4px; width: 150px; height: 25px; background-color: white" class="text-center auto-style1"></asp:TextBox>
            <asp:TextBox ID="TextBox3" runat="server" ReadOnly="false" Style="border-radius: 4px; left: 0px; width: 150px; height: 25px; background-color: white" class="text-center" Visible="false"></asp:TextBox>
        </div>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator1"
            ControlToValidate="TextBox3" runat="server"
            ErrorMessage="Número de utente inválido"
            ValidationExpression="\d+">
        </asp:RegularExpressionValidator>
        <br />
        <div class="row ml-3">
            <asp:Button ID="btnSubmit" runat="server" Text="Filtrar" class="btn btn-outline-primary rounded" Style="margin: 3px;" OnClick="btnSubmit_Click" />
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" class="btn btn-outline-primary rounded" Style="margin: 3px" Text="Unselect/Ver todas" Visible="false" />
        </div>
        <br />
        <div class="row mx-3">
            <div style="width: 100%; height: 400px; overflow: scroll">
                <asp:GridView runat="server" ID="datagrid1" CssClass="table table-condensed table-hover" Width="100%" OnRowDataBound="OnRowDataBound" OnSelectedIndexChanged="datagrid1_SelectedIndexChanged" CellPadding="4" GridLines="None" HorizontalAlign="Left" AutoGenerateColumns="False" ForeColor="#333333">
                    <Columns>
                        <asp:BoundField DataField="Id Consulta" HeaderText="Id Consulta" ItemStyle-Width="150">
                            <ItemStyle Width="150px"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="Episódio" HeaderText="Episódio" ItemStyle-Width="150">
                            <ItemStyle Width="150px"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="Data" HeaderText="Data" ItemStyle-Width="150">
                            <ItemStyle Width="150px"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="Hora" HeaderText="Hora" ItemStyle-Width="150">
                            <ItemStyle Width="150px"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="Especialidade" HeaderText="Especialidade" ItemStyle-Width="150">
                            <ItemStyle Width="150px"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="Nome Utente" HeaderText="Nome Utente" ItemStyle-Width="150">
                            <ItemStyle Width="150px"></ItemStyle>
                        </asp:BoundField>
                    </Columns>
                    <AlternatingRowStyle BackColor="White" />
                    <EditRowStyle BackColor="#2461BF" />
                    <FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#F5F7FB" />
                    <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                    <SortedDescendingCellStyle BackColor="#E9EBEF" />
                    <SortedDescendingHeaderStyle BackColor="#4870BE" />
                </asp:GridView>
                <br />
                <br />
                <br />
                <asp:LinkButton ID="lnkDummy" runat="server"></asp:LinkButton>
            </div>
        </div>
        <br />
        <div class="row justify-content-center">
            <div class="card" style="width: 50%">
                <ul class="list-group list-group-flush">
                    <li class="list-group-item">Nome do Utente:
                    <asp:Label ID="utente" runat="server" class="font-weight-bold"></asp:Label></li>
                    <li class="list-group-item">Enfermeiro responsável:
                    <asp:Label ID="enfermeiro" runat="server" class="font-weight-bold"></asp:Label></li>
                    <li class="list-group-item">Médico responsável:
                    <asp:Label ID="medico" runat="server" class="font-weight-bold"></asp:Label></li>
                </ul>
            </div>
        </div>
        <br />
        <br />
        <div class="row mx-3 justify-content-center">
            <div class="jumbotron col-md-5">
                <h4>Relatório Enfermeiro</h4>
                <br />
                <asp:TextBox ID="TextBox1" runat="server" TextMode="MultiLine" Width="100%" Rows="5" Height="255px"></asp:TextBox>
            </div>
            <br />
            <br />
            <div class="jumbotron col-md-5 offset-1">
                <h4>Relatório Médico</h4>
                <br />
                <asp:TextBox ID="TextBox2" runat="server" TextMode="MultiLine" Width="100%" Rows="5" Height="254px"></asp:TextBox>
            </div>
        </div>
        <br />
        <div class="row justify-content-center">
            <asp:Button ID="Button3" Visible="true" runat="server" Text="Voltar para Homepage" OnClick="Button3_Click" class="btn btn-primary rounded ml-3" />
        </div>
        <br />
        <br />
        <br />
        <footer class="text-white bg-primary">
            <p>Copyright &copy; <%:DateTime.Now.Year %> MC&ML Dynamic Solutions</p>
        </footer>
    </form>
</body>
</html>
