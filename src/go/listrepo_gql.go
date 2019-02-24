package main

import (
	"context"
	"fmt"
	"os"

	"github.com/shurcooL/githubv4"
	"golang.org/x/oauth2"
)

type repo struct {
	Name          string
	NameWithOwner string
}

type pageinfo struct {
	EndCursor   githubv4.String
	HasNextPage bool
}

type repositories struct {
	Nodes    []repo
	PageInfo pageinfo
}

type reposQuery struct {
	Viewer struct {
		Login        string
		Repositories repositories `graphql:"repositories(first: 100, after: $repoCursor)"`
	}

	Organization struct {
		Login        string
		Repositories repositories `graphql:"repositories(first: 100, after: $orgRepoCursor)"`
	} `graphql:"organization(login: $orgName )"`
}

func buildParameters() map[string]interface{} {
	return map[string]interface{}{
		"repoCursor":    (*githubv4.String)(nil),
		"orgRepoCursor": (*githubv4.String)(nil),
		"orgName":       *githubv4.NewString("github"),
	}
}

func isDone(q reposQuery) bool {
	return !q.Viewer.Repositories.PageInfo.HasNextPage && !q.Organization.Repositories.PageInfo.HasNextPage
}

func pageForward(q reposQuery, variables map[string]interface{}) {
	variables["repoCursor"] = githubv4.NewString(q.Viewer.Repositories.PageInfo.EndCursor)
	variables["orgRepoCursor"] = githubv4.NewString(q.Organization.Repositories.PageInfo.EndCursor)
}

func initializeV4Client(token string) *githubv4.Client {
	sts := oauth2.StaticTokenSource(
		&oauth2.Token{AccessToken: token},
	)
	httpClient := oauth2.NewClient(context.Background(), sts)
	return githubv4.NewClient(httpClient)
}

func printReposFromThisPage(q reposQuery) {
	for _, repo := range q.Viewer.Repositories.Nodes {
		fmt.Println(repo.NameWithOwner)
	}

	for _, repo := range q.Organization.Repositories.Nodes {
		fmt.Println(repo.NameWithOwner)
	}
}

func main() {
	client := initializeV4Client(os.Args[1])

	var q reposQuery
	variables := buildParameters()
	variables["orgName"] = githubv4.String(os.Args[2])

	for {
		err := client.Query(context.Background(), &q, variables)
		if err != nil {
			fmt.Println(err)
		}

		printReposFromThisPage(q)

		if isDone(q) {
			break
		}

		pageForward(q, variables)
	}
}
