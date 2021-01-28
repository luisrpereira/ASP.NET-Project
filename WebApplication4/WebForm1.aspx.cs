using Newtonsoft.Json.Linq;
using System;
using System.Data;
using System.Data.SQLite;
using System.Linq;
using System.Net.Http;
using System.Drawing;
using System.Web.UI.WebControls;

namespace WebApplication4
{
    
    public partial class WebForm1 : System.Web.UI.Page
    {
        

        private static SQLiteConnection sqliteConnection;

        private static SQLiteConnection DbConnection()
        {
            sqliteConnection = new SQLiteConnection(@"Data Source=C:\Users\Daniel\Desktop\WebApplication4\WebApplication4\isc.db");
            sqliteConnection.Open();
            return sqliteConnection;
        }

        public async void RestToDbMedicos()
        {
            WebService1 client = new WebService1();
            string uri = "https://trabalhofinalisc.azurewebsites.net/api/Medicos";
            using (var cliente = new HttpClient())
            {
                using (var resposta = await cliente.GetAsync(uri))
                {
                    if (resposta.IsSuccessStatusCode)
                    {
                        var JsonString = resposta.Content.ReadAsStringAsync();
                        JArray arrayMedicos = JArray.Parse(await JsonString);


                        try
                        {
                            using (var cmd = DbConnection().CreateCommand())
                            {


                                for (int i = 0; i < arrayMedicos.Count(); i++)

                                {
                                    if (client.MedicoNotinDB(arrayMedicos[i]["NOrdem"].ToString()) == true)
                                    {






                                        cmd.CommandText = "INSERT INTO Medico (NOrdem,Nome,Espc) VALUES (@NOrdem,@Nome,@Espc)";
                                        cmd.Parameters.AddWithValue("@NOrdem", arrayMedicos[i]["NOrdem"]);
                                        cmd.Parameters.AddWithValue("@Nome", arrayMedicos[i]["Nome"]);
                                        cmd.Parameters.AddWithValue("@Espc", arrayMedicos[i]["Especialidade"]);
                                        ;
                                        cmd.ExecuteNonQuery();
                                    }
                                }


                            }
                        }
                        catch (Exception ex)
                        {
                            throw ex;
                        }
                    }

                }

            }



        }

        public async void RestToDEnfermeiros()
        {
            WebService1 client = new WebService1();
            string uri = "https://trabalhofinalisc.azurewebsites.net/api/Enfermeiros";
            using (var cliente = new HttpClient())
            {
                using (var resposta = await cliente.GetAsync(uri))
                {
                    if (resposta.IsSuccessStatusCode)
                    {
                        var JsonString = resposta.Content.ReadAsStringAsync();
                        JArray arrayEnfermeiros = JArray.Parse(await JsonString);


                        try
                        {
                            using (var cmd = DbConnection().CreateCommand())
                            {


                                for (int i = 0; i < arrayEnfermeiros.Count(); i++)

                                {
                                    if (client.EnfermeiroNotinDB(arrayEnfermeiros[i]["NMec"].ToString()) == true)
                                    {






                                        cmd.CommandText = "INSERT INTO Enfermeiro (NMec,Nome) VALUES (@NMec,@Nome)";
                                        cmd.Parameters.AddWithValue("@NMec", arrayEnfermeiros[i]["NMec"]);
                                        cmd.Parameters.AddWithValue("@Nome", arrayEnfermeiros[i]["Nome"]);

                                        cmd.ExecuteNonQuery();
                                    }
                                }


                            }
                        }
                        catch (Exception ex)
                        {
                            throw ex;
                        }
                    }

                }

            }



        }

        public void CriarTabela(string query)
        {
            using (var cmd = DbConnection())
            {
                SQLiteDataAdapter sqlDa = new SQLiteDataAdapter(query, cmd);
                DataTable dtbl = new DataTable();
                sqlDa.Fill(dtbl);
                
                
                dtbl.Columns["Id_Esp"].ColumnName = "Id Consulta";
                dtbl.Columns["Ep"].ColumnName = "Episódio";
                
                
                dtbl.Columns["Esp"].ColumnName = "Especialidade";
                
                dtbl.Columns["Nome"].ColumnName= "Nome Utente";
                
                datagrid1.DataSource = dtbl;
                datagrid1.DataBind();

            }
        }

        private void ListBoxEnf()
        {
            using (var cmd = DbConnection())
            {
                SQLiteDataAdapter adpt = new SQLiteDataAdapter("Select * From Enfermeiro", cmd);

                DataSet myDataSet = new DataSet();

                adpt.Fill(myDataSet, "Enfermeiro");

                DataTable myDataTable = myDataSet.Tables[0];

                DataRow tempRow = null;



                foreach (DataRow tempRow_Variable in myDataTable.Rows)

                {

                    tempRow = tempRow_Variable;

                    ListBox1.Items.Add((tempRow["Nmec"].ToString() + " (" + tempRow["Nome"].ToString() + ")"));
                }
            }
        }

