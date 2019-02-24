package main

import (
	"context"
	"fmt"
	"os"

	"github.com/shurcooL/githubv4"
	"golang.org/x/oauth2"
)

type repo struct {
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

func pageForward(q reposQuery, variables map[string]interface{}) bool {
	if !q.Viewer.Repositories.PageInfo.HasNextPage && !q.Organization.Repositories.PageInfo.HasNextPage {
		return false
	}

	variables["repoCursor"] = githubv4.NewString(q.Viewer.Repositories.PageInfo.EndCursor)
	variables["orgRepoCursor"] = githubv4.NewString(q.Organization.Repositories.PageInfo.EndCursor)

	return true
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

func listAllRepos(client *githubv4.Client, extraOrg string) {
	var q reposQuery
	variables := buildParameters()
	variables["orgName"] = githubv4.String(extraOrg)

	for {
		err := client.Query(context.Background(), &q, variables)
		if err != nil {
			fmt.Println(err)
		}

		printReposFromThisPage(q)

		if !pageForward(q, variables) {
			break
		}
	}
}

func main() {
	client := initializeV4Client(os.Args[1])

	listAllRepos(client, os.Args[2])
}
