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
    public partial class WebForm4 : System.Web.UI.Page
    {
        private static SQLiteConnection sqliteConnection;

        private static SQLiteConnection DbConnection()
        {
            sqliteConnection = new SQLiteConnection(@"Data Source=C:\Users\Luís\Desktop\WebApplication4\WebApplication4\isc.db");
            sqliteConnection.Open();
            return sqliteConnection;
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
                    
                    using (var cmd1 = DbConnection().CreateCommand())
                    {
                        
                            cmd1.CommandText = "Select count(*) from Consulta where Estado='Enf' and Enf=" + tempRow["Nmec"].ToString();
                           string  x = cmd1.ExecuteScalar().ToString();
                        
                        
                          
                        DropDownList1.Items.Add((tempRow["Nmec"].ToString() + " (" + tempRow["Nome"].ToString()+ ") (" + x + ") "));
                    }
                    }
            }
        }
        private void ListBoxMed()
        {
            using (var cmd = DbConnection())
            {
                SQLiteDataAdapter adpt = new SQLiteDataAdapter("Select * From Medico", cmd);

                DataSet myDataSet = new DataSet();

                adpt.Fill(myDataSet, "Enfermeiro");

                DataTable myDataTable = myDataSet.Tables[0];

                DataRow tempRow = null;



                foreach (DataRow tempRow_Variable in myDataTable.Rows)

                {
                    tempRow = tempRow_Variable;
                    using (var cmd1 = DbConnection().CreateCommand())
                    {

                        cmd1.CommandText = "SELECT count(*) from Consulta where Estado = 'Med' and Med =" + tempRow["NOrdem"].ToString();
                        string x =cmd1.ExecuteScalar().ToString();
                        DropDownList2.Items.Add((tempRow["NOrdem"].ToString() + " (" + tempRow["Nome"].ToString() + ") (" + x + ") " ));

                    }
                }
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            
            ListBoxEnf();
            ListBoxMed();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("Receção.aspx");
        }

        protected void Button2_Click(object sender, EventArgs e)
        {

            Session["Enf"] = DropDownList1.SelectedValue.ToString();
            Response.Redirect("Enfermagem.aspx");
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            Session["Med"] = DropDownList2.SelectedValue.ToString();
            Response.Redirect("Medicina.aspx");
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            Response.Redirect("ConsultaDados.aspx");
        }
    }
}