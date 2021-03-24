import UIKit

func getData() {
    let urlString = "https://api.sunrise-sunset.org/json?date=2020-8-1&lng=37.3230&lat=-122.0322&formatted=0"
    
    guard let url = URL(string: urlString) else {
        return
    }
    let task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
        guard let data = data, error == nil else {
            return
        }
        
        var result: APIResponse?
        do {
            result = try JSONDecoder().decode(APIResponse.self, from: data)
        }
        catch {
            print("Failed to decode with error: \(error)")
        }
        guard let final = result else {
            return
        }
        print("get data: \(data)")
        print(final.results.sunset)
        print(final.results.sunrise)
        print(final.results.day_length)

    })
    task.resume()
}
getData()

struct APIResponse: Codable {
    let results: APIResponseResults
    let status: String
}

struct APIResponseResults: Codable {
    let sunrise: String
    let sunset: String
    let solar_noon: String
    let day_length: Int
    let civil_twilight_begin: String
    let civil_twilight_end: String
    let nautical_twilight_begin: String
    let nautical_twilight_end: String
    let astronomical_twilight_begin: String
    let astronomical_twilight_end: String
}

/*
 
 {"results": {
    "sunrise":"2020-08-01T01:41:53+00:00",
    "sunset":"2020-08-01T17:32:06+00:00",
    "solar_noon":"2020-08-01T09:37:00+00:00",
    "day_length":57013,
    "civil_twilight_begin":"2020-08-01T02:26:16+00:00",
    "civil_twilight_end":"2020-08-01T16:47:43+00:00",
    "nautical_twilight_begin":"2020-08-01T03:14:14+00:00",
    "nautical_twilight_end":"2020-08-01T15:59:45+00:00",
    "astronomical_twilight_begin":"2020-08-01T04:00:11+00:00",
    "astronomical_twilight_end":"2020-08-01T15:13:48+00:00"
    },
 "status":"OK"}
 
 */
