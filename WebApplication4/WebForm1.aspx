<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Async="true" Inherits="WebApplication4.WebForm1" EnableEventValidation="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <title>Receção IPCA Health</title>
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <style type="text/css">
        input[type=text] {
            margin-right: 5px;
            position: relative;
            top: -2px
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
    </style>
</head>
<body>
    <form id="form2" runat="server">
        <div style="text-align: center" class="jumbotron bg-primary text-white">
            <h1 style="font-family: rockwell">Receção</h1>
        </div>
        <hr />
        <br />
        <div>
            <asp:TextBox ID="txtDate" runat="server" ReadOnly="true" Style="border-radius: 4px;" class="ml-3 text-center"></asp:TextBox>
        </div>
        <br />
        <div class="row ml-3">
            <asp:Button ID="btnSubmit" runat="server" Text="Selecionar Data" class="btn btn-outline-primary rounded" Style="margin: 3px;" OnClick="btnSubmit_Click" />
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" class="btn btn-outline-primary rounded" Style="margin: 3px" Text="Ver todas Consultas" Visible="false" />
        </div>
        <br />
        <div class="row">
            <div style="width: 75%; height: 400px; overflow: scroll" class="ml-3">
                <asp:GridView runat="server" ID="datagrid1" CssClass="table table-condensed table-hover ml-3" Width="100%" OnRowDataBound="OnRowDataBound" OnSelectedIndexChanged="datagrid1_SelectedIndexChanged" CellPadding="4" GridLines="None" HorizontalAlign="Left" AutoGenerateColumns="False" ForeColor="#333333">
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
            </div>
            <div style="width: 20%">
                <div>
                    <asp:Label ID="listaenfermeiros" runat="server" Text="Lista Enfermeiros" class="offset-1"></asp:Label>
                </div>
                <div style="width: 100%; height: 200px" class="offset-1">
                    <asp:ListBox ID="ListBox1" Visible="true" class="form-control" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ListBox1_SelectedIndexChanged" Rows="5"></asp:ListBox>
                </div>
                <div>
                    <asp:Label ID="listamedicos" runat="server" Text="Lista Médicos" class="offset-1"></asp:Label>
                </div>
                <div style="width: 100%; height: 200px" class="offset-1">
                    <asp:ListBox ID="ListBox2" Visible="true" class="form-control" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ListBox2_SelectedIndexChanged" Rows="5"></asp:ListBox>
                </div>
            </div>
        </div>
        <asp:Label ID="Label1" runat="server" Text="Sem consulta selecionada" class="ml-3"></asp:Label>
        <br />
        <br />
        <div class="card ml-3" style="width:40%">
            <ul class="list-group list-group-flush">
                <li class="list-group-item">Utente: <asp:Label ID="utente" runat="server" Text="Horácio" class="font-weight-bold"></asp:Label></li>
                <li class="list-group-item">Enfermeiro: <asp:Label ID="enfermeiro" runat="server" Text="Armindo" class="font-weight-bold"></asp:Label></li>
                <li class="list-group-item">Médico: <asp:Label ID="medico" runat="server" Text="Dr.Fagundes" class="font-weight-bold"></asp:Label></li>
            </ul>
        </div>
        <br />
        <asp:Label ID="Label2" Visible="false" runat="server" Text="Label" class="ml-3"></asp:Label>
        <br />
        <asp:LinkButton ID="lnkDummy" runat="server"></asp:LinkButton>
        <br />
        <asp:Button ID="Button2" Visible="false" runat="server" Text="Avançar" OnClick="Button2_Click" class="ml-3 btn btn-primary rounded" />
        <hr />
        <footer class="text-white bg-primary">
            <p>&nbsp &copy; <%:DateTime.Now.Year %> - developed by MC&ML Dynamic Solutions</p>
        </footer>
    </form>
</body>
</html>
