title: 'Commiting a new file to git, through the github api'
tags:
  - c#
  - GitHub
  - Octokit
thumbnailImage: thumbnail.png
---

Recently I have been working on an application that basically has a github bot (aka user) fork a repo, commit some files, and submit a PR against someone's repo. When it came down to actually making a new git commit through the github API, I had quite a hard time. I figured it out with some help from a ruby [tutorial](http://mattgreensmith.net/2013/08/08/commit-directly-to-github-via-api-with-octokit/), and now I'm going to show you how to do it.

<!-- more -->

## Getting things going

Before we start, we need 2 things.

1. Install the [Octokit nuget package](https://www.nuget.org/packages/Octokit/).
2. Get a credential token
 1. You can get a token for a logged in user via [oauth for .net](http://www.oauthforaspnet.com/providers/github/)
 2. Or you can get a token for yourself (personal access token) by going to settings=>personal access tokens at github


## The Code

Ok so I'm going to walk you through the code...don't want to wait? scroll to the bottom ([or click here](#source)).


#### Forking the target repo

The first thing we need our user to do is create our github client object.

```csharp

//Create our Client
var client = new GitHubClient(new ProductHeaderValue("OurProgramName"))
{
    Credentials = new Credentials("YourCredentialTokenHere")
};


```

Then we should fork our target repo

```csharp

  var fork = await client.Repository.Forks.Create(owner, repoName, new NewRepositoryFork() { });

```

Afterwards we need to get the last commit for the default branch. You can replace fork.DefaultBranch with an actual branch name if you wish.

```csharp

var refs = await client.GitDatabase.Reference.GetAll(fork.Owner.Login, fork.Name);
//Get the latest commit for the default branch
var lastestCommit = await client.GitDatabase.Reference.Get(fork.Owner.Login, fork.Name, "heads/" + fork.DefaultBranch);
//Get the commit object for the "latest" commit in the default branch
var baseCommit = await client.GitDatabase.Commit.Get(fork.Owner.Login, fork.Name, lastestCommit.Object.Sha);

```


Now we need to make the data, and the commit.


```csharp

//Create the data
var blob = await client.GitDatabase.Blob.Create(fork.Owner.Login, fork.Name, new NewBlob() { Content = "I Am The Body of the file", Encoding = EncodingType.Utf8 });
var genTree = new NewTree() { BaseTree = baseCommit.Tree.Sha };
genTree.Tree.Add(new NewTreeItem() { Type = TreeType.Blob, Mode = "100644", Sha = blob.Sha, Path = "OurNewFile.md" });
var newTree = await client.GitDatabase.Tree.Create(fork.Owner.Login, fork.Name, genTree);
//make the commit
var commitSha = await client.GitDatabase.Commit.Create(fork.Owner.Login, fork.Name, new NewCommit("Commit Message Huzzahhh", newTree.Sha, refs.First().Object.Sha));

```


This line creates the content of the file you wish to add (note the Content property)

```csharp

var blob = await client.GitDatabase.Blob.Create(fork.Owner.Login, fork.Name, new NewBlob() { Content = "I Am The Body of the file", Encoding = EncodingType.Utf8 });

```
...and this line puts it into OurNewFile.md in a new tree (which I honestly don't know much about)

```csharp

genTree.Tree.Add(new NewTreeItem() { Type = TreeType.Blob, Mode = "100644", Sha = blob.Sha, Path = "OurNewFile.md" });

```

Then we actually make the commit

```csharp

var commitSha = await client.GitDatabase.Commit.Create(fork.Owner.Login, fork.Name, new NewCommit("Commit Message Huzzahhh", newTree.Sha, refs.First().Object.Sha));

```

Now we have to update our fork with our new commit


```csharp

  await client.GitDatabase.Reference.Update(fork.Owner.Login, fork.Name, $"heads/{fork.DefaultBranch}", new ReferenceUpdate(commitSha.Sha) { });

```

Then submit the PR!!!!

```csharp

  //submit the pr
  await client.PullRequest.Create(owner, repoName, new NewPullRequest("Add New File!!!!", $"{fork.Owner.Login}:{fork.DefaultBranch}", fork.DefaultBranch) { Body = "OMG I'm A PR!!!!" });

```

## The actual code huzzah!!!!
<a name="source"></a>

```csharp
public async Task CommitThings(string owner, string repoName)
        {
            //Create our Client
            var client = new GitHubClient(new ProductHeaderValue("OurProgramName"))
            {
                Credentials = new Credentials("YourCredentialTokenHere")
            };
            //get the repos for our token
            var repos = await client.Repository.GetAllForCurrent();
            //if we already have this repo we should delete it (that way we get a fresh copy)
            var existingRepo = repos.FirstOrDefault(a => a != null && a.Name.Equals(a.Name));
            if(existingRepo != null)
            {
                await client.Repository.Delete(existingRepo.Owner.Login, existingRepo.Name);
            }
            //create the fork
            var fork = await client.Repository.Forks.Create(owner, repoName, new NewRepositoryFork() { });
            //Get all references
            var refs = await client.GitDatabase.Reference.GetAll(fork.Owner.Login, fork.Name);
            //Get the latest commit for the default branch
            var lastestCommit = await client.GitDatabase.Reference.Get(fork.Owner.Login, fork.Name, "heads/" + fork.DefaultBranch);
            //Get the commit object for the "latest" commit in the default branch
            var baseCommit = await client.GitDatabase.Commit.Get(fork.Owner.Login, fork.Name, lastestCommit.Object.Sha);
            //Create the data
            var blob = await client.GitDatabase.Blob.Create(fork.Owner.Login, fork.Name, new NewBlob() { Content = "I Am The Body of the file", Encoding = EncodingType.Utf8 });
            var genTree = new NewTree() { BaseTree = baseCommit.Tree.Sha };
            genTree.Tree.Add(new NewTreeItem() { Type = TreeType.Blob, Mode = "100644", Sha = blob.Sha, Path = "OurNewFile.md" });
            var newTree = await client.GitDatabase.Tree.Create(fork.Owner.Login, fork.Name, genTree);
            //make the commit
            var commitSha = await client.GitDatabase.Commit.Create(fork.Owner.Login, fork.Name, new NewCommit("Commit Message Huzzahhh", newTree.Sha, refs.First().Object.Sha));
            await client.GitDatabase.Reference.Update(fork.Owner.Login, fork.Name, $"heads/{fork.DefaultBranch}", new ReferenceUpdate(commitSha.Sha) { });
            //submit the pr
            await client.PullRequest.Create(owner, repoName, new NewPullRequest("Add New File!!!!", $"{fork.Owner.Login}:{fork.DefaultBranch}", fork.DefaultBranch) { Body = "OMG I'm A PR!!!!" });
        }


```
