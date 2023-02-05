# MastodonKit

> This project was forked from https://github.com/MastodonKit/MastodonKit.

![MastodonKit](https://cloud.githubusercontent.com/assets/19753339/26019845/f64df19a-3778-11e7-8482-e09e187f3923.png)

## Difference

There are the following differences compared to the original.

### Request

`MastodonRequests`

- All requests are defined in `Requests`
  - This makes it easier to find the type of each request.
- Requests are typed for each API.
  - This makes it easy to define specific API requests as variables and arguments.

```swift
// Orifinal
let request = Statuses.create(status: "Mastodon's API is awesome!")
let request2 = Statuses.favourite(id: "1")
doSomethingForCreateRequest(request)
doSomethingForCreateRequest(request2) // I expect this line to be an error.
func doSomethingForCreateRequest(_ req: Request<Status>) {
    // do something
}

// Our
let request = Requests.Statuses.Create(status: "Mastodon's API is awesome!")
let request2 = Requests.Statuses.Favourite(id: "1")
doSomethingForCreateRequest(request)
doSomethingForCreateRequest(request2) // Error occurred!
func doSomethingForCreateRequest(_ req: Requests.Statuses.Create) {
    // do something
}
```

## How to Install

Only Swift Package Manager is supported.
