<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Medicina.aspx.cs" Inherits="WebApplication4.WebForm3" EnableEventValidation="false" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Medicina IPCA HEALTH</title>
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <style>
        body {
            width: 100%;
            margin: 5px;
            min-height:100vh;
            position:relative;
            padding-bottom:60px;
        }

        .table-condensed tr th {
            border: 0px solid #6e7bd9;
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
        footer
        {
            text-align:center;
            width:100%;
            padding:10px;
            position:absolute;
            bottom:0;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="jumbotron bg-primary text-white" style="text-align: center">
            <h1 style="font-family: rockwell">Registo do Paciente - Medicina</h1>
        </div>
        <br />
        <div style="text-align: center">
            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        </div>
        <br />
        <div class="row mx-3">
            <div style="width: 100%; height: 400px; overflow: scroll">
                <asp:GridView runat="server" ID="datagrid1" CssClass="table table-condensed table-hover" Width="100%" OnRowDataBound="OnRowDataBound" OnSelectedIndexChanged="datagrid1_SelectedIndexChanged" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" HorizontalAlign="Left" AutoGenerateColumns="false" ForeColor="#333333" EnableTheming="True">
                    <Columns>
                        <asp:BoundField DataField="Id Consulta" HeaderText="Id Consulta" ItemStyle-Width="150" />
                        <asp:BoundField DataField="Episódio" HeaderText="Episódio" ItemStyle-Width="150" />
                        <asp:BoundField DataField="Data" HeaderText="Data" ItemStyle-Width="150" />
                        <asp:BoundField DataField="Hora" HeaderText="Hora" ItemStyle-Width="150" />
                        <asp:BoundField DataField="Especialidade" HeaderText="Especialidade" ItemStyle-Width="150" />
                        <asp:BoundField DataField="Nome Utente" HeaderText="Nome Utente" ItemStyle-Width="150" />
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
        </div>
        <asp:LinkButton ID="lnkDummy" runat="server"></asp:LinkButton>
        <br />
        <br />
        <div class="row mx-3">
            <div class="jumbotron col-md-6" style="height: 400px;">
                <h4>Dados do Utente</h4>
                <br />
                <div class="form-row">
                    <div class="col-md-6">
                        <label for="nome">Nome</label>
                        <asp:Label ID="nome" runat="server" class="form-control-plaintext border border-primary rounded bg-white text-center" Text="Utente não selecionado"></asp:Label>
                    </div>
                    <div class="form-group col-md-4 offset-1">
                        <label for="datanascimento">Data de Nascimento</label>
                        <asp:Label ID="datanascimento" runat="server" class="form-control-plaintext border border-primary rounded bg-white text-center" Text="Utente não selecionado"></asp:Label>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-5">
                        <label for="nprocesso">Nº Processo</label>
                        <asp:Label ID="nprocesso" runat="server" class="form-control-plaintext border border-primary rounded bg-white text-center" Text="Utente não selecionado"></asp:Label>
                    </div>
                    <div class="col-md-5 offset-1">
                        <label for="genero">Género</label>
                        <asp:Label ID="genero" runat="server" class="form-control-plaintext border border-primary rounded bg-white text-center" Text="Utente não selecionado"></asp:Label>
                    </div>
                </div>
            </div>
            <div class="jumbotron col-md-5 offset-1">
                <h4>Atualização do Estado do Utente</h4>
                <br />
                <div class="row">
                    <asp:Label ID="hospitalizado" runat="server" Text="Esteve recentemente hospitalizado?" class="col-7"></asp:Label>
                    <div class="form-check form-check-inline">
                        <input type="radio" id="hospitalizado1" name="p1" class="form-check-input" value="Sim" />
                        <label class="form-check-label" for="inlineRadio1">Sim</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input type="radio" id="hospitalizado0" name="p1" class="form-check-input" value="Não" />
                        <label class="form-check-label" for="inlineRadio1">Não</label>
                    </div>
                </div>
                <div class="row">
                    <asp:Label ID="operado" runat="server" Text="Foi operado recentemente?" class="col-7"></asp:Label>
                    <div class="form-check form-check-inline">
                        <input type="radio" id="operado1" name="p2" class="form-check-input" value="Sim" />
                        <label class="form-check-label" for="operado1">Sim</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input type="radio" id="operado0" name="p2" class="form-check-input" value="Não" />
                        <label class="form-check-label" for="operado0">Não</label>
                    </div>
                </div>
                <div class="row">
                    <asp:Label ID="consciencia" runat="server" Text="Perdas de consciência, epilepsia?" class="col-7"></asp:Label>
                    <div class="form-check form-check-inline">
                        <input type="radio" id="consciencia1" name="p3" class="form-check-input" value="Sim" />
                        <label class="form-check-label" for="operado1">Sim</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input type="radio" id="consciencia0" name="p3" class="form-check-input" value="Não" />
                        <label class="form-check-label" for="operado0">Não</label>
                    </div>
                </div>
                <div class="row">
                    <asp:Label ID="ouvidos" runat="server" Text="Dores de ouvidos, sinusite, rinite?" class="col-7"></asp:Label>
                    <div class="form-check form-check-inline">
                        <input type="radio" id="ouvidos1" name="p4" class="form-check-input" value="Sim" />
                        <label class="form-check-label" for="ouvidos1">Sim</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input type="radio" id="ouvidos0" name="p4" class="form-check-input" value="Não" />
                        <label class="form-check-label" for="ouvidos0">Não</label>
                    </div>
                </div>
                <div class="row">
                    <asp:Label ID="pulmoes" runat="server" Text="Queixas pulmonares, asma, pneumotórax, tuberculose?" class="col-7"></asp:Label>
                    <div class="form-check form-check-inline">
                        <input type="radio" id="pulmoes1" name="p5" class="form-check-input" value="Sim" />
                        <label class="form-check-label" for="pulmoes1">Sim</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input type="radio" id="pulmoes0" name="p5" class="form-check-input" value="Não" />
                        <label class="form-check-label" for="pulmoes0">Não</label>
                    </div>
                </div>
                <div class="row">
                    <asp:Label ID="digestao" runat="server" Text="Queixas ao nível da digestão, azia, úlcera?" class="col-7"></asp:Label>
                    <div class="form-check form-check-inline">
                        <input type="radio" id="digestao1" name="p6" class="form-check-input" value="Sim" />
                        <label class="form-check-label" for="digestao1">Sim</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input type="radio" id="digestao0" name="p6" class="form-check-input" value="Não" />
                        <label class="form-check-label" for="digestao0">Não</label>
                    </div>
                </div>
                <div class="row">
                    <asp:Label ID="renal" runat="server" Text="Queixas ao nível do sistema renal?" class="col-7"></asp:Label>
                    <div class="form-check form-check-inline">
                        <input type="radio" id="renal1" name="p7" class="form-check-input" value="Sim" />
                        <label class="form-check-label" for="renal1">Sim</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input type="radio" id="renal0" name="p7" class="form-check-input" value="Não" />
                        <label class="form-check-label" for="renal0">Não</label>
                    </div>
                </div>
                <div class="row">
                    <asp:Label ID="ossos" runat="server" Text="Dores nos ossos, coluna, articulações?" class="col-7"></asp:Label>
                    <div class="form-check form-check-inline">
                        <input type="radio" id="ossos1" name="p8" class="form-check-input" value="Sim" />
                        <label class="form-check-label" for="ossos1">Sim</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input type="radio" id="ossos0" name="p8" class="form-check-input" value="Não" />
                        <label class="form-check-label" for="ossos0">Não</label>
                    </div>
                </div>
                <div class="row">
                    <asp:Label ID="pele" runat="server" Text="Manchas na pele?" class="col-7"></asp:Label>
                    <div class="form-check form-check-inline">
                        <input type="radio" id="pele1" name="p9" class="form-check-input" value="Sim" />
                        <label class="form-check-label" for="pele1">Sim</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input type="radio" id="pele0" name="p9" class="form-check-input" value="Não" />
                        <label class="form-check-label" for="pele0">Não</label>
                    </div>
                </div>
                <div class="row">
                    <asp:Label ID="alergia" runat="server" Text="Alergias?" class="col-7"></asp:Label>
                    <div class="form-check form-check-inline">
                        <input type="radio" id="alergia1" name="p10" class="form-check-input" value="Sim" />
                        <label class="form-check-label" for="alergia1">Sim</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input type="radio" id="alergia0" name="p10" class="form-check-input" value="Não" />
                        <label class="form-check-label" for="alergia0">Não</label>
                    </div>
                </div>
                <div class="row">
                    <asp:Label ID="tensao" runat="server" Text="Níveis de tensão arterial descontrolados?" class="col-7"></asp:Label>
                    <div class="form-check form-check-inline">
                        <input type="radio" id="tensao1" name="p11" class="form-check-input" value="Sim" />
                        <label class="form-check-label" for="tensao1">Sim</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input type="radio" id="tensao0" name="p11" class="form-check-input" value="Não" />
                        <label class="form-check-label" for="tensao0">Não</label>
                    </div>
                </div>
                <div class="row">
                    <asp:Label ID="narcotico" runat="server" Text="Consome narcóticos ou estimulantes?" class="col-7"></asp:Label>
                    <div class="form-check form-check-inline">
                        <input type="radio" id="narcotico1" name="p12" class="form-check-input" value="Sim" />
                        <label class="form-check-label" for="narcotico1">Sim</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input type="radio" id="narcotico0" name="p12" class="form-check-input" value="Não" />
                        <label class="form-check-label" for="narcotico0">Não</label>
                    </div>
                </div>
                <div class="row">
                    <asp:Label ID="alcool" runat="server" Text="Possui hábitos alcoólicos?" class="col-7"></asp:Label>
                    <div class="form-check form-check-inline">
                        <input type="radio" id="alcool1" name="p13" class="form-check-input" value="Sim" />
                        <label class="form-check-label" for="alcool1">Sim</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input type="radio" id="alcool0" name="p13" class="form-check-input" value="Não" />
                        <label class="form-check-label" for="alcool0">Não</label>
                    </div>
                </div>
                <div class="row">
                    <asp:Label ID="tabaco" runat="server" Text="Possui hábitos tabágicos?" class="col-7"></asp:Label>
                    <div class="form-check form-check-inline">
                        <input type="radio" id="tabaco1" name="p14" class="form-check-input" value="Sim" />
                        <label class="form-check-label" for="tabaco1">Sim</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input type="radio" id="tabaco0" name="p14" class="form-check-input" value="Não" />
                        <label class="form-check-label" for="tabaco0">Não</label>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mx-3">
            <div class="jumbotron col-md-6">
                <h4>Consultas Anteriores</h4>
                <br />
                <div class="form-group col-md-9">
                    <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="true" Width="212px" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="true">
                        <asp:ListItem Value="0" Text="Relatórios..."></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ControlToValidate="DropDownList1" ErrorMessage="Choose one" Font-Size="X-Large" InitialValue="0" ValidationGroup="whatever"></asp:RequiredFieldValidator>
                </div>
                <br />
                <div>
                    <asp:TextBox ID="TextBox2" runat="server" Height="140px" Width="700px" OnTextChanged="TextBox1_TextChanged" TextMode="MultiLine" ReadOnly="True"></asp:TextBox>
                </div>
            </div>
            <div class="jumbotron col-md-5 offset-1">
                <h4>Dados da Enfermagem</h4>
                <br />
                <asp:TextBox ID="TextBox1" runat="server" OnTextChanged="TextBox1_TextChanged" TextMode="MultiLine" Width="554px" Height="222px" ReadOnly="True"></asp:TextBox>
                <br />
                <div>
                </div>
            </div>
        </div>
        <div class="jumbotron mx-3">
            <h4>Relatório</h4>
            <br />
            <div>
                <asp:TextBox ID="notasmedico" runat="server" class="border border-primary rounded bg-white w-75 overflow-auto navbar navbar-text" Height="150px" TextMode="MultiLine"></asp:TextBox>
            </div>
        </div>
        <div class="ml-3">
            <asp:Button ID="Button3" Visible="true" runat="server" Text="Voltar para Homepage" OnClick="Button3_Click" class="ml-3 btn btn-primary rounded" />
            <asp:Button ID="confirmar" runat="server" Text="Gravar dados" class="btn btn-primary" OnClick="confirmar_Click" />
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
