package utils

import (
	"crypto/rand"
	"math/big"
	mathrandom "math/rand"
	"time"
)

var character = []byte("abcdefghijklmnopqrstuvwxyz0123456789")

var chLen = len(character)

func Uuid() string {
	var uuidLen = 10
	buf := make([]byte, uuidLen, uuidLen)
	max := big.NewInt(int64(chLen))
	for i := 0; i < uuidLen; i++ {
		random, err := rand.Int(rand.Reader, max)
		if err != nil {
			mathrandom.Seed(time.Now().UnixNano())
			buf[i] = character[mathrandom.Intn(chLen)]
			continue
		}
		buf[i] = character[random.Int64()]
	}
	return string(buf)
}
