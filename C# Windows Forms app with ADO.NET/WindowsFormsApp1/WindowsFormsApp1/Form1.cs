using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp1
{
    public partial class Form1 : Form
    {
        private SqlConnection connection = new SqlConnection(GetConnectionString());
        private SqlDataAdapter aircraftTable;
        private DataSet dataSetAircrafts;

        public Form1()
        {
            InitializeComponent();
            dataGridViewHubs.SelectionChanged += new EventHandler(LoadChildren);
            LoadParent();
        }

        private void LoadParent()
        {
            SqlDataAdapter hubTable = new SqlDataAdapter("select * from  Hub", GetConnectionString());
            DataSet dataSet = new DataSet();

            hubTable.Fill(dataSet, "Hub");
            dataGridViewHubs.DataSource = dataSet.Tables["Hub"];
        }

        private void LoadChildren(object sender, EventArgs e)
        {
            LoadChildren();
        }

        private void LoadChildren()
        {
            int HId = Convert.ToInt32(dataGridViewHubs.CurrentRow.Cells[0].Value);

            SqlCommand command = new SqlCommand("SELECT * FROM Aircraft WHERE HId=@id", new SqlConnection(GetConnectionString()));
            command.Parameters.AddWithValue("@id", HId);

            aircraftTable = new SqlDataAdapter(command);
            dataSetAircrafts= new DataSet();

            aircraftTable.Fill(dataSetAircrafts, "Hubs");
            dataGridViewAircrafts.DataSource = dataSetAircrafts.Tables["Hubs"];
        }

        private static String GetConnectionString()
        {
            return "Data Source=DESKTOP-7A3NATV\\SQLEXPRESS04;" +
                   "Initial Catalog=lab1DBMS;" +
                   "Integrated Security = true;";
        }

        private void ButtonView_Click(object sender, EventArgs e)
        {

            SqlDataAdapter hubTable = new SqlDataAdapter("select * from Hub", GetConnectionString());
            DataSet dataSet = new DataSet();

            hubTable.Fill(dataSet, "Hubs");//SqlDataAdapter
            dataGridViewHubs.DataSource = dataSet.Tables["Hubs"];

        }


        private void ButtonAdd_Click(object sender, EventArgs e)
        {
            try
            {
                string AircraftName = Convert.ToString(dataGridViewAircrafts.CurrentRow.Cells[1].Value);
                int HId = Convert.ToInt32(dataGridViewAircrafts.CurrentRow.Cells[2].Value);

                SqlCommand command = new SqlCommand("insert into Aircraft values (@id1,@id2)", new SqlConnection(GetConnectionString()));
                command.Parameters.AddWithValue("@id1", AircraftName);
                command.Parameters.AddWithValue("@id2", HId);

                aircraftTable = new SqlDataAdapter(command);
                dataSetAircrafts = new DataSet();

                aircraftTable.Fill(dataSetAircrafts, "Aircraft");
                dataGridViewAircrafts.DataSource = dataSetAircrafts.Tables["Aircraft"];
                LoadChildren();
                MessageBox.Show("Succes!");
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error");
            }
        }

        private void ButtonDelete_Click(object sender, EventArgs e)
        {
            try
            {
                int AId = Convert.ToInt32(dataGridViewAircrafts.CurrentRow.Cells[0].Value);

                SqlCommand command = new SqlCommand("delete FROM Aircraft WHERE AId=@id", new SqlConnection(GetConnectionString()));
                command.Parameters.AddWithValue("@id", AId);

                aircraftTable = new SqlDataAdapter(command);
                dataSetAircrafts = new DataSet();

                aircraftTable.Fill(dataSetAircrafts, "Aircraft");
                dataGridViewAircrafts.DataSource = dataSetAircrafts.Tables["Aircraft"];
                LoadChildren();
                MessageBox.Show("Succes!");
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error");
            }
        }
        
        private void ButtonUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                int AId = Convert.ToInt32(dataGridViewAircrafts.CurrentRow.Cells[0].Value);
                string AircraftName = Convert.ToString(dataGridViewAircrafts.CurrentRow.Cells[1].Value);
                int HId = Convert.ToInt32(dataGridViewAircrafts.CurrentRow.Cells[2].Value);

                SqlCommand command = new SqlCommand("update Aircraft set AircraftName=@id1,HId=@id2  WHERE AId=@id3", new SqlConnection(GetConnectionString()));
                command.Parameters.AddWithValue("@id1", AircraftName);
                command.Parameters.AddWithValue("@id2", HId);
                command.Parameters.AddWithValue("@id3", AId);

                aircraftTable = new SqlDataAdapter(command);
                dataSetAircrafts = new DataSet();

                aircraftTable.Fill(dataSetAircrafts, "Aircraft");
                dataGridViewAircrafts.DataSource = dataSetAircrafts.Tables["Aircraft"];
                LoadChildren();

                MessageBox.Show("Succes!");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
        }


    }
}