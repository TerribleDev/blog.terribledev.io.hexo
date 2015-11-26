title: 'Using Action<>, Func<> to hide using statements'
tags:

  - c#
  - Tutorial
  - generics
permalink: using-action-func-to-hide-using-statements
id: 35
updated: '2014-07-06 13:18:17'
date: 2014-07-06 03:56:02
---

Ok so to give you all some background. I always write my data access with a repository pattern in c#. Now I often use dapper, however I'd guess this problem would also apply with Entity framework.
<!-- more -->
Everytime I start writing my database access I always start with something like...

```csharp

public void InsertSomething(string something)
{
	using(var x = new SqlConnection())
    {
    }
}


```

...and honestly pretty soon I am living in `using` statement hell.

Now I tried to mitigate this in the past with IDisposable, but when I'd do some weak reference dependancy injection magic things usually got borked. I like to see using statements in action. I like know that things are getting disposed. However the verbosity, and sheer pain of it makes me want to puke. So one day I came up with the following.


<script src="https://gist.github.com/tparnell8/f248f559dd89c8dc4b42.js"></script>
[Gist Link](https://gist.github.com/f248f559dd89c8dc4b42.git)

## Ok? How do I use this?

Ok here is a basic example below using the [Dapper](https://code.google.com/p/dapper-dot-net/) orm.

So basically we create our db class passing in the type of database connection we wish to use in `<>`. In this case we are using Sql server but in theory we could also use Postgres. We are making an annonymous function that gets passed x, which will be a database connection. This connection will already be created, with the proper connection string. We are then going to call dapper's QueryAsync which will return an IEnumerable of `MyReturnType` after calling MySproc. The Database connection will be disposed of without us having to worry.

```csharp
 var db = new DataBase<SqlConnection>("connectionstring");
 var result = db.QueryDatabaseAsync(x => x.QueryAsync<MyReturnType>("MySproc",

                new
                {
                    MySprocParameter = "awesome"
                },
                commandType: CommandType.StoredProcedure

                ));


```

## Action<>, Func<> Class<> what is this?

Ok, so I know as a new c# programmer generics seem intimidating. So I will walk you through this.

### MyClass<>

You may have classes ask for a generic. This means they are asking for a class. **Note** the word class. This will **not** be an object.

First the line `public class DatabaseBase<T> where T : class, IDbConnection, new()` declares that this class is public. This class is called DataBase. This class requires a generic which we will call T in this class. T will have to be a class (not interface, nor struct, or enum). This class must inhert from IDbConnection. This class can also be created without a constructor. Now Notice in my gist, where I am using my `using` statements. You will see `new T()` that is because we are newing the class we have passed as a generic.

### Func< T,TR>

Next up is a Func. Now Functions are a delegate, or method that when ran have a return type. Functions **Must have a return**. In this case the T is a passed in paramter. This means the delegate must be able to handle an IDbConnection somehow and return a TR.

In the following example we have a method declaration that takes in a function that has a result. This method also returns the result of the function (note the TR return type).

```csharp
public TResult QueryDatabase<TResult>(Func<T, TResult> action)
        {
            using (var x = new T())
            {
                x.ConnectionString = ConnectionString;
                return action(x);
            }
        }
```

### Action< T >

`Action<T>` is essentially the same as `Func<T,TR>` execpt actions do not have a return type. This would be more like a void than anything else. The T is a passed in parameter to the function. So you can pass in something like a database connection, but you will not have a return. Simple use case sql insert statement.
