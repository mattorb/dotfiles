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

func initializeClient(token string) (context.Context, *github.Client) {
	ctx := context.Background()
	ts := oauth2.StaticTokenSource(
		&oauth2.Token{AccessToken: token},
	)
	tc := oauth2.NewClient(ctx, ts)
	return ctx, github.NewClient(tc)
}

func listAllUserRepos(ctx context.Context, client *github.Client) {
	opt := &github.RepositoryListOptions{
		ListOptions: github.ListOptions{PerPage: 100},
		Visibility:  "all",
	}

	for {
		repos, resp, err := client.Repositories.List(ctx, "", opt)
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

func listOrganizationRepos(ctx context.Context, client *github.Client, organization string) {

	opt := &github.RepositoryListByOrgOptions{
		ListOptions: github.ListOptions{PerPage: 100},
		Type:        "public",
	}

	for {
		repos, resp, err := client.Repositories.ListByOrg(ctx, organization, opt)
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
	ctx, client := initializeClient(os.Args[1])

	listAllUserRepos(ctx, client)

	for _, org := range os.Args[2:] {
		listOrganizationRepos(ctx, client, org)
	}
}
