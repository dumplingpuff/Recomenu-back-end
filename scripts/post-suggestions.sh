curl --include --request POST http://localhost:3000/suggestions \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=10c81ed89f6c8a1be810a9b47f65f430" \
  --data '{
    "suggestion": {
      "name": "Jim",
      "restaurant": "Boogers"
    }
  }'
