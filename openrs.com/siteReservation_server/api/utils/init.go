package utils

import (
	"regexp"
)

func init() {
	// init validator re: attr.go
	textRe = regexp.MustCompile(textP)
	uuidRe = regexp.MustCompile(uuidP)
	domainRe = regexp.MustCompile(domainP)
	urlpathRe = regexp.MustCompile(urlpathP)
}
