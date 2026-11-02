package stripe

import (
	"encoding/json"
	"log"
	"os"
	"path/filepath"
)

type communityLinks struct {
	Discord string `json:"discord"`
}

func loadDiscordURL(staticDir string) string {
	path := filepath.Join(staticDir, "community.json")
	data, err := os.ReadFile(path)
	if err != nil {
		log.Fatalf("community: %s is missing; the Hugo build publishes it from params.social.discord: %v", path, err)
	}
	var links communityLinks
	if err := json.Unmarshal(data, &links); err != nil {
		log.Fatalf("community: %s is not valid JSON: %v", path, err)
	}
	if links.Discord == "" {
		log.Fatalf("community: %s carries no discord link", path)
	}
	return links.Discord
}
