package utils

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"
	"io/ioutil"
	"net/http"

	"openrs.com/siteReservation_server/api/log"
)

var (
	httpclient       *http.Client = &http.Client{}
	HTTPNoFound      error        = errors.New("Not Found")
	HTTPUnauthorized error        = errors.New("Unauthorized")
	HTTPUnexpectd    error        = errors.New("Unexpected")
)

// Send an HTTP request with method/header/body to url, return response body
func HTTPRequest(url, method string, header map[string]string, body interface{}) ([]byte, error) {
	input, err := json.Marshal(body)
	if err != nil {
		log.Error("[util/HttpRequest] [json.Marshal: %s]", err.Error())
		return nil, errors.New("Marshal body error")
	}
	req, err := http.NewRequest(method, url, bytes.NewReader(input))
	if err != nil {
		log.Error("[util/HttpRequest] [http.NewRequest: %s, method: %s, url: %s, header: %v, body: %s]",
			err.Error(), method, url, header, string(input))
		return nil, errors.New("New request error")
	}
	// Set Header
	for k, v := range header {
		req.Header.Add(k, v)
	}
	// Set User-Agent
	req.Header.Set("User-Agent", "LB-Server")

	log.Debug("[util/HttpRequest] [Curl: '%s']", genCurl(req, input))

	resp, err := httpclient.Do(req)
	if err != nil {
		log.Error("[util/HttpRequest] [HttpClient.Do: %s, method: %s, url: %s, header: %v, body: %s]",
			err.Error(), method, url, header, string(input))
		return nil, errors.New("Do request error")
	}
	res_body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		log.Error("[util/HttpRequest] [ioutil.ReadAll: %s]", err.Error())
		return nil, errors.New("Read response error")
	}
	switch resp.StatusCode / 10 {
	case 20:
		// OK
		return res_body, nil
	case 40:
		switch resp.StatusCode {
		case 400:
			return res_body, HTTPNoFound
		case 401:
			return res_body, HTTPUnauthorized
		case 404:
			return res_body, HTTPNoFound
		}
	}
	return res_body, HTTPUnexpectd
}

func JoinUrl(domain string, urls ...string) string {
	ret := domain
	for _, url := range urls {
		// TODO merge '/'
		ret += url
	}
	return ret
}

// Generate an curl command line string that can be run directly for debug
func genCurl(req *http.Request, body []byte) string {
	msg := "curl"
	msg += " -X " + req.Method
	msg += " " + req.URL.String()
	for k, vs := range req.Header {
		for _, v := range vs {
			msg += fmt.Sprintf(" -H '%s: %s'", k, v)
		}
	}
	if len(body) > 0 && string(body) != "null" {
		msg += " -d '" + string(body) + "'"
	}
	return msg
}
