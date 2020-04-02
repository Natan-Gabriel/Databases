namespace WindowsFormsApp1
{
    partial class Form1
    {


        private System.Windows.Forms.DataGridView dataGridViewAircrafts;
        private System.Windows.Forms.DataGridView dataGridViewHubs;
        private System.Windows.Forms.Label labelHubs;
        private System.Windows.Forms.Label labelAircrafts;
        private System.Windows.Forms.Button buttonView;
        private System.Windows.Forms.Button buttonAdd;
        private System.Windows.Forms.Button buttonDelete;
        private System.Windows.Forms.Button buttonUpdate;

        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        /*private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Text = "Form1";
        }*/
        private void InitializeComponent()
        {
            this.dataGridViewAircrafts = new System.Windows.Forms.DataGridView();
            this.dataGridViewHubs = new System.Windows.Forms.DataGridView();
            this.labelHubs = new System.Windows.Forms.Label();
            this.labelAircrafts = new System.Windows.Forms.Label();
            this.buttonView = new System.Windows.Forms.Button();
            this.buttonAdd = new System.Windows.Forms.Button();
            this.buttonDelete = new System.Windows.Forms.Button();
            this.buttonUpdate = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridViewAircrafts)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridViewHubs)).BeginInit();
            this.SuspendLayout();
            // 
            // dataGridViewAircrafts
            // 

            this.dataGridViewAircrafts.Location = new System.Drawing.Point(12, 64);
            this.dataGridViewAircrafts.Name = "dataGridViewAircrafts";
            this.dataGridViewAircrafts.RowTemplate.Height = 24;
            this.dataGridViewAircrafts.Size = new System.Drawing.Size(920, 652);
            // 
            // dataGridViewHubs
            // 

            this.dataGridViewHubs.Location = new System.Drawing.Point(954, 64);
            this.dataGridViewHubs.Name = "dataGridViewHubs";
            this.dataGridViewHubs.RowTemplate.Height = 24;
            this.dataGridViewHubs.Size = new System.Drawing.Size(393, 652);
            // 
            // labelHubs
            // 
            
            this.labelHubs.Location = new System.Drawing.Point(1000, 28);
            this.labelHubs.Name = "Hubs";
            this.labelHubs.Size = new System.Drawing.Size(168, 17);
            this.labelHubs.Text = "Hubs";
            // 
            // labelAircrafts
            // 
            
            this.labelAircrafts.Location = new System.Drawing.Point(70, 28);
            this.labelAircrafts.Name = "Aircrafts at selected hub";
            this.labelAircrafts.Size = new System.Drawing.Size(92, 17);
            this.labelAircrafts.Text = "Aircrafts (Child)";
            // 
            // buttonView
            // 
            this.buttonView.Location = new System.Drawing.Point(1173, 18);
            this.buttonView.Name = "buttonView";
            this.buttonView.Size = new System.Drawing.Size(180, 37);
            this.buttonView.Text = "View all hubs(parent)";
            this.buttonView.Click += new System.EventHandler(this.ButtonView_Click);
            // 
            // buttonDelete
            //

            this.buttonAdd.Location = new System.Drawing.Point(200, 18);
            this.buttonAdd.Name = "buttonAdd";
            this.buttonAdd.Size = new System.Drawing.Size(180, 37);
            this.buttonAdd.Text = "Add an aircraft";
            this.buttonAdd.Click += new System.EventHandler(this.ButtonAdd_Click);

            // buttonDelete
            //

            this.buttonDelete.Location = new System.Drawing.Point(428, 18);
            this.buttonDelete.Name = "buttonDelete";
            this.buttonDelete.Size = new System.Drawing.Size(180, 37);
            this.buttonDelete.Text = "Delete selected aircraft";
            this.buttonDelete.Click += new System.EventHandler(this.ButtonDelete_Click);
            // 
            // buttonUpdate
            // 
            this.buttonUpdate.Location = new System.Drawing.Point(731, 18);
            this.buttonUpdate.Name = "buttonUpdate";
            this.buttonUpdate.Size = new System.Drawing.Size(180, 36);
            this.buttonUpdate.Text = "Update";
            this.buttonUpdate.Click += new System.EventHandler(this.ButtonUpdate_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1359, 728);
            this.Controls.Add(this.buttonView);
            this.Controls.Add(this.buttonAdd);
            this.Controls.Add(this.buttonDelete);
            this.Controls.Add(this.buttonUpdate);
            
            this.Controls.Add(this.labelAircrafts);
            this.Controls.Add(this.labelHubs);
            this.Controls.Add(this.dataGridViewHubs);
            this.Controls.Add(this.dataGridViewAircrafts);
            this.Name = "Form1";
            this.Text = "Form1";
            ((System.ComponentModel.ISupportInitialize)(this.dataGridViewAircrafts)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridViewHubs)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }
        #endregion



    }
}

