package main

import (
	"context"
	"fmt"
	"os"

	"github.com/google/go-github/github"
	"golang.org/x/oauth2"
)

func printRepos(repos []*github.Repository) {
	for _, repo := range repos {
		fmt.Println(*repo.FullName)
	}
}

func initializeClient(token string) *github.Client {
	ts := oauth2.StaticTokenSource(
		&oauth2.Token{AccessToken: token},
	)
	tc := oauth2.NewClient(context.Background(), ts)
	return github.NewClient(tc)
}

func listAllUserRepos(client *github.Client) {
	opt := &github.RepositoryListOptions{
		ListOptions: github.ListOptions{PerPage: 100},
		Visibility:  "all",
	}

	for {
		repos, resp, err := client.Repositories.List(context.Background(), "", opt)
		if err != nil {
			fmt.Println(err)
			return
		}

		printRepos(repos)

		if resp.NextPage == 0 {
			break
		}
		opt.Page = resp.NextPage
	}
}

func listOrganizationRepos(client *github.Client, organization string) {

	opt := &github.RepositoryListByOrgOptions{
		ListOptions: github.ListOptions{PerPage: 100},
		Type:        "public",
	}

	for {
		repos, resp, err := client.Repositories.ListByOrg(context.Background(), organization, opt)
		if err != nil {
			fmt.Println(err)
			return
		}

		printRepos(repos)

		if resp.NextPage == 0 {
			break
		}
		opt.Page = resp.NextPage
	}
}

func main() {
	client := initializeClient(os.Args[1])

	listAllUserRepos(client)

	for _, org := range os.Args[2:] {
		listOrganizationRepos(client, org)
	}
}
