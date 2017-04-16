package rs

type HttpUrl struct {
	Domain string  `json:"domain"`
	Type   uint32  `json:"type"`
	Path   string  `json:"path"`
	Action *Action `json:"action"`
}

type Action struct {
	Type    uint32 `json:"type"`
	Backend string `json:"backend"`
}
