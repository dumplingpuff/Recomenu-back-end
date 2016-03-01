curl --include --request POST http://localhost:3000/entries \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=f474e7251770790b254dd7e8d2e0e38c" \
  --data '{
    "entry": {
      "restaurant": "Boogers"
    }
  }'




  # TOKEN="token":"b9f6b814c0d20f7faf63dc043eaa3bc9"
  # USER_ID="8"
  #
  # BASE_URL="http://10.13.105.91:3000"
  # URL="${BASE_URL}/sign-out/${USER_ID}"
  #
  # curl ${URL} \
  # --silent \
  # --request DELETE \
  # --header "Content-Type: ${CONTENT_TYPE}" \
  # --header "Authorization: Token token=${TOKEN}" \
