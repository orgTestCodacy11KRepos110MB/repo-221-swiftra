/*
 The MIT License (MIT)

 Copyright (c) 2015 Shun Takebayashi

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
*/

public typealias Handler = (Request) -> (ResponseSource)

class Router {
    static let sharedRouter = Router()

    var patterns = [(String, Matcher, Handler)]()

    func addPattern(method method: String, pattern: Matcher, handler: Handler) {
        patterns.append((method, pattern, handler))
    }

    func dispatch(request: Request) -> Response? {
        for entry in patterns {
            if entry.0 == request.method {
                if let result = entry.1.match(request.path) {
                    if result.params.count > 0 {
                        let wrapped = ParameterizedRequest(
                            underlying: request,
                            parameters: result.params
                        )
                        return entry.2(wrapped).response()
                    }
                    return entry.2(request).response()
                }
            }
        }
        return nil
    }
}
