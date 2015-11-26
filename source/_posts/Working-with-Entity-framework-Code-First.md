title: Working with Entity framework (Code First)
tags:

  - c#
  - entity framework
  - aspnet
permalink: orm-showdown-dapper-vs-entityframework-part-1
id: 40
updated: '2015-02-09 10:04:26'
date: 2014-11-16 15:06:58
---

[Entity Framework](http://msdn.microsoft.com/en-us/data/ef.aspx) is the ORM that has been pushed by the MSFT giant over the last few years to the .NET community.
<!-- more -->
## Working with Entity Framework

Entity framework comes in two flavors `Code First` and `Database First`

Code first is MSFT's way of using Entity Framework to scaffold your database from code. This huge feature allows you, the developer, to not write any SQL to create the database.

#### Database Philosophy

MSFT's tutorials with EF really push you toward having Entity Framework create the database, and use some `Linq` tricks to generate all the SQL. Now one of the huge downsites to this philosophy is that there is no stored procedures you can magically change to *fix* any database performance issues. This means any changes to alter the way you query should be done with a new deployment of the application. This also means that you will not have the oppertunity to profile any sprocs, and try to gain CPU cycles in the database. If you are looking for high performance I would look toward using [Dapper](https://github.com/StackExchange/dapper-dot-net) instead. The benefit for using EF, is honestly developer time. You can get started much faster using Entity Framework's code first approach.


#### Getting Started with Code First

To put it simply make a class(or classes) and make a context which contains a `set` of those classes. Make sure you **first** add the entity framework [nuget package](https://www.nuget.org/packages/entityframework).


```csharp

    public class Employee
    {
        [Key]
        public int Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }

    }
    public class SomethingElse
    {
        [Key]
        public int Id { get; set; }
        public string Yup { get; set; }
        public string ImCool { get; set; }

    }
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext()
            : base("DefaultConnection")
        {
        }
        public DbSet<Employee> EmployeesetSet { get; set; }
        public DbSet<SomethingElse> SomethingElseSet { get; set; }


    }



```

then in the package console window type `enable-migrations` this will create a migrations folder and a configuration. If you wish your code to auto create the database on start, then add ` AutomaticMigrationsEnabled = true;` to the `Configurations.cs` file that is created.

Then simply type `add-migration` give it a name, and the migration will look something like the following.

```csharp


    public partial class one : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Employees",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        FirstName = c.String(),
                        LastName = c.String(),
                    })
                .PrimaryKey(t => t.Id);

            CreateTable(
                "dbo.SomethingElses",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Yup = c.String(),
                        ImCool = c.String(),
                    })
                .PrimaryKey(t => t.Id);

        }

        public override void Down()
        {
            DropTable("dbo.SomethingElses");
            DropTable("dbo.Employees");
        }
    }


```

You can then type update-database, and it will update the database. Note: the connection string is defined in the web config, and is declared on the following line.

YourDbContext.cs

`public ApplicationDbContext()
            : base("DefaultConnection")`

Web.config:

```
< connectionStrings>
    < add name="DefaultConnection" connectionString="Data Source=(LocalDb)\v11.0;AttachDbFilename=|DataDirectory|\aspnet-WebApplication11-20141116030948.mdf;Initial Catalog=aspnet-WebApplication11-20141116030948;Integrated Security=True"
      providerName="System.Data.SqlClient" />
  </ connectionStrings>

```

  See we have a connectionstring in our webconfig called DefaultConnection, and using our base constructor we are naming that as our connection.
