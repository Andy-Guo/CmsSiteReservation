# API DOC

## register user
```
curl -s "http://127.0.0.1:9090/rs-server?Action=RegisterUser"  -H "Content-Type:application/json" -d '{"name":"testname","password":"password","description":"desc","email":"aa@email.com","phone_num":"13248898748"}'
```