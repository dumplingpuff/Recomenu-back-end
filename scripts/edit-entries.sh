
curl --include --request PATCH http://localhost:3000/entries/9 \
  --header "Authorization: Token token=526cb6c4797df10ed3d8f7ef1424d13f" \
  --header "Content-Type: application/json" \
  --data '{
    "entries": {
      "restaurant": "bad",
      "dish": "dumplings"
    }
  }'
