curl --include --request POST http://localhost:3000/suggestions \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=f998644f1045d298b271658e00a434d5" \
  --data '{
    "suggestion": {
      "name": "Jim",
      "restaurant": "Boogers"
    }
  }'
