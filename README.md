# INSTALL

``` sh
cp .env.example .env
docker/setup
```

Set the output of the `docker/run rake secret` as the value of `SECRET_KEY_BASE` in your `.env` file.


# USAGE

```sh
docker/start
```

Once the rails server is up and running, the only API method available is at `/users` in `POST`.

You can use this cURL command to test it :
```sh
curl -X POST \
  http://localhost:3000/users \
  -H 'cache-control: no-cache' \
  -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
  -H 'postman-token: 3f5be129-6600-dc88-7176-d46d85b6eb97' \
  -F login=AAZ
```

# UNIT TESTS & LINTER

Some rspecs tests have been implemented covering User methods. A rubocop ruby linter has also been used.

```sh
docker/run rake secret
docker/run rubocop
```

# IMPORTANT NOTES

1. I chose to use ruby's Array [repeated_permutation](https://apidock.com/ruby/Array/repeated_permutation) method to generate all possible combinations of logins instead of implementing it from scratch via recursion, as it's part of the ruby core lib.
2. I chose not to store the possible combinations of logins (either through a yaml config file or a global var on init), as with the desired scope of 3 chars, the on-the-fly generation was totally doable with more than correct performances.