        private void ListBoxMed(string esp) 
        {
            using (var cmd = DbConnection())
            {
                SQLiteDataAdapter adpt = new SQLiteDataAdapter("Select * From Medico where Espc=\""+esp+"\"", cmd);

                DataSet myDataSet = new DataSet();

                adpt.Fill(myDataSet, "Medico");

                DataTable myDataTable = myDataSet.Tables[0];

                DataRow tempRow = null;



                foreach (DataRow tempRow_Variable in myDataTable.Rows)

                {

                    tempRow = tempRow_Variable;

                    ListBox2.Items.Add((tempRow["NOrdem"].ToString() + " (" + tempRow["Nome"].ToString() + ")"));
                }
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            
            WebService1 client = new WebService1();
            client.ReadToDB();
            RestToDbMedicos();
            RestToDEnfermeiros();
            if (!this.IsPostBack) CriarTabela("SELECT Id_Esp,EP,Data,Hora,Esp,Nome FROM Consulta inner join Utente on Consulta.Processo = Utente.Processo where Estado=\"Agendada\"");




        }

        protected void OnRowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(datagrid1, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Click to select this row.";
                e.Row.Cells[2].Text = Convert.ToDateTime(e.Row.Cells[2].Text).ToString("dd, MMM yyyy");
                e.Row.Cells[3].Text = Convert.ToDateTime(e.Row.Cells[3].Text).ToString("HH:mm");

                


            }

        }

        protected void datagrid1_SelectedIndexChanged(object sender, EventArgs e)
        {

            foreach (GridViewRow row in datagrid1.Rows)
            {
                if (row.RowIndex == datagrid1.SelectedIndex)
                {
                    row.BackColor = ColorTranslator.FromHtml("#A1DCF2");
                    row.ToolTip = string.Empty;
                    Label1.Text = "Consulta selecionada: " + row.Cells[0].Text.ToString();
                    Button1.Visible = true;
                    ListBox1.Items.Clear();
                    ListBoxEnf();
                    ListBox2.Items.Clear();
                    ListBoxMed(row.Cells[4].Text.ToString());
                }
                else
                {
                    row.BackColor = ColorTranslator.FromHtml("#FFFFFF");
                    row.ToolTip = "Click to select this row.";
                }
            }

        }

        protected void btnLoad_Click(object sender, EventArgs e)
        {

        }

        /* protected void Consulta_SelectedIndexChanged(object sender, EventArgs e)
         {
             Label1.Text = Consulta.SelectedRow.Cells[2].Text;
         }*/

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow row in datagrid1.Rows)
            {
                if (row.RowIndex == datagrid1.SelectedIndex)
                {
                    datagrid1.SelectedIndex = -1;
                    Label1.Text = "Sem consulta selecionada";
                    
                }
            }
            string dt = Request.Form[txtDate.UniqueID];
            //ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Selected Date: " + dt + "');", true);
            if (dt != "")
            {
                Button1.Visible = true;
                string mes = dt.Split('/')[0];
                string dia = dt.Split('/')[1];
                string ano = dt.Split('/')[2];
                CriarTabela("SELECT Id_Esp,EP,Data,Hora,Esp,Nome FROM Consulta inner join Utente on Consulta.Processo = Utente.Processo where Data= '" + ano + "-" + mes + "-" + dia + "' AND Estado=\"Agendada\"");
               
                
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            CriarTabela("SELECT Id_Esp,EP,Data,Hora,Esp,Nome FROM Consulta inner join Utente on Consulta.Processo = Utente.Processo where Estado=\"Agendada\"");
            foreach (GridViewRow row in datagrid1.Rows)
            {
                if (row.RowIndex == datagrid1.SelectedIndex)
                {
                    datagrid1.SelectedIndex = -1;
                    Label1.Text = "Sem consulta selecionada";
                }
            }
        }

        protected void ListBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

            
            if (ListBox2.SelectedIndex != -1 && ListBox1.SelectedIndex != -1)
            {
                Label2.Text = Label1.Text + " Enfermeiro: " + ListBox1.SelectedValue.ToString() + " Medico: " + ListBox2.SelectedValue.ToString();
                Button2.Visible = true;
                Label2.Visible = true;
            }
        }
        protected void ListBox2_SelectedIndexChanged(object sender, EventArgs e)
        {
            
            if (ListBox2.SelectedIndex != -1 && ListBox1.SelectedIndex != -1)
            {
                Label2.Text = Label1.Text + " Enfermeiro: " + ListBox1.SelectedValue.ToString() + " Medico: " + ListBox2.SelectedValue.ToString();
                Button2.Visible = true;
                Label2.Visible = true;
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            using (var cmd = DbConnection().CreateCommand())
            {
                foreach (GridViewRow row in datagrid1.Rows)
                {
                    if (row.RowIndex == datagrid1.SelectedIndex)
                    {

                        cmd.CommandText = "UPDATE Consulta SET Estado=@es, Enf=@enf, Med=@med WHERE Id_Esp = '" + row.Cells[0].Text.ToString() + "'";

                        cmd.Parameters.AddWithValue("@Es", "Enf");
                        cmd.Parameters.AddWithValue("@enf", ListBox1.SelectedValue.ToString().Split('(')[0]);
                        cmd.Parameters.AddWithValue("@med", ListBox2.SelectedValue.ToString().Split('(')[0]);

                        cmd.ExecuteNonQuery();
                    }
                }
            }
        }
    }
}