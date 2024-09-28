
# Lambda, Api Gateway, Route53

Configurar as credenciais aws_access_key_id e aws_secret_access_key com o comando 

```
aws configure
```

Ou adicionando as credenciais no arquivo ```~/.aws/credentials```

Deploy na AWS:

Verificar a formatação 
```
terraform fmt
```

Plan do código
```
terraform plan
```

Aplicar o plano, confirmar com yes.
```
terraform apply
```


As variáveis de output do Terraform devolvem valores necessários para executar a aplicação


Para conseguir o token execute o comando do output do ```terraform apply```

TokenId será gerado pelo **cognito_token_command** em linha de comando



Exemplo do comando gerado após o ```terraform apply``` 


```
aws cognito-idp admin-initiate-auth --user-pool-id us-east-1_Sic3ACieC --client-id 1055jmu2vrsqci7ejes14s04b7 --auth-flow ADMIN_NO_SRP_AUTH --auth-parameters USERNAME=user_rob_cognito,PASSWORD=w3ak-p455w0Wd
```

A resposta gerada terá o Token Id entre aspas e deve ser utilizado no Postman o Insomnia

Exemplo retorno do comando contendo o Token:


```
 "IdToken": "eyJraWQiOiJhU3RnTGZOTmVxRnpHN1VTWTVCXC9NTVFLRzF0cHM3b2R0WnpxNVNzQVE1ND0iLCJhbGciOiJSUzI1NiJ9.eyJvcmlnaW5fanRpIjoiMjg3MzNjMGQtYTI5Ny00Y2M3LThiMmMtZ
GQ1NDgzMmNkMWZjIiwic3ViIjoiNTQ3OGI0NDgtMzAzMS03MDdlLWRkMGEtNjEzMDgyNWVhZjIyIiwiYXVkIjoiNnViNzFiaDl2bTMzdHQwcW45NmcwOGpqNWgiLCJldmVudF9pZCI6IjZhNWI5M2FjLWEyMjItNDc1Ny1
hOWU4LWM0YWE4MDE4OGNhNiIsInRva2VuX3VzZSI6ImlkIiwiYXV0aF90aW1lIjoxNzI3NDg1MDE4LCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAudXMtZWFzdC0xLmFtYXpvbmF3cy5jb21cL3VzLWVhc3QtMV90S
3g5bVNCS3IiLCJjb2duaXRvOnVzZXJuYW1lIjoidXNlcl9yb2JfY29nbml0byIsImV4cCI6MTcyNzQ4ODYxOCwiaWF0IjoxNzI3NDg1MDE4LCJqdGkiOiJhZDlmOGI4Yy00YTM3LTQ0MmUtYmVhMy1hY2I3OTU4OWM2YWU
ifQ.K4gPTpJpOBfxmm8jgf085JZTBaBph94-UVvGSeEy5GOfaBSgVsRfbs2ayXYfiP80QX8Zcy10gIGcJDCh0sbM-8_dK0aTK36oOvr1RIatKLUzApqtMP1JVLS2b7zgkDx-2LjnPjboYl0gVZSy4LjfMSrzxJ3qt0qMMh
M10EOPHQE7QNNrwXl1IbnIkpgGckddobe4A9a2PA7ZlR4qOjdRGFmaPrvlw1al0B0C3_1ion-wFW8PkchjiFtBwzhjpVdbZKqsD7jFMoYb7KX9FoA77L9erdEplAoH6NqiVt_QULzz_00yirlz_AWsHlhWOpH2-ZVJNF_m
xCiqm61Ff2ue0Q"
```


## A variável deployment_invoke_url é a url da API

Exemplo de deployment_invoke_url:

```
https://6hhj27zd5h.execute-api.us-east-1.amazonaws.com/dev/
```

Adicionar **mypath** a url do endpoint como no exemplo abaixo

Com o Postman ou Insomnia envie um comando Post para

 https://6hhj27zd5h.execute-api.us-east-1.amazonaws.com/dev/mypath

Um payload pode ser adicionado ao body do Post:

```
{
  "mensagema": "msgvalueabcd1",
  "complemento": "complemvalueabcd1"
}
```

Após o envio com sucesso do pyload é possível confirmar a mensagem na fila Sqs da AWS.


Esse código complementa o código original sumeetninawe

Adicionei AWS Sqs que recebe filas pela api e Lambda

Código route53 está comentado e pode ser adaptado

Repos Terraform
https://github.com/sumeetninawe


https://spacelift.io/blog/terraform-api-gateway

https://github.com/sumeetninawe/tf-lambda-apig